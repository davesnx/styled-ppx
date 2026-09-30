/* One representative invalid value per grammar shape this pass added: a
   repeat() list rejecting a bare non-list token (here), an inset property
   given a color (invalid_inset.re), and the rule shorthand given an
   out-of-grammar list (invalid_rule.re). Each case is its own file/
   executable: the compiler stops at a file's first error, so one file could
   only ever show its first case. */
[%css {|column-rule-color: repeat(2, 10px)|}];
