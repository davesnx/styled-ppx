let show = (id, result) =>
  Printf.printf("%s: %s\n", id, CSS.className(result));

show("same file", CSS.merge(Same_file.responsive, Same_file.override));
show("cross file", CSS.merge(Cross_first.responsive, Cross_second.override));
show("alone", Alone.only);
show("selector use", CSS.merge(Used_a.target, Used_b.override));
show("empty block use", Empty_b.lone);
show("other target", Target_before.overlay);
show("same target", Target_hover.hover);
show("hover then focus", CSS.merge(State_pair.hover, State_pair.focus));
show("focus then hover", CSS.merge(State_pair.focus, State_pair.hover));
show("base and hover", Base_state.state);
show("class then state", CSS.merge(Class_state.marked, Class_state.hovered));
show("state then class", CSS.merge(Class_state.hovered, Class_state.marked));
show("responsive same longhand", Responsive_same.responsive);
show("shorthand then longhand", CSS.merge(Covering.wide, Covering.narrow));
show("same value under two at-rules", Same_value.fluid);
show("two media contexts", CSS.merge(Media_pair.wide, Media_pair.narrow));
show("two media contexts reversed", CSS.merge(Media_pair.narrow, Media_pair.wide));
