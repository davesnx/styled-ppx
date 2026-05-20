/* Pins the codegen contract for user-supplied `className` and `style` props
   on a `[%styled.tag]` component (native renderer).

   Expected behavior:
   - `className: option(string)` is part of `makeProps`. The generated
     `make` concatenates the styled-component class with the user's
     `className` via the `getOrEmpty` helper (with a leading space).
   - `style: option(ReactDOM.Style.t)` is part of `makeProps` and is
     forwarded to `ReactDOM.domProps` as `~style=?styleGet(props)`. */
module Box = [%styled.div "color: red;"];
