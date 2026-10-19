let show = (id, a, b) => {
  Printf.printf("%s ab: %s\n", id, CSS.className(CSS.merge(a, b)));
  Printf.printf("%s ba: %s\n", id, CSS.className(CSS.merge(b, a)));
};

Printf.printf(
  "lvl: %s\n",
  CSS.className(CSS.merge(CSS.merge(Lvl.a, Lvl.b), Lvl.c)),
);
Printf.printf(
  "lvl_sel: %s\n",
  CSS.className(CSS.merge(CSS.merge(Lvl_sel.a, Lvl_sel.b), Lvl_sel.c)),
);
Printf.printf(
  "cross: %s\n",
  CSS.className(CSS.merge(CSS.merge(Xa.a, Xb.b), Xb.c)),
);
show("subject x y", Subject.x, Subject.y);
show("subject child descendant", Subject.child, Subject.descendant);
show("subject legacy modern", Subject.legacy, Subject.modern);
show("weight is class", Weight.is_list, Weight.one_class);
show("weight escaped hover", Weight.escaped, Weight.hover);
show("weight attribute focus", Weight.attr, Weight.focus);
