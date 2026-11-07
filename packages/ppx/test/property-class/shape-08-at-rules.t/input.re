let media = [%css "@media (min-width: 1px) { color: red }"];
let nested = [%css "@media (min-width: 1px) { @supports (display: grid) { display: grid } }"];
let swapped = [%css "@supports (display: grid) { @media (min-width: 1px) { display: grid } }"];
let container = [%css "@container (min-width: 2px) { &:hover { color: red } }"];
let inHover = [%css "&:hover { @media (min-width: 1px) { color: red } }"];
