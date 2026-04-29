open Types
open Support

module Function_color_mix =
  [%spec_module
  "color-mix(<color-interpolation-method> ',' [ <color> && <percentage>? ] ',' \
   [ <color> && <percentage>? ])"]

let function_color_mix : function_color_mix Rule.rule = Function_color_mix.rule

module Function__webkit_gradient =
  [%spec_module
  "-webkit-gradient( <webkit-gradient-type> ',' <webkit-gradient-point> [ ',' \
   <webkit-gradient-point> | ',' <webkit-gradient-radius> ',' \
   <webkit-gradient-point> ] [ ',' <webkit-gradient-radius> ]? [ ',' \
   <webkit-gradient-color-stop> ]* )"]

let function__webkit_gradient : function__webkit_gradient Rule.rule =
  Function__webkit_gradient.rule

module Function_attr = [%spec_module "attr(<attr-name> <attr-type>?)"]

let function_attr : function_attr Rule.rule = Function_attr.rule

module Function_blur = [%spec_module "blur( <extended-length> )"]

let function_blur : function_blur Rule.rule = Function_blur.rule

module Function_brightness = [%spec_module "brightness( <number-percentage> )"]

let function_brightness : function_brightness Rule.rule =
  Function_brightness.rule

module Function_calc = [%spec_module "calc( <calc-sum> )"]

let function_calc : function_calc Rule.rule = Function_calc.rule

module Function_circle =
  [%spec_module
  "circle( [ <shape-radius> ]? [ 'at' <position> ]? )"]

let function_circle : function_circle Rule.rule = Function_circle.rule

module Function_clamp = [%spec_module "clamp( [ <calc-sum> ]#{3} )"]

let function_clamp : function_clamp Rule.rule = Function_clamp.rule

module Function_conic_gradient =
  [%spec_module
  "conic-gradient( [ 'from' <extended-angle> ]? [ 'at' <position> ]? ',' \
   <angular-color-stop-list> )"]

let function_conic_gradient : function_conic_gradient Rule.rule =
  Function_conic_gradient.rule

module Function_contrast = [%spec_module "contrast( <number-percentage> )"]

let function_contrast : function_contrast Rule.rule = Function_contrast.rule

module Function_counter =
  [%spec_module
  "counter( <counter-name> , <counter-style>? )", (module Css_types.Counter)]

let function_counter : function_counter Rule.rule = Function_counter.rule

module Function_counters =
  [%spec_module
  "counters( <custom-ident> ',' <string> ',' [ <counter-style> ]? )",
  (module Css_types.Counters)]

let function_counters : function_counters Rule.rule = Function_counters.rule

module Function_cross_fade =
  [%spec_module
  "cross-fade( <cf-mixing-image> ',' [ <cf-final-image> ]? )"]

let function_cross_fade : function_cross_fade Rule.rule =
  Function_cross_fade.rule

module Function_drop_shadow =
  [%spec_module
  "drop-shadow(<extended-length> <extended-length> <extended-length> [ <color> \
   ]?)"]

let function_drop_shadow : function_drop_shadow Rule.rule =
  Function_drop_shadow.rule

module Function_element = [%spec_module "element( <id-selector> )"]

let function_element : function_element Rule.rule = Function_element.rule

module Function_ellipse =
  [%spec_module
  "ellipse( [ [ <shape-radius> ]{2} ]? [ 'at' <position> ]? )"]

let function_ellipse : function_ellipse Rule.rule = Function_ellipse.rule

module Function_env =
  [%spec_module
  "env( <custom-ident> ',' [ <declaration-value> ]? )"]

let function_env : function_env Rule.rule = Function_env.rule

module Function_fit_content =
  [%spec_module
  "fit-content( <extended-length> | <extended-percentage> )"]

let function_fit_content : function_fit_content Rule.rule =
  Function_fit_content.rule

module Function_grayscale = [%spec_module "grayscale( <number-percentage> )"]

let function_grayscale : function_grayscale Rule.rule = Function_grayscale.rule

module Function_hsl =
  [%spec_module
  " hsl( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> \
   ]? ) | hsl( <hue> ',' <extended-percentage> ',' <extended-percentage> [ ',' \
   <alpha-value> ]? )"]

