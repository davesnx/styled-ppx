/**
 * CSS Basic Layout Properties
 * 
 * This module defines core CSS properties that control the layout and positioning of elements.
 * These are fundamental properties that affect how elements are displayed and positioned in the document flow.
 * 
 * References:
 * - CSS Display Module: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Display
 * - CSS Positioned Layout: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Positioned_Layout
 * - CSS Logical Properties: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Logical_Properties
 */

/**
 * display property
 * 
 * Sets whether an element is treated as a block or inline element and the layout used for its children.
 * Supports all display values including flexbox, grid, table, and legacy vendor prefixes.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/display
 */
let rec property_display = [%value.rec
  "'block' | 'contents' | 'flex' | 'flow' | 'flow-root' | 'grid' | 'inline' | 'inline-block' | 'inline-flex' | 'inline-grid' | 'inline-list-item' | 'inline-table' | 'list-item' | 'none' | 'ruby' | 'ruby-base' | 'ruby-base-container' | 'ruby-text' | 'ruby-text-container' | 'run-in' | 'table' | 'table-caption' | 'table-cell' | 'table-column' | 'table-column-group' | 'table-footer-group' | 'table-header-group' | 'table-row' | 'table-row-group' | '-webkit-flex' | '-webkit-inline-flex' | '-webkit-box' | '-webkit-inline-box' | '-moz-inline-stack' | '-moz-box' | '-moz-inline-box'"
];

/**
 * position property
 * 
 * Sets how an element is positioned in a document. The top, right, bottom, and left properties
 * determine the final location of positioned elements.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/position
 */
and property_position = [%value.rec
  "'static' | 'relative' | 'absolute' | 'sticky' | 'fixed' | '-webkit-sticky'"
];

/**
 * float property
 * 
 * Places an element on the left or right side of its container, allowing text and inline elements
 * to wrap around it. Includes logical property values for internationalization.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/float
 */
and property_float = [%value.rec
  "'left' | 'right' | 'none' | 'inline-start' | 'inline-end'"
];

/**
 * clear property
 * 
 * Sets whether an element must be moved below (cleared) floating elements that precede it.
 * Includes logical property values for internationalization.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/clear
 */
and property_clear = [%value.rec
  "'none' | 'left' | 'right' | 'both' | 'inline-start' | 'inline-end'"
];