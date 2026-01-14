open Rule.Let
open Rule.Pattern
module Parser = Styled_ppx_css_parser.Parser

type range = int * int option

let one = Fun.id

let optional rule =
  Rule.Data.bind rule (fun value ->
      let value = match value with Ok value -> Some value | Error _ -> None in
      return_match value)

let match_n_values (min, max) sep rule =
  let rule_with_sep = Rule.Match.bind sep (fun () -> rule) in
  let rec match_until_fails values =
    Rule.Data.bind rule_with_sep (fun value ->
        let length = List.length values + if Result.is_ok value then 1 else 0 in
        let hit_min = length >= min in
        let hit_max = match max with Some m -> length >= m | None -> false in
        match value with
        | Ok value ->
            if hit_max then return_match (List.rev (value :: values))
            else match_until_fails (value :: values)
        | Error last_error ->
            if hit_min then return_match (List.rev values)
            else return_data (Error last_error))
  in
  Rule.Data.bind rule (fun value ->
      match value with
      | Ok value -> match_until_fails [ value ]
      | Error last_error ->
          if min = 0 then return_data (Ok [])
          else return_data (Error last_error))

let zero_or_more rule = match_n_values (0, None) identity rule
let one_or_more rule = match_n_values (1, None) identity rule
let repeat_by_sep sep (min, max) rule = match_n_values (min, max) sep rule
let repeat (min, max) rule = repeat_by_sep identity (min, max) rule

let repeat_by_comma (min, max) rule =
  repeat_by_sep (expect Parser.COMMA) (min, max) rule

let at_least_one rule =
  Rule.Match.bind rule (fun values ->
      let have_one = List.exists Option.is_some values in
      return_data
        (if have_one then Ok values else Error [ "should match at least one" ]))

let at_least_one_2 rule =
  Rule.Match.bind rule (fun (a, b) ->
      Rule.Match.bind
        (let a = Option.map (fun a -> `A a) a in
         let b = Option.map (fun b -> `B b) b in
         at_least_one (return_match [ a; b ]))
        (fun _ -> return_match (a, b)))