let function_hsl : function_hsl Rule.rule = Function_hsl.rule

module Function_hsla =
  [%spec_module
  " hsla( <hue> <extended-percentage> <extended-percentage> [ '/' \
   <alpha-value> ]? ) | hsla( <hue> ',' <extended-percentage> ',' \
   <extended-percentage> ',' [ <alpha-value> ]? )"]

let function_hsla : function_hsla Rule.rule = Function_hsla.rule

module Function_hwb =
  [%spec_module
  "hwb( <hue> <extended-percentage> <extended-percentage> [ '/' <alpha-value> \
   ]? )"]

let function_hwb : function_hwb Rule.rule = Function_hwb.rule

module Function_hue_rotate = [%spec_module "hue-rotate( <extended-angle> )"]

let function_hue_rotate : function_hue_rotate Rule.rule =
  Function_hue_rotate.rule

module Function_image =
  [%spec_module
  "image( [ <image-tags> ]? [ <image-src> ]? ',' [ <color> ]? )",
  (module Css_types.Image)]

let function_image : function_image Rule.rule = Function_image.rule

module Function_image_set =
  [%spec_module
  "image-set( [ <image-set-option> ]# )"]

let function_image_set : function_image_set Rule.rule = Function_image_set.rule

module Function_inset =
  [%spec_module
  "inset( [ <extended-length> | <extended-percentage> ]{1,4} [ 'round' \
   <'border-radius'> ]? )",
  (module Css_types.Inset)]

let function_inset : function_inset Rule.rule = Function_inset.rule

module Function_invert = [%spec_module "invert( <number-percentage> )"]

let function_invert : function_invert Rule.rule = Function_invert.rule

module Function_leader = [%spec_module "leader( <leader-type> )"]

let function_leader : function_leader Rule.rule = Function_leader.rule

module Function_lab =
  [%spec_module
  "lab( <extended-percentage> <number> <number> [ '/' <alpha-value> ]? )"]

let function_lab : function_lab Rule.rule = Function_lab.rule

module Function_lch =
  [%spec_module
  "lch( <extended-percentage> <number> <hue> [ '/' <alpha-value> ]? )"]

let function_lch : function_lch Rule.rule = Function_lch.rule

module Function_light_dark = [%spec_module "light-dark( <color> ',' <color> )"]

let function_light_dark : function_light_dark Rule.rule =
  Function_light_dark.rule

module Function_color =
  [%spec_module
  "color( <predefined-color-space> <number-percentage> <number-percentage> \
   <number-percentage> [ '/' <alpha-value> ]? )"]

let function_color : function_color Rule.rule = Function_color.rule

module Function_linear_gradient =
  [%spec_module
  "linear-gradient( [ [<extended-angle> ','] | ['to' <side-or-corner> ','] ]? \
   <color-stop-list> )"]

let function_linear_gradient : function_linear_gradient Rule.rule =
  Function_linear_gradient.rule

module Function_matrix = [%spec_module "matrix( [ <number> ]#{6} )"]

let function_matrix : function_matrix Rule.rule = Function_matrix.rule

module Function_matrix3d = [%spec_module "matrix3d( [ <number> ]#{16} )"]

let function_matrix3d : function_matrix3d Rule.rule = Function_matrix3d.rule

module Function_max = [%spec_module "max( [ <calc-sum> ]# )"]

let function_max : function_max Rule.rule = Function_max.rule

module Function_min = [%spec_module "min( [ <calc-sum> ]# )"]

let function_min : function_min Rule.rule = Function_min.rule

module Function_minmax =
  [%spec_module
  "minmax( [ <extended-length> | <extended-percentage> | 'min-content' | \
   'max-content' | 'auto' ] ',' [ <extended-length> | <extended-percentage> | \
   <flex-value> | 'min-content' | 'max-content' | 'auto' ] )"]

let function_minmax : function_minmax Rule.rule = Function_minmax.rule

module Function_oklab =
  [%spec_module
  "oklab( <extended-percentage> <number> <number> [ '/' <alpha-value> ]? )"]

let function_oklab : function_oklab Rule.rule = Function_oklab.rule

