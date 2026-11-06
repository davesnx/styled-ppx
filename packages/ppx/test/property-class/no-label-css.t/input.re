let card = [%css "color: red; &:hover { color: blue }"];
module Inner = {
  let tagged = [%css "color: red"];
};
