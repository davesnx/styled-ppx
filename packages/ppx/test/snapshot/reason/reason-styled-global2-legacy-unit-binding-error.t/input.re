/* Legacy `let () = [%styled.global2 ...]` shape.

   Module_expr-context registration handles the supported
   `module Foo = [%styled.global2 ...]` form. The Expression-context
   registration exists only to fire a migration error pointing users
   to the new shape. */

let () = [%styled.global2 "body { margin: 0; }"];
