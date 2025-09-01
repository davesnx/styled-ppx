/* Test JSX styles prop transformation */

let styles = [%cx2 "color: red; padding: 10px"];

/* Test with direct cx2 in JSX */
let component1 = () => {
  <div styles=[%cx2 "color: blue; margin: 20px"]> "Hello World" </div>;
};

/* Test with variable */
let component2 = () => {
  <button styles> "Click me" </button>;
};

/* Test with dynamic styles */
let dynamicStyles = color => {
  [%cx2 "color: $(color); font-size: 16px"];
};

let component3 = color => {
  <span styles={dynamicStyles(color)}> "Dynamic color" </span>;
};
