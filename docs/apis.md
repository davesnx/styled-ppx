Overview of the uses of styled-ppx

### styled
**Styled component without define an HTML tag, defaults to div**

```reason
module StyledComponent = [%styled {|
  display: flex;
  justify-content: center;
  align-items: center;

  height: 100vh;
  width: 100vw;
|}];

ReactDOMRe.renderToElementWithId(
  <StyledComponent>
    {React.string("- Middle -")}
  </StyledComponent>,
  "app"
);
```

### styled.section/span/a/...
**Styled component with a defined HTML tag. `styled.{{ HTMLElement }}`**

```reason
module Link = [%styled.a {|
  font-size: 30px;
|}];

/* Later on any component... */
<Link href="https://sancho.dev">
  {React.string("Personal website")}
</Link>
```

### styled.div with a variable
**Styled component with styles defined by a variable**, this is not typed since we treat the variable as a string, so we can't ensure that the actual color is the same type as background-color expects.

```reason
let black = "#333";

module Box = [%styled.a {|
  width: 100px;
  height: 100px;
  background-color: $black;
|}];

/* Later on any component... */
<Box />
```

### styled.div with a variable typed
**Styled component with styles defined by a variable but specifying the type explicitly.**
This might be not working for all the cases, but this would bring type-safety into the variables that comes from the outside of the style definition.

```reason
let space = 10;

module Wrap = [%styled.a {|
  margin: $(space)px;
|}];

/* Later on any component... */
<Wrap />
```

### Dynamic styled components
**Styled component with styles defined by props**
In this case, `styled` recieves a function, it doesn't recieve a string as the other cases. This allows to create styled components with a component API.

```reason
module Component = [%styled (~content, ~background) => {j|
  color: $(content);
  background-color: $(background);

  display: block;
|j}];

/* Later on any component... */
<Component content="#EB5757" background="#516CF0" />
```
