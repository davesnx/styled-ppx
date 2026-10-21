/* N1 references Shared.row from a nested selector - the same shape and
   the same target as N2's identical reference below. */
let list = [%css "& > div:not(:last-child).$(Shared.row) { display: flex; }"];
