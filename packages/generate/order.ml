(** Pure graph-ordering primitives. No I/O beyond the cycle warning (see
    [sort]), and no knowledge of [Generate]'s input type: callers own how a node
    maps to a name and how a referenced name resolves to an edge. This keeps the
    module reusable for PR 2 (library-level ordering groups nodes by library,
    collapses cross-library edges, then calls [sort] per group). *)

(** Module names a structure references, computed the way [ocamldep -modules]
    does. ppxlib freezes its own AST at a fixed internal OCaml version;
    [Selected_ast.To_ocaml.copy_structure] converts a parsed structure to the
    Parsetree of the compiler this generator is built with, which is exactly
    what compiler-libs [Depend] expects. Reusing the compiler's own
    free-module-name walk avoids maintaining a second one. Verified for this
    ppxlib/OCaml pairing against [ocamldep -modules] output; see the P1 decision
    in [.workplace/plans/generate-dependency-order_PLAN.md]. *)
let references (structure : Ppxlib.structure) : string list =
  let compiler_structure =
    Ppxlib.Selected_ast.To_ocaml.copy_structure structure
  in
  Depend.free_structure_names := Depend.String.Set.empty;
  Depend.add_implementation Depend.String.Map.empty compiler_structure;
  Depend.String.Set.elements !Depend.free_structure_names

(** Kahn's algorithm that always breaks ties on the smallest [key] among ready
    nodes, so the output matches the input order (assuming the caller lists
    nodes in that order already) unless an edge forces a change. This keeps the
    aggregator's output diff minimal when most files don't reference each other.

    [edges n] lists the nodes [n] depends on (must be emitted before [n]).

    In-degree is tracked incrementally: emitting a node walks only the keys it
    actually blocks (a [dependents] map, built once), and the ready set is a
    sorted [Set] so popping the smallest ready key is O(log n). An earlier
    version re-filtered and re-sorted every remaining node on every emission
    (O(n^2 log n)); measured at 5.7s of a 9.4s run on a 5,824-file input.

    A real dependency graph among already-compiled OCaml modules cannot cycle:
    dune would have refused to build it. A cycle here is therefore necessarily
    an artifact of how the caller resolved a referenced name to a node (PR 1's
    ambiguous-name heuristic can pick an edge a real build wouldn't have). We
    never fail the build over an ordering problem: warn once naming the stuck
    nodes, drop the blocking edge whose dependent (source) key sorts
    alphabetically last, and keep going. Dropping only ever removes edges from a
    finite graph, so this always terminates.

    Two nodes sharing a [key] collapse into one (the later one in [nodes] wins,
    since [node_of_key] is filled with [Hashtbl.replace]); [node_count] below is
    therefore the number of distinct keys, not [List.length nodes], so the
    emission loop's termination bound matches what can actually be emitted. *)
let sort (type a) ~(nodes : a list) ~(edges : a -> a list) ~(key : a -> string)
  : a list =
  let module KeySet = Set.Make (String) in
  let node_of_key : (string, a) Hashtbl.t =
    Hashtbl.create (List.length nodes)
  in
  List.iter (fun n -> Hashtbl.replace node_of_key (key n) n) nodes;
  let node_count = Hashtbl.length node_of_key in
  (* [pending.(key n)] is the dependency keys of [n] still to be emitted,
     restricted to keys in [nodes] (an edge to a node outside the input set,
     or to [n] itself, contributes nothing to order and is dropped up
     front). Mutated as those dependencies are emitted, via [dependents]. *)
  let pending : (string, string list ref) Hashtbl.t =
    Hashtbl.create node_count
  in
  let dependents : (string, string) Hashtbl.t = Hashtbl.create node_count in
  List.iter
    (fun n ->
      let own_key = key n in
      let deps =
        edges n
        |> List.map key
        |> List.filter (fun k -> k <> own_key && Hashtbl.mem node_of_key k)
      in
      Hashtbl.replace pending own_key (ref deps);
      List.iter (fun dep -> Hashtbl.add dependents dep own_key) deps)
    nodes;
  let by_key a b = String.compare (key a) (key b) in
  let ready =
    ref
      (List.fold_left
         (fun acc n ->
           if !(Hashtbl.find pending (key n)) = [] then KeySet.add (key n) acc
           else acc)
         KeySet.empty nodes)
  in
  let emitted = Hashtbl.create node_count in
  let result = ref [] in
  let emit k =
    ready := KeySet.remove k !ready;
    Hashtbl.replace emitted k ();
    result := Hashtbl.find node_of_key k :: !result;
    Hashtbl.find_all dependents k
    |> List.iter (fun dependent ->
      let deps = Hashtbl.find pending dependent in
      deps := List.filter (fun d -> d <> k) !deps;
      if !deps = [] then ready := KeySet.add dependent !ready)
  in
  while Hashtbl.length emitted < node_count do
    match KeySet.min_elt_opt !ready with
    | Some k -> emit k
    | None ->
      let left =
        List.filter (fun n -> not (Hashtbl.mem emitted (key n))) nodes
      in
      let left_keys = List.sort String.compare (List.map key left) in
      let left_key_set = KeySet.of_list left_keys in
      let blocking =
        left
        |> List.concat_map (fun n ->
          !(Hashtbl.find pending (key n))
          |> List.filter (fun dep -> KeySet.mem dep left_key_set)
          |> List.map (fun dep -> key n, dep))
        |> List.sort (fun (s1, _) (s2, _) -> String.compare s2 s1)
      in
      (match blocking with
      | (source, dep) :: _ ->
        Printf.eprintf
          "styled-ppx: dependency cycle among %s; dropping the edge from %s to \
           %s to keep a deterministic order\n\
           %!"
          (String.concat ", " left_keys)
          source dep;
        let deps = Hashtbl.find pending source in
        deps := List.filter (fun d -> d <> dep) !deps;
        if !deps = [] then ready := KeySet.add source !ready
      | [] ->
        (* [left] is non-empty but no stuck-to-stuck edge exists: cannot
           happen given [pending] only holds in-set keys, but emit the
           alphabetically smallest left node rather than loop forever. *)
        (match List.sort by_key left with
        | n :: _ -> emit (key n)
        | [] -> ()))
  done;
  List.rev !result
