/* One representative invalid value per grammar shape this pass added:
   a list property rejecting a bare non-list token is covered by
   css-grammar's own Parser_test.re; here we cover ppx-level rejection for
   the shapes unique to this file - a repeat() list, an inset shorthand,
   and the gap-rule shorthand itself. */
[%css {|column-rule-color: repeat(2, 10px)|}];
