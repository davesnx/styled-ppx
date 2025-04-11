/*
   Contains all HTML attributes for all elements and ReactDOM specifics.
   This list is part of the `makeProps` that generates the component API for HTML elements
   Taken from: https://github.com/reasonml/reason-react/blob/master/src/ReactDOM.re
   Snapshot: https://gist.github.com/davesnx/22f0e81b6d7450e3e0dcc157595426f2
 */

open Ppxlib;

type alias = option(string);
type eventType =
  | Animation
  | Clipboard
  | Composition
  | Focus
  | Form
  | Keyboard
  | Media
  | Mouse
  | Selection
  | Touch
  | Transition
  | UI
  | Wheel;

type event = {
  name: string,
  type_: eventType,
};

type attributeType =
  | Bool
  | Float
  | Int
  | String
  | Style;

type attr = {
  name: string,
  type_: attributeType,
  alias,
};
type domProp =
  | Event(event)
  | Attribute(attr);

let data = [
  Attribute({
    name: "about",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "accentHeight",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "accept",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "acceptCharset",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "accessKey",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "accumulate",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "action",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "additive",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "alignmentBaseline",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "allowFullScreen",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "allowReorder",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "alphabetic",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "alt",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "amplitude",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "arabicForm",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "ariaActivedescendant",
    type_: String,
    alias: Some("aria-activedescendant"),
  }),
  Attribute({
    name: "ariaAtomic",
    type_: Bool,
    alias: Some("aria-atomic"),
  }),
  Attribute({
    name: "ariaBusy",
    type_: Bool,
    alias: Some("aria-busy"),
  }),
  Attribute({
    name: "ariaColcount",
    type_: Int,
    alias: Some("aria-colcount"),
  }),
  Attribute({
    name: "ariaColindex",
    type_: Int,
    alias: Some("aria-colindex"),
  }),
  Attribute({
    name: "ariaColspan",
    type_: Int,
    alias: Some("aria-colspan"),
  }),
  Attribute({
    name: "ariaControls",
    type_: String,
    alias: Some("aria-controls"),
  }),
  Attribute({
    name: "ariaDescribedby",
    type_: String,
    alias: Some("aria-describedby"),
  }),
  Attribute({
    name: "ariaDetails",
    type_: String,
    alias: Some("aria-details"),
  }),
  Attribute({
    name: "ariaDisabled",
    type_: Bool,
    alias: Some("aria-disabled"),
  }),
  Attribute({
    name: "ariaErrormessage",
    type_: String,
    alias: Some("aria-errormessage"),
  }),
  Attribute({
    name: "ariaExpanded",
    type_: Bool,
    alias: Some("aria-expanded"),
  }),
  Attribute({
    name: "ariaFlowto",
    type_: String,
    alias: Some("aria-flowto"),
  }),
  Attribute({
    name: "ariaGrabbed",
    type_: Bool,
    alias: Some("aria-grabbed"),
  }),
  Attribute({
    name: "ariaHidden",
    type_: Bool,
    alias: Some("aria-hidden"),
  }),
  Attribute({
    name: "ariaKeyshortcuts",
    type_: String,
    alias: Some("aria-keyshortcuts"),
  }),
  Attribute({
    name: "ariaLabel",
    type_: String,
    alias: Some("aria-label"),
  }),
  Attribute({
    name: "ariaLabelledby",
    type_: String,
    alias: Some("aria-labelledby"),
  }),
  Attribute({
    name: "ariaLevel",
    type_: Int,
    alias: Some("aria-level"),
  }),
  Attribute({
    name: "ariaModal",
    type_: Bool,
    alias: Some("aria-modal"),
  }),
  Attribute({
    name: "ariaMultiline",
    type_: Bool,
    alias: Some("aria-multiline"),
  }),
  Attribute({
    name: "ariaMultiselectable",
    type_: Bool,
    alias: Some("aria-multiselectable"),
  }),
  Attribute({
    name: "ariaOwns",
    type_: String,
    alias: Some("aria-owns"),
  }),
  Attribute({
    name: "ariaPlaceholder",
    type_: String,
    alias: Some("aria-placeholder"),
  }),
  Attribute({
    name: "ariaPosinset",
    type_: Int,
    alias: Some("aria-posinset"),
  }),
  Attribute({
    name: "ariaReadonly",
    type_: Bool,
    alias: Some("aria-readonly"),
  }),
  Attribute({
    name: "ariaRelevant",
    type_: String,
    alias: Some("aria-relevant"),
  }),
  Attribute({
    name: "ariaRequired",
    type_: Bool,
    alias: Some("aria-required"),
  }),
  Attribute({
    name: "ariaRoledescription",
    type_: String,
    alias: Some("aria-roledescription"),
  }),
  Attribute({
    name: "ariaRowcount",
    type_: Int,
    alias: Some("aria-rowcount"),
  }),
  Attribute({
    name: "ariaRowindex",
    type_: Int,
    alias: Some("aria-rowindex"),
  }),
  Attribute({
    name: "ariaRowspan",
    type_: Int,
    alias: Some("aria-rowspan"),
  }),
  Attribute({
    name: "ariaSelected",
    type_: Bool,
    alias: Some("aria-selected"),
  }),
  Attribute({
    name: "ariaSetsize",
    type_: Int,
    alias: Some("aria-setsize"),
  }),
  Attribute({
    name: "ariaSort",
    type_: String,
    alias: Some("aria-sort"),
  }),
  Attribute({
    name: "ariaValuemax",
    type_: Float,
    alias: Some("aria-valuemax"),
  }),
  Attribute({
    name: "ariaValuemin",
    type_: Float,
    alias: Some("aria-valuemin"),
  }),
  Attribute({
    name: "ariaValuenow",
    type_: Float,
    alias: Some("aria-valuenow"),
  }),
  Attribute({
    name: "ariaValuetext",
    type_: String,
    alias: Some("aria-valuetext"),
  }),
  Attribute({
    name: "ascent",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "async",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "attributeName",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "attributeType",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "autoComplete",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "autoFocus",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "autoPlay",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "autoReverse",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "azimuth",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "baseFrequency",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "baselineShift",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "baseProfile",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "bbox",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "begin_",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "bias",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "by",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "calcMode",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "capHeight",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "challenge",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "charSet",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "checked",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "cite",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "className",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "clip",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "clipPath",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "clipPathUnits",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "clipRule",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "colorInterpolation",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "colorInterpolationFilters",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "colorProfile",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "colorRendering",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "cols",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "colSpan",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "content",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "contentEditable",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "contentScriptType",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "contentStyleType",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "contextMenu",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "controls",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "coords",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "crossOrigin",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "cursor",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "cx",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "cy",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "d",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "data",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "datatype",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "dateTime",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "decelerate",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "default",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "defaultChecked",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "defaultValue",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "defer",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "descent",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "diffuseConstant",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "dir",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "direction",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "disabled",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "display",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "divisor",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "dominantBaseline",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "download",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "draggable",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "dur",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "dx",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "dy",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "edgeMode",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "elevation",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "enableBackground",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "encType",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "end_",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "exponent",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "externalResourcesRequired",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fill",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fillOpacity",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fillRule",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "filter",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "filterRes",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "filterUnits",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "floodColor",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "floodOpacity",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "focusable",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fomat",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fontFamily",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fontSize",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fontSizeAdjust",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fontStretch",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fontStyle",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fontVariant",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fontWeight",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "form",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "formAction",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "formMethod",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "formTarget",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "from",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fx",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "fy",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "g1",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "g2",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "glyphName",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "glyphOrientationHorizontal",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "glyphOrientationVertical",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "glyphRef",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "gradientTransform",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "gradientUnits",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "hanging",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "headers",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "height",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "hidden",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "high",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "horizAdvX",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "horizOriginX",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "href",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "hrefLang",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "htmlFor",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "httpEquiv",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "icon",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "id",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "ideographic",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "imageRendering",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "in_",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "in2",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "inlist",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "inputMode",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "integrity",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "intercept",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "itemID",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "itemProp",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "itemRef",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "itemScope",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "itemType",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "k",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "k1",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "k2",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "k3",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "k4",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "kernelMatrix",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "kernelUnitLength",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "kerning",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "key",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "keyPoints",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "keySplines",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "keyTimes",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "keyType",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "kind",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "label",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "lang",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "lengthAdjust",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "letterSpacing",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "lightingColor",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "limitingConeAngle",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "list",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "local",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "loop",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "low",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "manifest",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "markerEnd",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "markerHeight",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "markerMid",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "markerStart",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "markerUnits",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "markerWidth",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "mask",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "maskContentUnits",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "maskUnits",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "mathematical",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "max",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "maxLength",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "media",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "mediaGroup",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "min",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "minLength",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "mode",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "multiple",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "muted",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "name",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "nonce",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "noValidate",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "numOctaves",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "offset",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "opacity",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "open_",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "operator",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "optimum",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "order",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "orient",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "orientation",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "origin",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "overflow",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "overflowX",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "overflowY",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "overlinePosition",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "overlineThickness",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "paintOrder",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "panose1",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "pathLength",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "pattern",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "patternContentUnits",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "patternTransform",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "patternUnits",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "placeholder",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "pointerEvents",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "points",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "pointsAtX",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "pointsAtY",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "pointsAtZ",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "poster",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "prefix",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "preload",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "preserveAlpha",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "preserveAspectRatio",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "primitiveUnits",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "property",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "r",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "radioGroup",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "radius",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "readOnly",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "refX",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "refY",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "rel",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "renderingIntent",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "repeatCount",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "repeatDur",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "required",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "requiredExtensions",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "requiredFeatures",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "resource",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "restart",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "result",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "reversed",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "role",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "rotate",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "rows",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "rowSpan",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "rx",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "ry",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "sandbox",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "scale",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "scope",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "scoped",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "scrolling",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "seed",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "selected",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "shape",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "shapeRendering",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "size",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "sizes",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "slope",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "spacing",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "span",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "specularConstant",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "specularExponent",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "speed",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "spellCheck",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "spreadMethod",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "src",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "srcDoc",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "srcLang",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "srcSet",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "start",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "startOffset",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "stdDeviation",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "stemh",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "stemv",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "step",
    type_: Float,
    alias: None,
  }),
  Attribute({
    name: "stitchTiles",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "stopColor",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "stopOpacity",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "strikethroughPosition",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "strikethroughThickness",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "stroke",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "strokeDasharray",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "strokeDashoffset",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "strokeLinecap",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "strokeLinejoin",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "strokeMiterlimit",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "strokeOpacity",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "strokeWidth",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "style",
    type_: Style,
    alias: None,
  }),
  Attribute({
    name: "summary",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "suppressContentEditableWarning",
    type_: Bool,
    alias: None,
  }),
  Attribute({
    name: "surfaceScale",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "systemLanguage",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "tabIndex",
    type_: Int,
    alias: None,
  }),
  Attribute({
    name: "tableValues",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "target",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "targetX",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "targetY",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "textAnchor",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "textDecoration",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "textLength",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "textRendering",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "title",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "to_",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "transform",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "type_",
    type_: String,
    alias: Some("type"),
  }),
  Attribute({
    name: "typeof",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "u1",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "u2",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "underlinePosition",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "underlineThickness",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "unicode",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "unicodeBidi",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "unicodeRange",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "unitsPerEm",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "useMap",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "vAlphabetic",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "value",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "values",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "vectorEffect",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "version",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "vertAdvX",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "vertAdvY",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "vertOriginX",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "vertOriginY",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "vHanging",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "vIdeographic",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "viewBox",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "viewTarget",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "visibility",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "vMathematical",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "vocab",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "width",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "widths",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "wordSpacing",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "wrap",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "writingMode",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "x",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "x1",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "x2",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xChannelSelector",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xHeight",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xlinkActuate",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xlinkArcrole",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xlinkHref",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xlinkRole",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xlinkShow",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xlinkTitle",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xlinkType",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xmlBase",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xmlLang",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xmlns",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xmlnsXlink",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "xmlSpace",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "y",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "y1",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "y2",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "yChannelSelector",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "z",
    type_: String,
    alias: None,
  }),
  Attribute({
    name: "zoomAndPan",
    type_: String,
    alias: None,
  }),
  Event({
    name: "onAbort",
    type_: Media,
  }),
  Event({
    name: "onAnimationEnd",
    type_: Animation,
  }),
  Event({
    name: "onAnimationIteration",
    type_: Animation,
  }),
  Event({
    name: "onAnimationStart",
    type_: Animation,
  }),
  Event({
    name: "onBlur",
    type_: Focus,
  }),
  Event({
    name: "onCanPlay",
    type_: Media,
  }),
  Event({
    name: "onCanPlayThrough",
    type_: Media,
  }),
  Event({
    name: "onChange",
    type_: Form,
  }),
  Event({
    name: "onClick",
    type_: Mouse,
  }),
  Event({
    name: "onCompositionEnd",
    type_: Composition,
  }),
  Event({
    name: "onCompositionStart",
    type_: Composition,
  }),
  Event({
    name: "onCompositionUpdate",
    type_: Composition,
  }),
  Event({
    name: "onContextMenu",
    type_: Mouse,
  }),
  Event({
    name: "onCopy",
    type_: Clipboard,
  }),
  Event({
    name: "onCut",
    type_: Clipboard,
  }),
  Event({
    name: "onDoubleClick",
    type_: Mouse,
  }),
  Event({
    name: "onDrag",
    type_: Mouse,
  }),
  Event({
    name: "onDragEnd",
    type_: Mouse,
  }),
  Event({
    name: "onDragEnter",
    type_: Mouse,
  }),
  Event({
    name: "onDragExit",
    type_: Mouse,
  }),
  Event({
    name: "onDragLeave",
    type_: Mouse,
  }),
  Event({
    name: "onDragOver",
    type_: Mouse,
  }),
  Event({
    name: "onDragStart",
    type_: Mouse,
  }),
  Event({
    name: "onDrop",
    type_: Mouse,
  }),
  Event({
    name: "onDurationChange",
    type_: Media,
  }),
  Event({
    name: "onEmptied",
    type_: Media,
  }),
  Event({
    name: "onEncrypetd",
    type_: Media,
  }),
  Event({
    name: "onEnded",
    type_: Media,
  }),
  Event({
    name: "onError",
    type_: Media,
  }),
  Event({
    name: "onFocus",
    type_: Focus,
  }),
  Event({
    name: "onInput",
    type_: Form,
  }),
  Event({
    name: "onKeyDown",
    type_: Keyboard,
  }),
  Event({
    name: "onKeyPress",
    type_: Keyboard,
  }),
  Event({
    name: "onKeyUp",
    type_: Keyboard,
  }),
  Event({
    name: "onLoadedData",
    type_: Media,
  }),
  Event({
    name: "onLoadedMetadata",
    type_: Media,
  }),
  Event({
    name: "onLoadStart",
    type_: Media,
  }),
  Event({
    name: "onMouseDown",
    type_: Mouse,
  }),
  Event({
    name: "onMouseEnter",
    type_: Mouse,
  }),
  Event({
    name: "onMouseLeave",
    type_: Mouse,
  }),
  Event({
    name: "onMouseMove",
    type_: Mouse,
  }),
  Event({
    name: "onMouseOut",
    type_: Mouse,
  }),
  Event({
    name: "onMouseOver",
    type_: Mouse,
  }),
  Event({
    name: "onMouseUp",
    type_: Mouse,
  }),
  Event({
    name: "onPaste",
    type_: Clipboard,
  }),
  Event({
    name: "onPause",
    type_: Media,
  }),
  Event({
    name: "onPlay",
    type_: Media,
  }),
  Event({
    name: "onPlaying",
    type_: Media,
  }),
  Event({
    name: "onProgress",
    type_: Media,
  }),
  Event({
    name: "onRateChange",
    type_: Media,
  }),
  Event({
    name: "onScroll",
    type_: UI,
  }),
  Event({
    name: "onSeeked",
    type_: Media,
  }),
  Event({
    name: "onSeeking",
    type_: Media,
  }),
  Event({
    name: "onSelect",
    type_: Selection,
  }),
  Event({
    name: "onStalled",
    type_: Media,
  }),
  Event({
    name: "onSubmit",
    type_: Form,
  }),
  Event({
    name: "onSuspend",
    type_: Media,
  }),
  Event({
    name: "onTimeUpdate",
    type_: Media,
  }),
  Event({
    name: "onTouchCancel",
    type_: Touch,
  }),
  Event({
    name: "onTouchEnd",
    type_: Touch,
  }),
  Event({
    name: "onTouchMove",
    type_: Touch,
  }),
  Event({
    name: "onTouchStart",
    type_: Touch,
  }),
  Event({
    name: "onTransitionEnd",
    type_: Transition,
  }),
  Event({
    name: "onVolumeChange",
    type_: Media,
  }),
  Event({
    name: "onWaiting",
    type_: Media,
  }),
  Event({
    name: "onWheel",
    type_: Wheel,
  }),
];

