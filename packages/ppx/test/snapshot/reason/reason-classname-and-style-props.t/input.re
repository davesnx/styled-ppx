/* Pins the codegen contract for user-supplied `className` and `style` props
   on a `[%styled.tag]` component (melange/JS).

   Expected behavior:
   - `className: option(string)` is part of `makeProps`. The generated
     `make` concatenates the styled-component class with the user's
     `className` via the `getOrEmpty` helper (with a leading space).
   - `style: option(ReactDOM.Style.t)` is part of `makeProps` and is
     forwarded unchanged via `assign2(Js.Obj.empty(), Obj.magic(props), ...)`.
     The `stylesObject` only overrides `className` and `ref`, so the user's
     `style` survives onto the DOM element. */
module Box = [%styled.div "color: red;"];
