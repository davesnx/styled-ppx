(* Shoudn't break other ppxs with similar APIs *)
module StateLenses = [%lenses
  type state = {
    email: string;
    age: int;
  }
]

module Component = [%styled ("display: block")]
module Component = [%styled.section ("display: block")]

module Component =
  [%styled
    fun ~color ~mierda -> ({| color: color; display: block; |})]

(* module Component =
  [%styled
    fun () -> ("display: block")]
 *)
