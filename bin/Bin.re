open Migrate_parsetree;
open Re_styled_ppx;

let _ = Driver.run_as_ppx_rewriter();
