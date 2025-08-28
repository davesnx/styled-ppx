let css = main => [%cx
  {|
  color: $(main);
  background-color: $(CSS.black);
  display: flex;
|}
];

<div style={css(CSS.red)} />;

/* Needs to get transformed into */

/* inject
   .css-123 {
     color: var(--main);
     background-color: var(--background-color);
     display: flex;
   }
   into a style.css file
   */

let css = main =>
  CSS.make(
    "css-123",
    {
      "--main": main,
      "--background-color": CSS.black,
    },
  );

let x = css(CSS.red);
<div className={x.className} styles={x.dynamic} />;

<!-- TODOS -->
- ppx to generate a css file
- ppx to split static properties and dynamic properties
- ppx to modify "style" prop into "className" and "styles"
