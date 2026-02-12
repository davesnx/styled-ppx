(* Test file for [%spec] extension *)

(* Define a base property *)
let property_margin_left = [%spec "<extended-length> | <extended-percentage> | 'auto'"];

(* Simple property reference *)
let property_margin_block_end = [%spec "<'margin-left'>"];

(* Multiple property references with multiplier *)
let property_margin_block = [%spec "[ <'margin-left'> ]{1,2}"];

(* Property that references position properties *)
let property_top = [%spec "<extended-length> | <extended-percentage> | 'auto'"];
let property_inset = [%spec "[ <'top'> ]{1,4}"];

(* Gap properties that reference each other *)
let property_row_gap = [%spec "'normal' | <extended-length> | <extended-percentage>"];
let property_column_gap = [%spec "'normal' | <extended-length> | <extended-percentage>"];
let property_gap = [%spec "<'row-gap'> [ <'column-gap'> ]?"];