let hasName = (prop, propName) => {
  switch (prop) {
  | Attribute({name, _}) => name == propName
  | Event({name, _}) => name == propName
  };
};

/* If a name from props collide with an attribute, we exclude it from the list
   of available makeProps */
let get = propsToExclude => {
  let findInExclude = prop => List.find_opt(hasName(prop), propsToExclude);

  data |> List.filter(prop => {prop |> findInExclude |> Option.is_none});
};

let attributeTypeToIdent =
  fun
  | Bool => Lident("bool")
  | Float => Lident("float")
  | Int => Lident("int")
  | String => Lident("string")
  | Style => Ldot(Ldot(Lident("ReactDOM"), "Style"), "t");

module Reason = {
  let eventTypeToIdent =
    fun
    | Animation =>
      Ldot(Ldot(Ldot(Lident("React"), "Event"), "Animation"), "t")
    | Clipboard =>
      Ldot(Ldot(Ldot(Lident("React"), "Event"), "Clipboard"), "t")
    | Composition =>
      Ldot(Ldot(Ldot(Lident("React"), "Event"), "Composition"), "t")
    | Focus => Ldot(Ldot(Ldot(Lident("React"), "Event"), "Focus"), "t")
    | Form => Ldot(Ldot(Ldot(Lident("React"), "Event"), "Form"), "t")
    | Keyboard =>
      Ldot(Ldot(Ldot(Lident("React"), "Event"), "Keyboard"), "t")
    | Media => Ldot(Ldot(Ldot(Lident("React"), "Event"), "Media"), "t")
    | Mouse => Ldot(Ldot(Ldot(Lident("React"), "Event"), "Mouse"), "t")
    | Selection =>
      Ldot(Ldot(Ldot(Lident("React"), "Event"), "Selection"), "t")
    | Touch => Ldot(Ldot(Ldot(Lident("React"), "Event"), "Touch"), "t")
    | Transition =>
      Ldot(Ldot(Ldot(Lident("React"), "Event"), "Transition"), "t")
    | UI => Ldot(Ldot(Ldot(Lident("React"), "Event"), "UI"), "t")
    | Wheel => Ldot(Ldot(Ldot(Lident("React"), "Event"), "Wheel"), "t");
};

