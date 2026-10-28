(** Pure graph-ordering primitives. No I/O beyond the cycle warning (see
    [sort]), and no knowledge of [Generate]'s input type: callers own how a node
    maps to a name and how a referenced name resolves to an edge. This keeps the
    module reusable both for ordering modules within one library and for
    ordering libraries themselves (library-level ordering groups nodes by
    library, collapses cross-library edges, then calls [sort] per group). *)

(** Module names a structure references, computed the way [ocamldep -modules]
    does. ppxlib freezes its own AST at a fixed internal OCaml version;
    [Selected_ast.To_ocaml.copy_structure] converts a parsed structure to the
    Parsetree of the compiler this generator is built with, which is exactly
    what compiler-libs [Depend] expects. Reusing the compiler's own
    free-module-name walk avoids maintaining a second one. Verified for this
    ppxlib/OCaml pairing against [ocamldep -modules] output. *)
let references (structure : Ppxlib.structure) : string list =
  let compiler_structure =
    Ppxlib.Selected_ast.To_ocaml.copy_structure structure
  in
  Depend.free_structure_names := Depend.String.Set.empty;
  Depend.add_implementation Depend.String.Map.empty compiler_structure;
  Depend.String.Set.elements !Depend.free_structure_names

(** The structure with every open scope cut out: the body of [M.( ... )] and
    [let open M in ...], the pattern under [M.( ... )], and every item after a
    structure-level or signature-level [open] or [include]. The opened module
    itself stays. *)
let without_open_scopes =
  let loc = Ppxlib.Location.none in
  object
    inherit Ppxlib.Ast_traverse.map as super

    method! expression e =
      match e.pexp_desc with
      | Pexp_open (declaration, _) ->
        super#expression
          { e with pexp_desc = Pexp_open (declaration, [%expr ()]) }
      | _ -> super#expression e

    method! pattern p =
      match p.ppat_desc with
      | Ppat_open (lid, _) ->
        {
          p with
          ppat_desc = Ppat_open (lid, Ppxlib.Ast_builder.Default.ppat_any ~loc);
        }
      | _ -> super#pattern p

    method! structure items =
      let rec keep = function
        | [] -> []
        | ({ Ppxlib.pstr_desc = Pstr_open _ | Pstr_include _; _ } as item) :: _
          ->
          [ item ]
        | item :: rest -> item :: keep rest
      in
      super#structure (keep items)

    method! signature items =
      let rec keep = function
        | [] -> []
        | ({ Ppxlib.psig_desc = Psig_open _ | Psig_include _; _ } as item) :: _
          ->
          [ item ]
        | item :: rest -> item :: keep rest
      in
      super#signature (keep items)
  end

(** The module names of {!references} that occur outside any open scope. After
    [open M], a bare [N] may be the submodule [M.N], so only these names can
    name a module of another library. *)
