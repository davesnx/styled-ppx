/* and _webkit_mask_clip_style = [%value.rec "'border' | 'border-box' | 'padding' | 'padding-box' | 'content' | 'content-box' | 'text'"] */

type webkit_mask_clip_style = [
  | `border
  | `border_box
  | `padding
  | `padding_box
  | `content
  | `content_box
];

type length;
type percentage;

/* and property_width = [%value.rec "'auto' | <length> | <percentage> | 'min-content' | 'max-content' | 'fit-content' | fit-content( <length> | <percentage> )"] */

type property_width = [
  | `auto
  | `length(length)
  | `percentage(percentage)
  | `min_content
  | `max_content
  | `fit_content
  | `fit_content_length(length)
  | `fit_content_percentage(percentage)
];

/* and final_bg_layer = [%value.rec "<'background-color'> || <bg-image> || <bg-position> [ '/' <bg-size> ]? || <repeat-style> || <attachment> || <box> || <box>"] */

type xor('a, 'b) = [ | `A('a) | `B('b) ];
type xor3('a, 'b, 'c) = [ | `A('a) | `B('b) | `C('c)];

type background_color;
/* and bg_image = [%value.rec "'none' | <image>"] */
type img; /* it should be image, but there's conflicts with type names */
type bg_image = [ | `None | `Image(img) ];

type final_bg_layer = xor(background_color, bg_image);

type url; /* from Standard.re */
type string; /* from Standard.re */
type image_tags = [ | `ltr | `rtl ];
type image_src = [ | `Image(img) | `Url(url) ];
type color; /* and color = [%value.rec "<rgb()> | <rgba()> | <hsl()> | <hsla()> | <hex-color> | <named-color> | 'currentColor' | <deprecated-system-color> | <interpolation> | <var()>"] */

/* and function_image = [%value.rec "image( [ <image-tags> ]? [ <image-src> ]? ',' [ <color> ]? )"] */

type function_image = (option(image_tags), option(image_src), option(color));

/* and image = [%value.rec "<url> | <image()>"] */

type image = [
  | `url(url)
  | `image(image)
];

/* and color_stop_angle = [%value.rec "[ <extended-angle> ]{1,2}"] */

type angle;
type color_stop_angle = (angle, option(angle));

/* and function_clamp = [%value.rec "clamp( [ <calc-sum> ]#{3} )"] */

type calc_sum;
type function_clamp = (calc_sum, calc_sum, calc_sum);

/* and function_clamp = [%value.rec "clamp( [ <calc-sum> ]# )"] */
type function_clamp = list(calc_sum);
