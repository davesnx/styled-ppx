(** Poisoned aliases of [Stdlib] and its most common submodules.

    This module is opened (via [-open]) in every compilation unit of the
    styled-ppx runtimes, together with [-alert @banned], which turns any use
    of the aliases below into a compile error.

    Rationale: the runtime is compiled for both native (ocamlopt) and JS
    (melange). Direct [Stdlib] usage either drags melange's stdlib JS into
    user bundles or diverges in behaviour between targets. All stdlib-like
    functionality must go through {!Kloth}, which provides a single
    interface with per-target implementations.

    Escape hatch: a deliberate use can be allowed with
    [[@alert "-banned"]] on the expression, or [[@@@alert "-banned"]] for a
    whole file (as done in [Kloth] itself, the only place allowed to touch
    [Stdlib]). *)

[@@@alert "-banned"]

module Stdlib = Stdlib [@@alert banned "Use Kloth instead of Stdlib in the styled-ppx runtime"]

(* Submodules of Stdlib that would otherwise be reachable unqualified. *)
module Array = Stdlib.Array [@@alert banned "Use Kloth.Array instead"]
module ArrayLabels = Stdlib.ArrayLabels [@@alert banned "Use Kloth.Array instead"]
module Buffer = Stdlib.Buffer [@@alert banned "Use Kloth instead"]
module Bytes = Stdlib.Bytes [@@alert banned "Use Kloth instead"]
module Char = Stdlib.Char [@@alert banned "Use Kloth instead"]
module Filename = Stdlib.Filename [@@alert banned "Use Kloth instead"]
module Float = Stdlib.Float [@@alert banned "Use Kloth.Float instead"]
module Format = Stdlib.Format [@@alert banned "Use Kloth instead"]
module Fun = Stdlib.Fun [@@alert banned "Use Kloth.Fun instead"]
module Hashtbl = Stdlib.Hashtbl [@@alert banned "Use Kloth instead"]
module Int = Stdlib.Int [@@alert banned "Use Kloth.Int instead"]
module Lazy = Stdlib.Lazy [@@alert banned "Use Kloth instead"]
module List = Stdlib.List [@@alert banned "Use Kloth.List instead"]
module ListLabels = Stdlib.ListLabels [@@alert banned "Use Kloth.List instead"]
module Map = Stdlib.Map [@@alert banned "Use Kloth instead"]
module Obj = Stdlib.Obj [@@alert banned "Obj is banned in the styled-ppx runtime"]
module Option = Stdlib.Option [@@alert banned "Use Kloth.Option instead"]
module Printf = Stdlib.Printf [@@alert banned "Use Kloth instead"]
module Queue = Stdlib.Queue [@@alert banned "Use Kloth instead"]
module Random = Stdlib.Random [@@alert banned "Use Kloth instead"]
module Result = Stdlib.Result [@@alert banned "Use Kloth instead"]
module Seq = Stdlib.Seq [@@alert banned "Use Kloth instead"]
module Set = Stdlib.Set [@@alert banned "Use Kloth instead"]
module Stack = Stdlib.Stack [@@alert banned "Use Kloth instead"]
module String = Stdlib.String [@@alert banned "Use Kloth.String instead"]
module StringLabels = Stdlib.StringLabels [@@alert banned "Use Kloth.String instead"]
module Sys = Stdlib.Sys [@@alert banned "Use Kloth instead"]

(* Unqualified Stdlib conversion and printing functions. Primitives such as
   [+], [^], [compare], [min], [max], [fst], [snd], [not], [raise],
   [failwith] and friends remain available. *)
val string_of_int : int -> string [@@alert banned "Use Kloth.Int.to_string instead"]
val string_of_float : float -> string [@@alert banned "Use Kloth.Float.to_string instead"]
val string_of_bool : bool -> string [@@alert banned "Use Kloth instead"]
val int_of_string : string -> int [@@alert banned "Use Kloth instead"]
val int_of_string_opt : string -> int option [@@alert banned "Use Kloth instead"]
val float_of_string : string -> float [@@alert banned "Use Kloth instead"]
val float_of_string_opt : string -> float option [@@alert banned "Use Kloth instead"]
val bool_of_string : string -> bool [@@alert banned "Use Kloth instead"]
val bool_of_string_opt : string -> bool option [@@alert banned "Use Kloth instead"]
val print_string : string -> unit [@@alert banned "The styled-ppx runtime must not print"]
val print_endline : string -> unit [@@alert banned "The styled-ppx runtime must not print"]
val print_newline : unit -> unit [@@alert banned "The styled-ppx runtime must not print"]
val print_char : char -> unit [@@alert banned "The styled-ppx runtime must not print"]
val print_int : int -> unit [@@alert banned "The styled-ppx runtime must not print"]
val print_float : float -> unit [@@alert banned "The styled-ppx runtime must not print"]
val prerr_string : string -> unit [@@alert banned "The styled-ppx runtime must not print"]
val prerr_endline : string -> unit [@@alert banned "The styled-ppx runtime must not print"]
