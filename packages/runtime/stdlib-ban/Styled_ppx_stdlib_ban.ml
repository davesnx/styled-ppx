(* See the .mli for documentation. The alerts live on the signature; this
   file only provides the aliases. *)

[@@@alert "-banned"]

module Stdlib = Stdlib
module Array = Stdlib.Array
module ArrayLabels = Stdlib.ArrayLabels
module Buffer = Stdlib.Buffer
module Bytes = Stdlib.Bytes
module Char = Stdlib.Char
module Filename = Stdlib.Filename
module Float = Stdlib.Float
module Format = Stdlib.Format
module Fun = Stdlib.Fun
module Hashtbl = Stdlib.Hashtbl
module Int = Stdlib.Int
module Lazy = Stdlib.Lazy
module List = Stdlib.List
module ListLabels = Stdlib.ListLabels
module Map = Stdlib.Map
module Obj = Stdlib.Obj
module Option = Stdlib.Option
module Printf = Stdlib.Printf
module Queue = Stdlib.Queue
module Random = Stdlib.Random
module Result = Stdlib.Result
module Seq = Stdlib.Seq
module Set = Stdlib.Set
module Stack = Stdlib.Stack
module String = Stdlib.String
module StringLabels = Stdlib.StringLabels
module Sys = Stdlib.Sys

let string_of_int = Stdlib.string_of_int
let string_of_float = Stdlib.string_of_float
let string_of_bool = Stdlib.string_of_bool
let int_of_string = Stdlib.int_of_string
let int_of_string_opt = Stdlib.int_of_string_opt
let float_of_string = Stdlib.float_of_string
let float_of_string_opt = Stdlib.float_of_string_opt
let bool_of_string = Stdlib.bool_of_string
let bool_of_string_opt = Stdlib.bool_of_string_opt
let print_string = Stdlib.print_string
let print_endline = Stdlib.print_endline
let print_newline = Stdlib.print_newline
let print_char = Stdlib.print_char
let print_int = Stdlib.print_int
let print_float = Stdlib.print_float
let prerr_string = Stdlib.prerr_string
let prerr_endline = Stdlib.prerr_endline
