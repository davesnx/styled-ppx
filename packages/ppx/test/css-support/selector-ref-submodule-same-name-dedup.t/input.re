module A = {
  let marker = [%css {||}];
  let first = [%css {| &.$(marker) { color: red; } |}];
};

module B = {
  let marker = [%css {||}];
  let second = [%css {| &.$(marker) { color: red; } |}];
};
