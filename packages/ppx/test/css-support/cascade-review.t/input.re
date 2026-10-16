/* Cases found by reviewing the twin and in-block removal work. V01 is an
   interpolation dropped by a later base declaration, V02 to V04 twin a selector
   that repeats the atom class, V05 and V06 raise a twin over a block's own
   atoms, V07 and V08 pin the name of a group's variable. */

let show = (id, parts, result) => {
  List.iter(
    ((name, styles)) => {
      Printf.printf("%s %s: %s\n", id, name, CSS.className(styles));
      let style = ReactDOM.Style.to_string(CSS.styles(styles));
      if (style != "") {
        Printf.printf("%s %s style: %s\n", id, name, style);
      };
    },
    parts,
  );
  Printf.printf("%s result: %s\n", id, CSS.className(result));
  let style = ReactDOM.Style.to_string(CSS.styles(result));
  if (style != "") {
    Printf.printf("%s result style: %s\n", id, style);
  };
};

let show_one = (id, styles) => {
  Printf.printf("%s: %s\n", id, CSS.className(styles));
  let style = ReactDOM.Style.to_string(CSS.styles(styles));
  if (style != "") {
    Printf.printf("%s style: %s\n", id, style);
  };
};

/* V01: a base declaration after `@media { color: $(a) }` drops the @media atom.
   `a` must stay used (no unused-variable error), as for the same two
   declarations in one context, and its value is still set inline, like the
   value `CSS.merge` leaves behind when it drops a class.
   intended: red */
let v01 = a => [%css {|
  @media (max-width: 100px) { color: $(a); }
  color: red;
|}];
show_one("V01", v01(CSS.blue));

/* V02: C is `& + &`, merged after a `&:hover` atom of the same property
   intended: C on the second of two siblings, whether or not the first has the twin */
let v02_f = [%css {|
  &:hover { border-top-color: rgb(12, 0, 0); }
|}];
let v02_c = [%css {|
  & + & { border-top-color: rgb(13, 0, 0); }
|}];
show("V02", [("f", v02_f), ("c", v02_c)], CSS.merge(v02_f, v02_c));

/* V03: as V02 with `& ~ &` */
let v03_f = [%css {|
  &:hover { border-top-color: rgb(22, 0, 0); }
|}];
let v03_c = [%css {|
  & ~ & { border-top-color: rgb(23, 0, 0); }
|}];
show("V03", [("f", v03_f), ("c", v03_c)], CSS.merge(v03_f, v03_c));

/* V04: as V02 with `& &` */
let v04_f = [%css {|
  &:hover { border-top-color: rgb(32, 0, 0); }
|}];
let v04_c = [%css {|
  & & { border-top-color: rgb(33, 0, 0); }
|}];
show("V04", [("f", v04_f), ("c", v04_c)], CSS.merge(v04_f, v04_c));

/* V05: a block's own atoms follow the atom that raised one of them. A is an
   @media `border-top`. X is `border-color`: it overlaps A on the top colour but
   does not cover it, so merging raises X over A. Y is `border-right-color`
   under another @media in the same block as X: it overlaps X and not A, and
   must follow X.
   intended: Y wins the right colour while its @media holds */
let v05_a = [%css {|
  @media (max-width: 500px) { border-top: 1px solid rgb(51, 0, 0); }
|}];
let v05_b = [%css {|
  border-color: rgb(52, 0, 0);
  @media (max-width: 600px) { border-right-color: rgb(53, 0, 0); }
|}];
show("V05", [("a", v05_a), ("b", v05_b)], CSS.merge(v05_a, v05_b));

/* V06: control for V05: without A, b needs no twin */
show_one("V06", v05_b);

/* V07, V08: the variable of a group of atoms that interpolate `p` does not
   depend on which members survive. V08 adds a base `padding-top` that drops
   the @media member; the base and `:hover` members keep their class and variable.
   intended: the `padding-left` and `:hover` classes are the same in both */
let v07 = p => [%css {|
  padding-left: $(p);
  @media (max-width: 701px) { padding-top: $(p); }
  &:hover { padding-top: $(p); }
|}];
let v08 = p => [%css {|
  padding-left: $(p);
  @media (max-width: 701px) { padding-top: $(p); }
  &:hover { padding-top: $(p); }
  padding-top: 0;
|}];
show_one("V07", v07(CSS.px(3)));
show_one("V08", v08(CSS.px(3)));
