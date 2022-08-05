include MockBsCss;

let colorazo = CssJs.red;

let className = [%cx "
  color: $(colorazo);
"];
