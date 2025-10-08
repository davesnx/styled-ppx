/* Property_to_type: Parse CSS values and extract interpolation type information

   Given a property name and value string, this module:
   1. Parses the value with the appropriate Property_parser
   2. Pattern matches on the parsed AST to find Interpolation nodes
   3. Maps each interpolation's parser type to the corresponding Css_types toString

   Example:
   - parse_and_extract("color", "$(myColor)")
     -> Returns [(["myColor"], "Color")]

   - parse_and_extract("margin", "10px $(right) $(bottom) $(left)")
     -> Returns [(["right"], "Margin"), (["bottom"], "Margin"), (["left"], "Margin")]
*/

module Property_parser = Css_grammar_parser.Parser;

/* Helper to find the property parser by name */
let find_property_parser = (property_name: string) => {
  switch (Property_parser.find_rule(property_name)) {
  | Some(rule) => Some(rule)
  | None => None
  };
};

/* Extract interpolations and their types from a parsed AST.

   Pattern match on parser types to determine the Css_types module.
   When we encounter `Interpolation(vars), return (vars, type_module_name).

   Note: We ignore/assert false on Interpolation nodes during pattern matching
   because at this stage they're already replaced with CSS variables in the transform.
*/

/* Map parsed property types to Css_types toString modules.

   This is the core type mapping - for each property's parsed type,
   determine which Css_types module should be used for toString.
*/
let get_type_for_property = (property_name: string): option(string) => {
  switch (property_name) {
  /* Simple properties that map directly to a type */
  | "color" => Some("Color")
  | "background-color" => Some("Color")
  | "border-color"
  | "border-top-color"
  | "border-right-color"
  | "border-bottom-color"
  | "border-left-color" => Some("Color")
  | "outline-color" => Some("Color")
  | "text-decoration-color" => Some("Color")
  | "text-emphasis-color" => Some("Color")

  | "margin"
  | "margin-top"
  | "margin-right"
  | "margin-bottom"
  | "margin-left" => Some("Margin")

  | "padding"
  | "padding-top"
  | "padding-right"
  | "padding-bottom"
  | "padding-left" => Some("Length")

  | "width" => Some("Width")
  | "height" => Some("Height")
  | "min-width" => Some("MinWidth")
  | "max-width" => Some("MaxWidth")
  | "min-height" => Some("MinHeight")
  | "max-height" => Some("MaxHeight")

  | "top" => Some("Top")
  | "right" => Some("Right")
  | "bottom" => Some("Bottom")
  | "left" => Some("Left")

  /* Flex property: when parsing flex, interpolations are treated as Flex.t
     This handles cases like: flex: $(myFlex) or flex: 1 1 $(basis) */
  | "flex" => Some("Flex")
  | "flex-basis" => Some("FlexBasis")
  | "flex-direction" => Some("FlexDirection")
  | "flex-wrap" => Some("FlexWrap")

  | "display" => Some("Display")
  | "box-sizing" => Some("BoxSizing")
  | "box-shadow" => Some("Shadow")
  | "text-shadow" => Some("Shadow")

  | "text-align" => Some("TextAlign")
  | "text-align-all" => Some("TextAlignAll")
  | "text-align-last" => Some("TextAlignLast")
  | "text-transform" => Some("TextTransform")
  | "text-overflow" => Some("TextOverflow")
  | "text-decoration" => Some("TextDecoration")
  | "text-decoration-line" => Some("TextDecorationLine")
  | "text-decoration-style" => Some("TextDecorationStyle")
  | "text-decoration-thickness" => Some("TextDecorationThickness")
  | "text-decoration-skip-ink" => Some("TextDecorationSkipInk")
  | "text-decoration-skip-box" => Some("TextDecorationSkipBox")
  | "text-decoration-skip-inset" => Some("TextDecorationSkipInset")
  | "text-emphasis-style" => Some("TextEmphasisStyle")
  | "text-justify" => Some("TextJustify")
  | "white-space" => Some("WhiteSpace")
  | "word-break" => Some("WordBreak")
  | "word-spacing" => Some("WordSpacing")
  | "letter-spacing" => Some("LetterSpacing")
  | "line-height" => Some("LineHeight")
  | "tab-size" => Some("TabSize")
  | "hyphens" => Some("Hyphens")
  | "line-break" => Some("LineBreak")

  | "align-content" => Some("AlignContent")
  | "align-items" => Some("AlignItems")
  | "align-self" => Some("AlignSelf")
  | "justify-content" => Some("JustifyContent")
  | "justify-items" => Some("JustifyItems")
  | "justify-self" => Some("JustifySelf")
  | "vertical-align" => Some("VerticalAlign")

  | "grid" => Some("Grid")
  | "grid-template" => Some("GridTemplate")
  | "grid-template-columns" => Some("GridTemplateColumns")
  | "grid-template-rows" => Some("GridTemplateRows")
  | "grid-template-areas" => Some("GridTemplateAreas")
  | "grid-auto-columns" => Some("GridAutoColumns")
  | "grid-auto-rows" => Some("GridAutoRows")
  | "grid-auto-flow" => Some("GridAutoFlow")
  | "grid-column" => Some("GridColumn")
  | "grid-row" => Some("GridRow")
  | "grid-area" => Some("GridArea")
  | "grid-column-start" => Some("GridColumnStart")
  | "grid-column-end" => Some("GridColumnEnd")
  | "grid-row-start" => Some("GridRowStart")
  | "grid-row-end" => Some("GridRowEnd")
  | "gap"
  | "row-gap"
  | "column-gap"
  | "grid-gap"
  | "grid-row-gap"
  | "grid-column-gap" => Some("Gap")

  | "background" => Some("Background")
  | "background-image" => Some("BackgroundImage")
  | "background-position" => Some("BackgroundPosition")
  | "background-size" => Some("BackgroundSize")
  | "background-repeat" => Some("BackgroundRepeat")
  | "background-attachment" => Some("BackgroundAttachment")
  | "background-clip" => Some("BackgroundClip")
  | "background-origin" => Some("BackgroundOrigin")

  | "border-style"
  | "border-top-style"
  | "border-right-style"
  | "border-bottom-style"
  | "border-left-style" => Some("BorderStyle")
  | "border-width"
  | "border-top-width"
  | "border-right-width"
  | "border-bottom-width"
  | "border-left-width" => Some("LineWidth")
  | "border-radius"
  | "border-top-left-radius"
  | "border-top-right-radius"
  | "border-bottom-left-radius"
  | "border-bottom-right-radius" => Some("Length")
  | "border-collapse" => Some("BorderCollapse")
  | "border-image-source" => Some("BorderImageSource")
  | "border-image-slice" => Some("BorderImageSlice")
  | "border-image-width" => Some("BorderImageWidth")
  | "border-image-outset" => Some("BorderImageOutset")
  | "border-image-repeat" => Some("BorderImageRepeat")
  | "outline-style" => Some("OutlineStyle")
  | "outline-offset" => Some("Length")

  | "transform" => Some("Transform")
  | "transform-origin" => Some("TransformOrigin")
  | "transform-style" => Some("TransformStyle")
  | "transform-box" => Some("TransformBox")
  | "translate" => Some("Translate")
  | "rotate" => Some("Rotate")
  | "scale" => Some("Scale")

  | "transition" => Some("Transition")
  | "transition-property" => Some("TransitionProperty")
  | "transition-duration" => Some("TransitionDuration")
  | "transition-delay" => Some("TransitionDelay")
  | "transition-timing-function" => Some("TransitionTimingFunction")
  | "transition-behavior" => Some("TransitionBehavior")

  | "animation" => Some("Animation")
  | "animation-name" => Some("AnimationName")
  | "animation-duration" => Some("AnimationDuration")
  | "animation-delay" => Some("AnimationDelay")
  | "animation-timing-function" => Some("AnimationTimingFunction")
  | "animation-iteration-count" => Some("AnimationIterationCount")
  | "animation-direction" => Some("AnimationDirection")
  | "animation-fill-mode" => Some("AnimationFillMode")
  | "animation-play-state" => Some("AnimationPlayState")

  | "filter"
  | "backdrop-filter" => Some("Filter")

  | "opacity" => Some("AlphaValue")
  | "z-index" => Some("ZIndex")
  | "cursor" => Some("Cursor")
  | "visibility" => Some("Visibility")

  | "overflow"
  | "overflow-x"
  | "overflow-y" => Some("Overflow")
  | "overflow-wrap" => Some("OverflowWrap")
  | "overflow-block" => Some("OverflowBlock")
  | "overflow-inline" => Some("OverflowInline")
  | "overflow-clip-margin" => Some("OverflowClipMargin")
  | "overflow-anchor" => Some("OverflowAnchor")

  | "overscroll-behavior" => Some("OverscrollBehavior")
  | "position" => Some("PropertyPosition")
  | "float" => Some("Float")
  | "clear" => Some("Clear")
  | "resize" => Some("Resize")

  | "user-select" => Some("UserSelect")
  | "pointer-events" => Some("PointerEvents")
  | "touch-action" => Some("TouchAction")

  | "perspective" => Some("Perspective")
  | "perspective-origin" => Some("PerspectiveOrigin")
  | "backface-visibility" => Some("BackfaceVisibility")

  | "object-fit" => Some("ObjectFit")
  | "object-position" => Some("ObjectPosition")
  | "offset-anchor" => Some("OffsetAnchor")

  | "aspect-ratio" => Some("AspectRatio")
  | "isolation" => Some("Isolation")

  | "list-style-type" => Some("ListStyleType")
  | "list-style-position" => Some("ListStylePosition")
  | "list-style-image" => Some("ListStyleImage")

  | "font-weight" => Some("FontWeight")
  | "font-style" => Some("FontStyle")
  | "font-variant" => Some("FontVariant")
  | "font-variant-caps" => Some("FontVariantCaps")
  | "font-variant-position" => Some("FontVariantPosition")
  | "font-variant-emoji" => Some("FontVariantEmoji")
  | "font-kerning" => Some("FontKerning")
  | "font-optical-sizing" => Some("FontOpticalSizing")
  | "font-synthesis-weight" => Some("FontSynthesisWeight")
  | "font-synthesis-style" => Some("FontSynthesisStyle")
  | "font-synthesis-small-caps" => Some("FontSynthesisSmallCaps")
  | "font-synthesis-position" => Some("FontSynthesisPosition")

  | "direction" => Some("Direction")
  | "image-rendering" => Some("ImageRendering")
  | "image-orientation" => Some("ImageOrientation")

  | "mask-image" => Some("MaskImage")
  | "mask-position" => Some("MaskPosition")
  | "content" => Some("Content")

  | "counter-increment" => Some("CounterIncrement")
  | "counter-reset" => Some("CounterReset")
  | "counter-set" => Some("CounterSet")

  | "column-width" => Some("ColumnWidth")
  | "column-count" => Some("ColumnCount")
  | "table-layout" => Some("TableLayout")

  | "scrollbar-width" => Some("ScrollbarWidth")
  | "scrollbar-gutter" => Some("ScrollbarGutter")
  | "scrollbar-color" => Some("ScrollbarColor")
  | "scroll-behavior" => Some("ScrollBehavior")

  | "fill" => Some("SVG.Fill")
  | "stroke-opacity" => Some("AlphaValue")
  | "clip-path" => Some("ClipPath")

  | _ => None
  };
};