module Function_oklch =
  [%spec_module
  "oklch( <extended-percentage> <number> <hue> [ '/' <alpha-value> ]? )"]

let function_oklch : function_oklch Rule.rule = Function_oklch.rule

module Function_opacity = [%spec_module "opacity( <number-percentage> )"]

let function_opacity : function_opacity Rule.rule = Function_opacity.rule

module Function_paint =
  [%spec_module
  "paint( <ident> ',' [ <declaration-value> ]? )", (module Css_types.Paint)]

let function_paint : function_paint Rule.rule = Function_paint.rule

module Function_path = [%spec_module "path( <string> )"]

let function_path : function_path Rule.rule = Function_path.rule

module Function_perspective =
  [%spec_module
  "perspective( <'perspective'> )", (module Css_types.Perspective)]

let function_perspective : function_perspective Rule.rule =
  Function_perspective.rule

module Function_polygon =
  [%spec_module
  "polygon( [ [ 'nonzero' | 'evenodd' ] ',' ]? [ <length-percentage> \
   <length-percentage> ]# )"]

let function_polygon : function_polygon Rule.rule = Function_polygon.rule

module Function_radial_gradient =
  [%spec_module
  "radial-gradient( <ending-shape>? <radial-size>? ['at' <position> ]? ','? \
   <color-stop-list> )"]

let function_radial_gradient : function_radial_gradient Rule.rule =
  Function_radial_gradient.rule

module Function_repeating_linear_gradient =
  [%spec_module
  "repeating-linear-gradient( [ <extended-angle> | 'to' <side-or-corner> ]? \
   ',' <color-stop-list> )"]

let function_repeating_linear_gradient :
  function_repeating_linear_gradient Rule.rule =
  Function_repeating_linear_gradient.rule

module Function_repeating_radial_gradient =
  [%spec_module
  "repeating-radial-gradient( [ <ending-shape> || <radial-size> ]? [ 'at' \
   <position> ]? ',' <color-stop-list> )"]

let function_repeating_radial_gradient :
  function_repeating_radial_gradient Rule.rule =
  Function_repeating_radial_gradient.rule

module Function_rgb =
  [%spec_module
  "rgb( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? ) | rgb( [ \
   <number> ]{3} [ '/' <alpha-value> ]? ) | rgb( [ <extended-percentage> ]#{3} \
   [ ',' <alpha-value> ]? ) | rgb( [ <number> ]#{3} [ ',' <alpha-value> ]? )"]

let function_rgb : function_rgb Rule.rule = Function_rgb.rule

module Function_rgba =
  [%spec_module
  "rgba( [ <extended-percentage> ]{3} [ '/' <alpha-value> ]? ) | rgba( [ \
   <number> ]{3} [ '/' <alpha-value> ]? ) | rgba( [ <extended-percentage> \
   ]#{3} [ ',' <alpha-value> ]? ) | rgba( [ <number> ]#{3} [ ',' <alpha-value> \
   ]? )"]

let function_rgba : function_rgba Rule.rule = Function_rgba.rule

module Function_rotate =
  [%spec_module
  "rotate( <extended-angle> | <zero> )", (module Css_types.Rotate)]

let function_rotate : function_rotate Rule.rule = Function_rotate.rule

module Function_rotate3d =
  [%spec_module
  "rotate3d( <number> ',' <number> ',' <number> ',' [ <extended-angle> | \
   <zero> ] )"]

let function_rotate3d : function_rotate3d Rule.rule = Function_rotate3d.rule

module Function_rotateX = [%spec_module "rotateX( <extended-angle> | <zero> )"]

let function_rotateX : function_rotateX Rule.rule = Function_rotateX.rule

module Function_rotateY = [%spec_module "rotateY( <extended-angle> | <zero> )"]

let function_rotateY : function_rotateY Rule.rule = Function_rotateY.rule

module Function_rotateZ = [%spec_module "rotateZ( <extended-angle> | <zero> )"]

let function_rotateZ : function_rotateZ Rule.rule = Function_rotateZ.rule

module Function_saturate = [%spec_module "saturate( <number-percentage> )"]

let function_saturate : function_saturate Rule.rule = Function_saturate.rule

