let color = CSS.Types.Color.toString(`hex("3A57FC"));
let own = [%css "color: $(color); &:hover { color: $(color) }"];
let down = [%css "& > * { color: $(color) }"];
let after = [%css "&::after { color: $(color) }"];
