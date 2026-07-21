/* Anonymous block-form @layer would force styled-ppx to mint a hashed
   layer name, which is observable in the cascade — reject it. */
let invalid = [%css {|
  @layer {
    color: red;
  }
|}];

let _ = invalid;
