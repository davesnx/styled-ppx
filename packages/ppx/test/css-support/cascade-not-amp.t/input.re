/* `&` inside `:not(...)`: the twin must not swap the negated class, as the
   twin selector `:not(._t1_X:not(x-))` matches every element that lacks the
   twin, so an atom that was never merged applied under its own root.
   N1 is the atom alone, N2 merges it after another atom of the same root, N3
   keeps `&` both inside and outside the `:not`, N4 and N5 do it in two compounds. Values are unique per case.
   intended: the plain rule excludes `_a_X` and both twin classes, and no twin
   rule exists for the negated class. */

let show = (id, styles) =>
  Printf.printf("%s: %s\n", id, CSS.className(styles));

let n1 = [%css {|
  :not(&) > a { color: rgb(11, 0, 0); }
|}];

let n2_base = [%css {|
  & > a { color: rgb(21, 0, 0); }
|}];
let n2_not = [%css {|
  :not(&) > a { color: rgb(22, 0, 0); }
|}];

let n3 = [%css {|
  &:hover:not(&.on) { color: rgb(31, 0, 0); }
|}];

show("N1", n1);
show("N2 base", n2_base);
show("N2 not", n2_not);
show("N2 merged", CSS.merge(n2_base, n2_not));
show("N3", n3);

/* N4: `&` positive in one compound and negated alone in another. N5: negated
   alone first, positive after. */
let n4 = [%css {|
  & :not(&) { color: rgb(41, 0, 0); }
|}];
let n5 = [%css {|
  :not(&) + & { color: rgb(51, 0, 0); }
|}];

show("N4", n4);
show("N5", n5);

/* N6, N7: a double negation is the class itself, so it keeps the twin swap.
   `:not(:not(&)) > a` must apply under a root that carries the atom. */
let n6 = [%css {|
  :not(:not(&)) > a { color: rgb(61, 0, 0); }
|}];
let n7 = [%css {|
  :not(:not(&).x) > a { color: rgb(71, 0, 0); }
|}];

show("N6", n6);
show("N7", n7);