module ReScript = {
  let eventTypeToIdent =
    fun
    | Animation => Ldot(Ldot(Lident("ReactEvent"), "Animation"), "t")
    | Clipboard => Ldot(Ldot(Lident("ReactEvent"), "Clipboard"), "t")
    | Composition => Ldot(Ldot(Lident("ReactEvent"), "Composition"), "t")
    | Focus => Ldot(Ldot(Lident("ReactEvent"), "Focus"), "t")
    | Form => Ldot(Ldot(Lident("ReactEvent"), "Form"), "t")
    | Keyboard => Ldot(Ldot(Lident("ReactEvent"), "Keyboard"), "t")
    | Media => Ldot(Ldot(Lident("ReactEvent"), "Media"), "t")
    | Mouse => Ldot(Ldot(Lident("ReactEvent"), "Mouse"), "t")
    | Selection => Ldot(Ldot(Lident("ReactEvent"), "Selection"), "t")
    | Touch => Ldot(Ldot(Lident("ReactEvent"), "Touch"), "t")
    | Transition => Ldot(Ldot(Lident("ReactEvent"), "Transition"), "t")
    | UI => Ldot(Ldot(Lident("ReactEvent"), "UI"), "t")
    | Wheel => Ldot(Ldot(Lident("ReactEvent"), "Wheel"), "t");
};

let eventTypeToIdent = type_ => {
  /* reason-react exposes React.Event while rescript/react ReactEvent */
  switch (File.get()) {
  | Some(ReScript) => ReScript.eventTypeToIdent(type_)
  | Some(Reason)
  | _ => Reason.eventTypeToIdent(type_)
  };
};
