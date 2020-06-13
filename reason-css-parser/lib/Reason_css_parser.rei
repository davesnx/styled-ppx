include (module type of {
  include Parser;
});

let parse: (Rule.rule('a), string) => Rule.data('a);
let parse_property:
  (Rule.rule('a), string) =>
  Rule.data(
    [
      | `Css_wide_value([ | `Initial | `Inherit | `Unset])
      | `Property_value('a)
    ],
  );
