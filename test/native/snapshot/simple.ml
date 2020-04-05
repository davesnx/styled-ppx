(* Shoudn't break other ppxs with similar APIs *)
module StateLenses = [%lenses
  type state = {
    email: string;
    age: int;
  }
]

module Component = [%styled ("display: block")]
module Component = [%styled.section {|
  display: flex;
  justify-content: center;
|}]

let var = "#333333"
module Component = [%styled {j|
  color: $var;
  display: block;
|j}]

let space = "10"
let b = "flex"
  (* margin: 10px $(space)px; *)
module Component = [%styled {j|
  margin: $(space)px;
  display: $b;
|j}]

(* module Component = [%styled fun ~var -> {j|
  color: $var;
  display: block;
|j}]
 *)
