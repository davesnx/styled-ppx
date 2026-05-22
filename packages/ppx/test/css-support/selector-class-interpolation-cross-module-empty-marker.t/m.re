/* The canonical cross-module pattern: an empty marker class meant
   purely as a "tag" that consumers chain into their selectors. */
let isOpen = [%css {||}];
let isHovered = [%css {||}];
