/* F1 repro (design-condition-order.md review): a block's OWN sibling
   `@media` rewrite must not change what `CSS.merge` sees as its atoms'
   MERGE CONTEXT - that is a fact about this merge call site, not about
   `b`'s own, unrelated block-local ordering.

   `a` has one plain, never-rewritten `@media (min-width: 600px)`. `b`'s
   own block has a SECOND, overlapping `@media (min-width: 900px)` for
   the same property, so `b`'s 600px atom's PRINTED condition gets `and
   (not (min-width: 900px))` folded in - but its merge context must still
   read as plain `(min-width: 600px)`, exactly like `a`'s, so `CSS.merge
   a b` drops `a`'s atom the same way it would if `b` never had that
   second rule at all.

   Prints the three class strings directly (a real `.exe` run, not a
   hand-reconstructed hash) so the cram test pins the actual merge
   OUTCOME - whether `a`'s atom survives - not a guessed string. */

let a = [%css {|@media (min-width: 600px) { color: red; }|}];

let b = [%css
  {|
  @media (min-width: 600px) { color: blue; }
  @media (min-width: 900px) { color: green; }
|}
];

let merged = CSS.merge(a, b);

Printf.printf("a: %s\n", CSS.className(a));
Printf.printf("b: %s\n", CSS.className(b));
Printf.printf("merged: %s\n", CSS.className(merged));

/* `a` has exactly one atom - its own `_a_...` token, not the `label:`/
   `_id_` dev markers alongside it - so this is the one token whose
   presence in `merged` answers "did CSS.merge drop a's atom". */
let starts_with = (prefix, s) =>
  String.length(s) >= String.length(prefix)
  && String.sub(s, 0, String.length(prefix)) == prefix;
let atom_token_of = className =>
  className |> String.split_on_char(' ') |> List.find(starts_with("_a_"));
let a_atom = atom_token_of(CSS.className(a));
let merged_classes = String.split_on_char(' ', CSS.className(merged));
Printf.printf(
  "a's atom survives the merge: %b\n",
  List.mem(a_atom, merged_classes),
);