module Function_scale =
  [%spec_module
  "scale( <number> [',' [ <number> ]]? )", (module Css_types.Scale)]

let function_scale : function_scale Rule.rule = Function_scale.rule

module Function_scale3d =
  [%spec_module
  "scale3d( <number> ',' <number> ',' <number> )"]

let function_scale3d : function_scale3d Rule.rule = Function_scale3d.rule

module Function_scaleX = [%spec_module "scaleX( <number> )"]

let function_scaleX : function_scaleX Rule.rule = Function_scaleX.rule

module Function_scaleY = [%spec_module "scaleY( <number> )"]

let function_scaleY : function_scaleY Rule.rule = Function_scaleY.rule

module Function_scaleZ = [%spec_module "scaleZ( <number> )"]

let function_scaleZ : function_scaleZ Rule.rule = Function_scaleZ.rule

module Function_sepia = [%spec_module "sepia( <number-percentage> )"]

let function_sepia : function_sepia Rule.rule = Function_sepia.rule

module Function_skew =
  [%spec_module
  "skew( [ <extended-angle> | <zero> ] [',' [ <extended-angle> | <zero> ]]? )"]

let function_skew : function_skew Rule.rule = Function_skew.rule

module Function_skewX = [%spec_module "skewX( <extended-angle> | <zero> )"]

let function_skewX : function_skewX Rule.rule = Function_skewX.rule

module Function_skewY = [%spec_module "skewY( <extended-angle> | <zero> )"]

let function_skewY : function_skewY Rule.rule = Function_skewY.rule

module Function_symbols =
  [%spec_module
  "symbols( [ <symbols-type> ]? [ <string> | <image> ]+ )",
  (module Css_types.Symbols)]

let function_symbols : function_symbols Rule.rule = Function_symbols.rule

module Function_target_counter =
  [%spec_module
  "target-counter( [ <string> | <url> ] ',' <custom-ident> ',' [ \
   <counter-style> ]? )"]

let function_target_counter : function_target_counter Rule.rule =
  Function_target_counter.rule

module Function_target_counters =
  [%spec_module
  "target-counters( [ <string> | <url> ] ',' <custom-ident> ',' <string> ',' [ \
   <counter-style> ]? )"]

let function_target_counters : function_target_counters Rule.rule =
  Function_target_counters.rule

module Function_target_text =
  [%spec_module
  "target-text( [ <string> | <url> ] ',' [ 'content' | 'before' | 'after' | \
   'first-letter' ]? )"]

let function_target_text : function_target_text Rule.rule =
  Function_target_text.rule

module Function_translate =
  [%spec_module
  "translate( [<extended-length> | <extended-percentage>] [',' [ \
   <extended-length> | <extended-percentage> ]]? )",
  (module Css_types.Translate)]

let function_translate : function_translate Rule.rule = Function_translate.rule

module Function_translate3d =
  [%spec_module
  "translate3d( [<extended-length> | <extended-percentage>] ',' \
   [<extended-length> | <extended-percentage>] ',' <extended-length> )"]

let function_translate3d : function_translate3d Rule.rule =
  Function_translate3d.rule

module Function_translateX =
  [%spec_module
  "translateX( [<extended-length> | <extended-percentage>] )"]

let function_translateX : function_translateX Rule.rule =
  Function_translateX.rule

module Function_translateY =
  [%spec_module
  "translateY( [<extended-length> | <extended-percentage>] )"]

let function_translateY : function_translateY Rule.rule =
  Function_translateY.rule

module Function_translateZ = [%spec_module "translateZ( <extended-length> )"]

let function_translateZ : function_translateZ Rule.rule =
  Function_translateZ.rule

module Function_var = [%spec_module "var( <ident> )", (module Css_types.Var)]

let function_var : function_var Rule.rule = Function_var.rule

