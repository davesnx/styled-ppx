module Media = struct
  let mobile = "(min-width: 768px)"
end

let languageIcon = "languageIcon"
let headerMenuOpened = [%css {||}]

let icon = [%css {|
  position: relative;
  top: 3px;
  padding-left: 4px;
|}]

let classname =
  [%css
    {|
    cursor: pointer;

    @media (min-width: 768px) {
      position: relative;

      .$(icon) {
        position: absolute;
        right: 0;
        top: 20px;
      }
    }

    &:hover, &.$(headerMenuOpened) {
      opacity: 1;
      color: #ace;

      @media (min-width: 768px) {
        color: #eca;
      }
    }
|}]