let references_outside_opens (structure : Ppxlib.structure) : string list =
  references (without_open_scopes#structure structure)

(** The line of the first longident whose head is each referenced module name,
    for diagnostics. *)
let first_lines (structure : Ppxlib.structure) : (string * int) list =
  let lines = Hashtbl.create 64 in
  let collector =
    object
      inherit Ppxlib.Ast_traverse.iter as super

      method! longident_loc { txt; loc } =
        let head =
          match Ppxlib.Longident.flatten_exn txt with
          | head :: _ :: _ -> Some head
          | [ _ ] | [] -> None
          | exception _ -> None
        in
        (match head with
        | Some head when not (Hashtbl.mem lines head) ->
          Hashtbl.add lines head loc.loc_start.pos_lnum
        | _ -> ());
        super#longident_loc { txt; loc }

      method! module_expr m =
        (match m.pmod_desc with
        | Pmod_ident { txt = Lident head; loc }
          when not (Hashtbl.mem lines head) ->
          Hashtbl.add lines head loc.loc_start.pos_lnum
        | _ -> ());
        super#module_expr m
    end
  in
  collector#structure structure;
  Hashtbl.fold (fun name line acc -> (name, line) :: acc) lines []

(** Strongly connected components (Tarjan). Maps each of [nodes] to the index of
    its component; two keys share an index exactly when each can reach the
    other. [edges k] must return only keys from [nodes]. *)
let components ~(nodes : string list) ~(edges : string -> string list) :
  (string, int) Hashtbl.t =
  let index = Hashtbl.create (List.length nodes) in
  let low = Hashtbl.create (List.length nodes) in
  let on_stack = Hashtbl.create (List.length nodes) in
  let component = Hashtbl.create (List.length nodes) in
  let stack = ref [] in
  let next_index = ref 0 in
  let next_component = ref 0 in
  let rec visit k =
    Hashtbl.replace index k !next_index;
    Hashtbl.replace low k !next_index;
    incr next_index;
    stack := k :: !stack;
    Hashtbl.replace on_stack k ();
    List.iter
      (fun d ->
        if not (Hashtbl.mem index d) then begin
          visit d;
          Hashtbl.replace low k (min (Hashtbl.find low k) (Hashtbl.find low d))
        end
        else if Hashtbl.mem on_stack d then
          Hashtbl.replace low k
            (min (Hashtbl.find low k) (Hashtbl.find index d)))
      (edges k);
    if Hashtbl.find low k = Hashtbl.find index k then begin
      let rec pop () =
        match !stack with
        | top :: rest ->
          stack := rest;
          Hashtbl.remove on_stack top;
          Hashtbl.replace component top !next_component;
          if top <> k then pop ()
        | [] -> ()
      in
      pop ();
      incr next_component
    end
  in
  List.iter (fun k -> if not (Hashtbl.mem index k) then visit k) nodes;
  component

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
    an artifact of how the caller resolved a referenced name to a node (its
    ambiguous-name heuristic can pick an edge a real build wouldn't have). We
    never fail the build over an ordering problem: among the stuck edges that
    lie on a cycle (both ends in one strongly connected component), drop the one
    with the fewest references ([edge_detail source dep], 1 when [None]), then
    the one whose dependent (source) key sorts alphabetically last, warn naming
    that cycle's nodes and the edge's detail, and keep going. A node that only
    depends on a cycle keeps its edge. Dropping only ever removes edges from a
    finite graph, so this always terminates.

    Two nodes sharing a [key] collapse into one (the later one in [nodes] wins,
    since [node_of_key] is filled with [Hashtbl.replace]); [node_count] below is
    therefore the number of distinct keys, not [List.length nodes], so the
    emission loop's termination bound matches what can actually be emitted. *)
let sort (type a) ~(edge_detail : string -> string -> (int * string) option)
  ~(nodes : a list) ~(edges : a -> a list) ~(key : a -> string) : a list =
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
      if not (Hashtbl.mem pending own_key) then begin
        let winner = Hashtbl.find node_of_key own_key in
        let deps =
          edges winner
          |> List.map key
          |> List.filter (fun k -> k <> own_key && Hashtbl.mem node_of_key k)
          |> List.sort_uniq String.compare
        in
        Hashtbl.replace pending own_key (ref deps);
        List.iter (fun dep -> Hashtbl.add dependents dep own_key) deps
      end)
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
      (* A dependent whose edge to [k] was dropped as a cycle breaker may
         already be emitted; re-adding it would emit it twice. *)
      if not (Hashtbl.mem emitted dependent) then begin
        let deps = Hashtbl.find pending dependent in
        deps := List.filter (fun d -> d <> k) !deps;
        if !deps = [] then ready := KeySet.add dependent !ready
      end)
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
      let stuck_deps k =
        !(Hashtbl.find pending k)
        |> List.filter (fun dep -> KeySet.mem dep left_key_set)
      in
      let component = components ~nodes:left_keys ~edges:stuck_deps in
      let blocking =
        left_keys
        |> List.concat_map (fun k ->
          stuck_deps k
          |> List.filter (fun dep ->
            Hashtbl.find component dep = Hashtbl.find component k)
          |> List.map (fun dep -> k, dep))
        |> List.map (fun (source, dep) -> (source, dep), edge_detail source dep)
        |> List.sort (fun ((s1, _), d1) ((s2, _), d2) ->
          let weight = function Some (n, _) -> n | None -> 1 in
          match compare (weight d1) (weight d2) with
          | 0 -> String.compare s2 s1
          | c -> c)
      in
      (match blocking with
      | ((source, dep), detail) :: _ ->
        let cycle =
          List.filter
            (fun k -> Hashtbl.find component k = Hashtbl.find component source)
            left_keys
        in
        let why =
          match detail with
          | Some (count, example) ->
            Printf.sprintf " (%d reference%s, e.g. %s)" count
              (if count = 1 then "" else "s")
              example
          | None -> ""
        in
        Printf.eprintf
          "styled-ppx: dependency cycle among %s; dropping the edge from %s to \
           %s%s to keep a deterministic order\n\
           %!"
          (String.concat ", " cycle) source dep why;
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
