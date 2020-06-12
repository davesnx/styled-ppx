include (module type of {
  include Parser;
});
let parse: (Rule.rule('a), string) => Rule.data('a);
