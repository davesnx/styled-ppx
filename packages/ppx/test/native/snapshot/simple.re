let classNameHash = [%css "display: block"];

module Component = [%styled.section (~a, ~b) => {|
  display: flex;
  justify-content: center;
|}];
