module Media = struct
  let mobile = "(min-width: 768px)"
end

let languageIcon = "languageIcon"
let headerMenuOpened = [%cx {||}]

let icon = [%cx {|
  position: relative;
  top: 3px;
  padding-left: 4px;
|}]

let classname =
  [%cx
    {|
    cursor: pointer;

    @media $(Media.mobile) {
      position: relative;

      .$(icon) {
        position: absolute;
        right: 0;
        top: 20px;
      }
    }

    :hover, &.$(headerMenuOpened) {
      opacity: 1;
      color: #ace;

      @media $(Media.mobile) {
        color: #eca;
      }
    }
|}]
