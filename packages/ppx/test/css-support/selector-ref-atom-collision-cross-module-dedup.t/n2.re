/* N2 references the SAME Shared.row, from a different file, with the
   identical selector shape - must dedup to N1's atom, not collide with
   it. */
let list = [%css "& > div:not(:last-child).$(Shared.row) { display: flex; }"];
