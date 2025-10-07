/**
 * CSS Background Properties
 * 
 * This module defines CSS properties for styling element backgrounds.
 * These properties control background colors, images, positioning, sizing, and layering.
 * 
 * References:
 * - CSS Backgrounds and Borders Module: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Backgrounds_and_Borders
 * - Background properties: https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Backgrounds_and_Borders#properties
 */

/**
 * background property
 * 
 * Shorthand property that sets all background properties in a single declaration.
 * Can specify multiple background layers separated by commas.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background
 */
let rec property_background = [%value.rec "[ <bg-layer> ',' ]* <final-bg-layer>"];

/**
 * background-attachment property
 * 
 * Sets whether a background image's position is fixed within the viewport,
 * or scrolls with its containing block.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-attachment
 */
and property_background_attachment = [%value.rec "[ <attachment> ]#"];

/**
 * background-blend-mode property
 * 
 * Sets how an element's background images should blend with each other
 * and with the element's background color.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-blend-mode
 */
and property_background_blend_mode = [%value.rec "[ <blend-mode> ]#"];

/**
 * background-clip property
 * 
 * Sets whether an element's background extends underneath its border box,
 * padding box, or content box. Includes support for text clipping.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-clip
 */
and property_background_clip = [%value.rec
  "[ <box> | 'text' | 'border-area' ]#"
];

/**
 * background-color property
 * 
 * Sets the background color of an element. The color is drawn behind
 * any background images.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-color
 */
and property_background_color = [%value.rec "<color>"];

/**
 * background-image property
 * 
 * Sets one or more background images on an element. Background images
 * are drawn on stacking context layers on top of each other.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-image
 */
and property_background_image = [%value.rec "[ <bg-image> ]#"];

/**
 * background-origin property
 * 
 * Sets the background's origin: from the border start, inside the border,
 * or inside the padding.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-origin
 */
and property_background_origin = [%value.rec "[ <box> ]#"];

/**
 * background-position property
 * 
 * Sets the initial position for each background image. The position
 * is relative to the position layer set by background-origin.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-position
 */
and property_background_position = [%value.rec "[ <bg-position> ]#"];

/**
 * background-position-x property
 * 
 * Sets the initial horizontal position for each background image.
 * Supports logical values for internationalization.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-position-x
 */
and property_background_position_x = [%value.rec
  "[ 'center' | [ 'left' | 'right' | 'x-start' | 'x-end' ]? [ <extended-length> | <extended-percentage> ]? ]#"
];

/**
 * background-position-y property
 * 
 * Sets the initial vertical position for each background image.
 * Supports logical values for internationalization.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-position-y
 */
and property_background_position_y = [%value.rec
  "[ 'center' | [ 'top' | 'bottom' | 'y-start' | 'y-end' ]? [ <extended-length> | <extended-percentage> ]? ]#"
];

/**
 * background-repeat property
 * 
 * Sets how background images are repeated. A background image can be
 * repeated along the horizontal and vertical axes, or not repeated at all.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-repeat
 */
and property_background_repeat = [%value.rec "[ <repeat-style> ]#"];

/**
 * background-size property
 * 
 * Sets the size of the element's background image. The image can be left
 * to its natural size, stretched, or constrained to fit the available space.
 * 
 * @see https://developer.mozilla.org/en-US/docs/Web/CSS/background-size
 */
and property_background_size = [%value.rec "[ <bg-size> ]#"];