let entries : (kind * packed_rule) list =
  [
    Function "image()", pack_module (module Function_image);
    Function "image-set()", pack_module (module Function_image_set);
    Function "element()", pack_module (module Function_element);
    Function "paint()", pack_module (module Function_paint);
    Function "cross-fade()", pack_module (module Function_cross_fade);
    Function "attr()", pack_module (module Function_attr);
    Function "symbols()", pack_module (module Function_symbols);
    Function "linear-gradient()", pack_module (module Function_linear_gradient);
    Function "radial-gradient()", pack_module (module Function_radial_gradient);
    Function "conic-gradient()", pack_module (module Function_conic_gradient);
    ( Function "repeating-linear-gradient()",
      pack_module (module Function_repeating_linear_gradient) );
    ( Function "repeating-radial-gradient()",
      pack_module (module Function_repeating_radial_gradient) );
    ( Function "-webkit-gradient()",
      pack_module (module Function__webkit_gradient) );
    Function "matrix()", pack_module (module Function_matrix);
    Function "matrix3d()", pack_module (module Function_matrix3d);
    Function "translate()", pack_module (module Function_translate);
    Function "translateX()", pack_module (module Function_translateX);
    Function "translateY()", pack_module (module Function_translateY);
    Function "translateZ()", pack_module (module Function_translateZ);
    Function "translate3d()", pack_module (module Function_translate3d);
    Function "scale()", pack_module (module Function_scale);
    Function "scale3d()", pack_module (module Function_scale3d);
    Function "scaleX()", pack_module (module Function_scaleX);
    Function "scaleY()", pack_module (module Function_scaleY);
    Function "scaleZ()", pack_module (module Function_scaleZ);
    Function "rotate()", pack_module (module Function_rotate);
    Function "rotate3d()", pack_module (module Function_rotate3d);
    Function "rotateX()", pack_module (module Function_rotateX);
    Function "rotateY()", pack_module (module Function_rotateY);
    Function "rotateZ()", pack_module (module Function_rotateZ);
    Function "skew()", pack_module (module Function_skew);
    Function "skewX()", pack_module (module Function_skewX);
    Function "skewY()", pack_module (module Function_skewY);
    Function "perspective()", pack_module (module Function_perspective);
    Function "calc()", pack_module (module Function_calc);
    Function "min()", pack_module (module Function_min);
    Function "max()", pack_module (module Function_max);
    Function "rgb()", pack_module (module Function_rgb);
    Function "rgba()", pack_module (module Function_rgba);
    Function "hsl()", pack_module (module Function_hsl);
    Function "hsla()", pack_module (module Function_hsla);
    Function "var()", pack_module (module Function_var);
    Function "hwb()", pack_module (module Function_hwb);
    Function "lab()", pack_module (module Function_lab);
    Function "lch()", pack_module (module Function_lch);
    Function "oklab()", pack_module (module Function_oklab);
    Function "oklch()", pack_module (module Function_oklch);
    Function "color()", pack_module (module Function_color);
    Function "light-dark()", pack_module (module Function_light_dark);
    Function "color-mix()", pack_module (module Function_color_mix);
    Function "blur()", pack_module (module Function_blur);
    Function "brightness()", pack_module (module Function_brightness);
    Function "circle()", pack_module (module Function_circle);
    Function "clamp()", pack_module (module Function_clamp);
    Function "contrast()", pack_module (module Function_contrast);
    Function "counter()", pack_module (module Function_counter);
    Function "counters()", pack_module (module Function_counters);
    Function "drop-shadow()", pack_module (module Function_drop_shadow);
    Function "ellipse()", pack_module (module Function_ellipse);
    Function "env()", pack_module (module Function_env);
    Function "fit-content()", pack_module (module Function_fit_content);
    Function "grayscale()", pack_module (module Function_grayscale);
    Function "hue-rotate()", pack_module (module Function_hue_rotate);
    Function "inset()", pack_module (module Function_inset);
    Function "invert()", pack_module (module Function_invert);
    Function "leader()", pack_module (module Function_leader);
    Function "minmax()", pack_module (module Function_minmax);
    Function "opacity()", pack_module (module Function_opacity);
    Function "path()", pack_module (module Function_path);
    Function "polygon()", pack_module (module Function_polygon);
    Function "saturate()", pack_module (module Function_saturate);
    Function "sepia()", pack_module (module Function_sepia);
    Function "target-counter()", pack_module (module Function_target_counter);
    Function "target-counters()", pack_module (module Function_target_counters);
    Function "target-text()", pack_module (module Function_target_text);
  ]
