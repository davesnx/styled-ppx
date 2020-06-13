include (module type of {
  include Parser;
});
module Standard = Standard;
let parse: (Rule.rule('a), string) => Rule.data('a);
