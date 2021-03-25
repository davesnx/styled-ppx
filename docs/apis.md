# API surface definition
This document explains what are the interfaces that styled-ppx offers.

### styled
**Styled component with one CSS property**
```reason
module StyledComponent = [%styled "display: flex"];
```

### styled
**Styled component with more than one CSS property**
```reason
module Box = [%styled {|
  width: 100px;
  height: 100px;
|}];
```

### css
**React component with a className by css**
```reason
<span className=[%css "display: flex"] />
```

### styled.section/span/a/...
**Styled component with a defined HTML tag. `styled.{{ HTMLElement }}`**, if it's missing, defaults to `div`.

```reason
module Link = [%styled.a {|
  font-size: 30px;
|}];

/* Later on any component... */
<Link href="https://sancho.dev">
  {React.string("Personal website")}
</Link>
```

### styled with interpolation
**Styled component with styles defined by variables outside of the defintion**, this is not type-safe since we cast it as a string. Any interpolation that isn't a string might cause the ppx to not compile. Allowing any 

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
**Inject global styles**, method to apply general styles to your website.
```reason
[%styled.global {|
  html, body {
    margin: 0;
    padding: 0;
  }
|}];
```

### styled with dynamic styles
**Styled component with CSS defined by component props**
`styled` instead of a   recieves a function, it doesn't recieve a string as the other cases. This allows to create styled components with a component API.

```reason
module Component = [%styled (~content, ~background) => {j|
  color: $(content);
  background-color: $(background);

  display: block;
|j}];

/* Later on any component... */
<Component content="#EB5757" background="#516CF0" />
```

> Dynamic components are somehow not fully supported, and it's the reason why is still in BETA. The main problem is casting any parameter into a valid CSS value, since the language doesn't allow polymorphism (allowing a function to recieve a type with different shapes). It makes dynamic styling a challenge, for now we rely on an slight unsafe behaviour. This will be improved in further releases.

### styled with typed interpolation
**styled component with styles defined by a variable but specifying the type explicitly.**
This might be not working for all the cases, but this would bring type-safety into the variables that comes from the outside of the style definition.

> This is currently on development, it works only for simple cases.
```reason
let space = 10;

module Wrap = [%styled.a {|
  margin: $(space)px;
|}];
```

# Exploration

All of this below it's just exploration on APIs we want to support.

### Pattern match on a value
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
      | Small => 33%
      | Big => 80%
      | Full => 100%
    }
  |}
];
```

### Pattern match on any expression
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