/* Parse a CSS property value and extract interpolation types.

   This function:
   1. Finds the property's parser
   2. Parses the value to get typed AST
   3. Pattern matches on AST to find interpolations and their types
   4. Returns list of (variable_path, type_module_name)
*/
let extract_interpolations_from_value = (property_name: string, value: string): list((list(string), string)) => {
  /* For now, use the simple property-based approach since:
     - The parser AST types are complex polymorphic variants
     - Each property has many possible variants
     - We'd need exhaustive pattern matching for each property type

     The property-level type module is sufficient because:
     - OCaml's type system will enforce correctness at the interpolation site
     - The Css_types modules handle all variants of their type
     - For example, Margin.toString handles both Length.t and Auto.t
  */

  /* TODO: Implement proper AST walking to extract interpolations and their specific types.
     For example, for "flex: 1 1 $(basis)", we should:
     1. Parse with Property_flex.parser
     2. Get AST like `Or(Some((grow, Some(shrink))), Some(Interpolation(basis)))
     3. Determine that the interpolation is in flex-basis position
     4. Return (basis, "FlexBasis") or more specifically the narrower type if possible
  */

  /* For now, just return empty since Css_runtime will use get_type_for_property */
  [];
};

/* Get the Css_types module name for a property.
   This is used by Css_runtime to generate toString calls. */
let get_type_module = get_type_for_property;
