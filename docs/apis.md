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

### styled "inline"
**Styled component with one CSS property**
```reason
module StyledComponent = [%styled "display: flex"];
```

### css
**Styled component defined inline as className**
```reason
<span className=[%css "display: flex"] />
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

### styled.global
**Inject global css**, method to apply general styles to your website.
```reason
[%styled.global {|
  html, body {
    margin: 0;
    padding: 0;
  }
|}];
```
Accepts only one selector declaration, so this will not compile:
```reason
[%styled.global {|
  html, body {
    margin: 0;
    padding: 0;
  }

  .div {
    display: flex;
  }
|}];
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

> Dynamic components are somehow not fully supported, and it's the reason why is still in BETA. The main problem is casting any parameter into a valid CSS value, since the language doesn't allow polymorphism (allowing a function to recieve a type with different shapes). It makes dynamic styling a challenge, for now we rely on an slight unsafe behaviour. This will be improved in further releases.

/* Later on any component... */
<Component content="#EB5757" background="#516CF0" />
```

### styled.div with a variable typed
**Styled component with styles defined by a variable but specifying the type explicitly.**
This might be not working for all the cases, but this would bring type-safety into the variables that comes from the outside of the style definition.

> This is currently on development, it works for simple cases.
```reason
let space = 10;

module Wrap = [%styled.a {|
  margin: $(space)px;
|}];

/* Later on any component... */
<Wrap />
```

### Pattern match on a value
> This is not implemented and the api isn't final.
```reason
/* This is not implemented yet! */
type size =
  | Small
  | Big
  | Full;

/* And you would be able to create components with Pattern Matching, or compose functions! */
module StyledWithPatternMatcing = [%styled (~size) =>
  {|
    width: switch (size) {
      | Small => 33%;
      | Big => 80%;
      | Full => 100%;
    }
  |}
];
```

### Pattern match on any expression
> This is not implemented and the api isn't final.
```reason
/* This is not implemented yet! */
type size =
  | Small
  | Big
  | Full;

/* And you would be able to create components with Pattern Matching, or compose functions! */
module StyledWithPatternMatcing = [%styled
  (~size) => switch (size) {
    | Small => "width: 33%"
    | Big => "width: 80%"
    | Full => "width: 100%"
  }
];
```
