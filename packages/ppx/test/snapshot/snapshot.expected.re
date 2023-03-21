ignore(
  CssJs.global(.
    {js|html, body, #root, .class|js},
    [|CssJs.margin(`zero)|],
  ),
);
module ShoudNotBreakOtherModulesPpxsWithStringAsPayload = [%ppx ""];
module ShoudNotBreakOtherModulesPpxsWithMultiStringAsPayload = [%ppx
  {| stuff |}
];
module OneSingleProperty = {
  type props = JsxDOM.domProps;
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles =
    CssJs.style(. [|
      CssJs.label("OneSingleProperty"),
      CssJs.display(`block),
    |]);
  let make = (props: props) => {
    let className = styles ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    createVariadicElement("div", newProps);
  };
};
module SingleQuoteStrings = {
  type props = JsxDOM.domProps;
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles =
    CssJs.style(. [|
      CssJs.label("SingleQuoteStrings"),
      CssJs.display(`flex),
      CssJs.unsafe({js|justifyContent|js}, {js|center|js}),
    |]);
  let make = (props: props) => {
    let className = styles ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    createVariadicElement("section", newProps);
  };
};
module MultiLineStrings = {
  type props = JsxDOM.domProps;
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles =
    CssJs.style(. [|
      CssJs.label("MultiLineStrings"),
      CssJs.display(`flex),
      CssJs.unsafe({js|justifyContent|js}, {js|center|js}),
    |]);
  let make = (props: props) => {
    let className = styles ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    createVariadicElement("section", newProps);
  };
};
module SelfClosingElement = {
  type props = JsxDOM.domProps;
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles = CssJs.style(. [|CssJs.label("SelfClosingElement")|]);
  let make = (props: props) => {
    let className = styles ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    createVariadicElement("input", newProps);
  };
};
module ArrayStatic = {
  type props = JsxDOM.domProps;
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles =
    CssJs.style(. [|
      CssJs.label("ArrayStatic"),
      CssJs.display(`flex),
      CssJs.unsafe({js|justifyContent|js}, {js|center|js}),
    |]);
  let make = (props: props) => {
    let className = styles ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    createVariadicElement("section", newProps);
  };
};
module Theme = {
  let var = "#333333";
  module Border = {
    let black = "#222222";
  };
};
let black = "#000";
module StringInterpolation = {
  type props = JsxDOM.domProps;
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles =
    CssJs.style(. [|
      CssJs.label("StringInterpolation"),
      (CssJs.color(Theme.var): CssJs.rule),
      (CssJs.backgroundColor(black): CssJs.rule),
      (CssJs.borderColor(Theme.Border.black): CssJs.rule),
      CssJs.display(`block),
    |]);
  let make = (props: props) => {
    let className = styles ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    createVariadicElement("div", newProps);
  };
};
let className =
  CssJs.style(. [|CssJs.label("className"), CssJs.display(`block)|]);
let classNameWithMultiLine =
  CssJs.style(. [|
    CssJs.label("classNameWithMultiLine"),
    CssJs.display(`block),
  |]);
let classNameWithArray =
  CssJs.style(. [|CssJs.label("classNameWithArray"), cssProperty|]);
let cssRule = CssJs.color(CssJs.blue);
let classNameWithCss =
  CssJs.style(. [|
    CssJs.label("classNameWithCss"),
    cssRule,
    CssJs.backgroundColor(CssJs.green),
  |]);
module DynamicComponent = {
  type props('var) = {
    ref: ReactDOM.domRef,
    children: React.element,
    [@optional]
    about: string,
    [@optional]
    accentHeight: string,
    [@optional]
    accept: string,
    [@optional]
    acceptCharset: string,
    [@optional]
    accessKey: string,
    [@optional]
    accumulate: string,
    [@optional]
    action: string,
    [@optional]
    additive: string,
    [@optional]
    alignmentBaseline: string,
    [@optional]
    allowFullScreen: bool,
    [@optional]
    allowReorder: string,
    [@optional]
    alphabetic: string,
    [@optional]
    alt: string,
    [@optional]
    amplitude: string,
    [@optional]
    arabicForm: string,
    [@optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@optional]
    ascent: string,
    [@optional]
    async: bool,
    [@optional]
    attributeName: string,
    [@optional]
    attributeType: string,
    [@optional]
    autoComplete: string,
    [@optional]
    autoFocus: bool,
    [@optional]
    autoPlay: bool,
    [@optional]
    autoReverse: string,
    [@optional]
    azimuth: string,
    [@optional]
    baseFrequency: string,
    [@optional]
    baselineShift: string,
    [@optional]
    baseProfile: string,
    [@optional]
    bbox: string,
    [@optional]
    begin_: string,
    [@optional]
    bias: string,
    [@optional]
    by: string,
    [@optional]
    calcMode: string,
    [@optional]
    capHeight: string,
    [@optional]
    challenge: string,
    [@optional]
    charSet: string,
    [@optional]
    checked: bool,
    [@optional]
    cite: string,
    [@optional]
    className: string,
    [@optional]
    clip: string,
    [@optional]
    clipPath: string,
    [@optional]
    clipPathUnits: string,
    [@optional]
    clipRule: string,
    [@optional]
    colorInterpolation: string,
    [@optional]
    colorInterpolationFilters: string,
    [@optional]
    colorProfile: string,
    [@optional]
    colorRendering: string,
    [@optional]
    cols: int,
    [@optional]
    colSpan: int,
    [@optional]
    content: string,
    [@optional]
    contentEditable: bool,
    [@optional]
    contentScriptType: string,
    [@optional]
    contentStyleType: string,
    [@optional]
    contextMenu: string,
    [@optional]
    controls: bool,
    [@optional]
    coords: string,
    [@optional]
    crossorigin: bool,
    [@optional]
    cursor: string,
    [@optional]
    cx: string,
    [@optional]
    cy: string,
    [@optional]
    d: string,
    [@optional]
    data: string,
    [@optional]
    datatype: string,
    [@optional]
    dateTime: string,
    [@optional]
    decelerate: string,
    [@optional]
    default: bool,
    [@optional]
    defaultChecked: bool,
    [@optional]
    defaultValue: string,
    [@optional]
    defer: bool,
    [@optional]
    descent: string,
    [@optional]
    diffuseConstant: string,
    [@optional]
    dir: string,
    [@optional]
    direction: string,
    [@optional]
    disabled: bool,
    [@optional]
    display: string,
    [@optional]
    divisor: string,
    [@optional]
    dominantBaseline: string,
    [@optional]
    download: string,
    [@optional]
    draggable: bool,
    [@optional]
    dur: string,
    [@optional]
    dx: string,
    [@optional]
    dy: string,
    [@optional]
    edgeMode: string,
    [@optional]
    elevation: string,
    [@optional]
    enableBackground: string,
    [@optional]
    encType: string,
    [@optional]
    end_: string,
    [@optional]
    exponent: string,
    [@optional]
    externalResourcesRequired: string,
    [@optional]
    fill: string,
    [@optional]
    fillOpacity: string,
    [@optional]
    fillRule: string,
    [@optional]
    filter: string,
    [@optional]
    filterRes: string,
    [@optional]
    filterUnits: string,
    [@optional]
    floodColor: string,
    [@optional]
    floodOpacity: string,
    [@optional]
    focusable: string,
    [@optional]
    fomat: string,
    [@optional]
    fontFamily: string,
    [@optional]
    fontSize: string,
    [@optional]
    fontSizeAdjust: string,
    [@optional]
    fontStretch: string,
    [@optional]
    fontStyle: string,
    [@optional]
    fontVariant: string,
    [@optional]
    fontWeight: string,
    [@optional]
    form: string,
    [@optional]
    formAction: string,
    [@optional]
    formMethod: string,
    [@optional]
    formTarget: string,
    [@optional]
    from: string,
    [@optional]
    fx: string,
    [@optional]
    fy: string,
    [@optional]
    g1: string,
    [@optional]
    g2: string,
    [@optional]
    glyphName: string,
    [@optional]
    glyphOrientationHorizontal: string,
    [@optional]
    glyphOrientationVertical: string,
    [@optional]
    glyphRef: string,
    [@optional]
    gradientTransform: string,
    [@optional]
    gradientUnits: string,
    [@optional]
    hanging: string,
    [@optional]
    headers: string,
    [@optional]
    height: string,
    [@optional]
    hidden: bool,
    [@optional]
    high: int,
    [@optional]
    horizAdvX: string,
    [@optional]
    horizOriginX: string,
    [@optional]
    href: string,
    [@optional]
    hrefLang: string,
    [@optional]
    htmlFor: string,
    [@optional]
    httpEquiv: string,
    [@optional]
    icon: string,
    [@optional]
    id: string,
    [@optional]
    ideographic: string,
    [@optional]
    imageRendering: string,
    [@optional]
    in_: string,
    [@optional]
    in2: string,
    [@optional]
    inlist: string,
    [@optional]
    inputMode: string,
    [@optional]
    integrity: string,
    [@optional]
    intercept: string,
    [@optional]
    itemID: string,
    [@optional]
    itemProp: string,
    [@optional]
    itemRef: string,
    [@optional]
    itemScope: bool,
    [@optional]
    itemType: string,
    [@optional]
    k: string,
    [@optional]
    k1: string,
    [@optional]
    k2: string,
    [@optional]
    k3: string,
    [@optional]
    k4: string,
    [@optional]
    kernelMatrix: string,
    [@optional]
    kernelUnitLength: string,
    [@optional]
    kerning: string,
    [@optional]
    key: string,
    [@optional]
    keyPoints: string,
    [@optional]
    keySplines: string,
    [@optional]
    keyTimes: string,
    [@optional]
    keyType: string,
    [@optional]
    kind: string,
    [@optional]
    label: string,
    [@optional]
    lang: string,
    [@optional]
    lengthAdjust: string,
    [@optional]
    letterSpacing: string,
    [@optional]
    lightingColor: string,
    [@optional]
    limitingConeAngle: string,
    [@optional]
    list: string,
    [@optional]
    local: string,
    [@optional]
    loop: bool,
    [@optional]
    low: int,
    [@optional]
    manifest: string,
    [@optional]
    markerEnd: string,
    [@optional]
    markerHeight: string,
    [@optional]
    markerMid: string,
    [@optional]
    markerStart: string,
    [@optional]
    markerUnits: string,
    [@optional]
    markerWidth: string,
    [@optional]
    mask: string,
    [@optional]
    maskContentUnits: string,
    [@optional]
    maskUnits: string,
    [@optional]
    mathematical: string,
    [@optional]
    max: string,
    [@optional]
    maxLength: int,
    [@optional]
    media: string,
    [@optional]
    mediaGroup: string,
    [@optional]
    min: int,
    [@optional]
    minLength: int,
    [@optional]
    mode: string,
    [@optional]
    multiple: bool,
    [@optional]
    muted: bool,
    [@optional]
    name: string,
    [@optional]
    nonce: string,
    [@optional]
    noValidate: bool,
    [@optional]
    numOctaves: string,
    [@optional]
    offset: string,
    [@optional]
    opacity: string,
    [@optional]
    open_: bool,
    [@optional]
    operator: string,
    [@optional]
    optimum: int,
    [@optional]
    order: string,
    [@optional]
    orient: string,
    [@optional]
    orientation: string,
    [@optional]
    origin: string,
    [@optional]
    overflow: string,
    [@optional]
    overflowX: string,
    [@optional]
    overflowY: string,
    [@optional]
    overlinePosition: string,
    [@optional]
    overlineThickness: string,
    [@optional]
    paintOrder: string,
    [@optional]
    panose1: string,
    [@optional]
    pathLength: string,
    [@optional]
    pattern: string,
    [@optional]
    patternContentUnits: string,
    [@optional]
    patternTransform: string,
    [@optional]
    patternUnits: string,
    [@optional]
    placeholder: string,
    [@optional]
    pointerEvents: string,
    [@optional]
    points: string,
    [@optional]
    pointsAtX: string,
    [@optional]
    pointsAtY: string,
    [@optional]
    pointsAtZ: string,
    [@optional]
    poster: string,
    [@optional]
    prefix: string,
    [@optional]
    preload: string,
    [@optional]
    preserveAlpha: string,
    [@optional]
    preserveAspectRatio: string,
    [@optional]
    primitiveUnits: string,
    [@optional]
    property: string,
    [@optional]
    r: string,
    [@optional]
    radioGroup: string,
    [@optional]
    radius: string,
    [@optional]
    readOnly: bool,
    [@optional]
    refX: string,
    [@optional]
    refY: string,
    [@optional]
    rel: string,
    [@optional]
    renderingIntent: string,
    [@optional]
    repeatCount: string,
    [@optional]
    repeatDur: string,
    [@optional]
    required: bool,
    [@optional]
    requiredExtensions: string,
    [@optional]
    requiredFeatures: string,
    [@optional]
    resource: string,
    [@optional]
    restart: string,
    [@optional]
    result: string,
    [@optional]
    reversed: bool,
    [@optional]
    role: string,
    [@optional]
    rotate: string,
    [@optional]
    rows: int,
    [@optional]
    rowSpan: int,
    [@optional]
    rx: string,
    [@optional]
    ry: string,
    [@optional]
    sandbox: string,
    [@optional]
    scale: string,
    [@optional]
    scope: string,
    [@optional]
    scoped: bool,
    [@optional]
    scrolling: string,
    [@optional]
    seed: string,
    [@optional]
    selected: bool,
    [@optional]
    shape: string,
    [@optional]
    shapeRendering: string,
    [@optional]
    size: int,
    [@optional]
    sizes: string,
    [@optional]
    slope: string,
    [@optional]
    spacing: string,
    [@optional]
    span: int,
    [@optional]
    specularConstant: string,
    [@optional]
    specularExponent: string,
    [@optional]
    speed: string,
    [@optional]
    spellCheck: bool,
    [@optional]
    spreadMethod: string,
    [@optional]
    src: string,
    [@optional]
    srcDoc: string,
    [@optional]
    srcLang: string,
    [@optional]
    srcSet: string,
    [@optional]
    start: int,
    [@optional]
    startOffset: string,
    [@optional]
    stdDeviation: string,
    [@optional]
    stemh: string,
    [@optional]
    stemv: string,
    [@optional]
    step: float,
    [@optional]
    stitchTiles: string,
    [@optional]
    stopColor: string,
    [@optional]
    stopOpacity: string,
    [@optional]
    strikethroughPosition: string,
    [@optional]
    strikethroughThickness: string,
    [@optional]
    stroke: string,
    [@optional]
    strokeDasharray: string,
    [@optional]
    strokeDashoffset: string,
    [@optional]
    strokeLinecap: string,
    [@optional]
    strokeLinejoin: string,
    [@optional]
    strokeMiterlimit: string,
    [@optional]
    strokeOpacity: string,
    [@optional]
    strokeWidth: string,
    [@optional]
    style: ReactDOM.Style.t,
    [@optional]
    summary: string,
    [@optional]
    suppressContentEditableWarning: bool,
    [@optional]
    surfaceScale: string,
    [@optional]
    systemLanguage: string,
    [@optional]
    tabIndex: int,
    [@optional]
    tableValues: string,
    [@optional]
    target: string,
    [@optional]
    targetX: string,
    [@optional]
    targetY: string,
    [@optional]
    textAnchor: string,
    [@optional]
    textDecoration: string,
    [@optional]
    textLength: string,
    [@optional]
    textRendering: string,
    [@optional]
    title: string,
    [@optional]
    to_: string,
    [@optional]
    transform: string,
    [@optional] [@bs.as "type"]
    type_: string,
    [@optional]
    typeof: string,
    [@optional]
    u1: string,
    [@optional]
    u2: string,
    [@optional]
    underlinePosition: string,
    [@optional]
    underlineThickness: string,
    [@optional]
    unicode: string,
    [@optional]
    unicodeBidi: string,
    [@optional]
    unicodeRange: string,
    [@optional]
    unitsPerEm: string,
    [@optional]
    useMap: string,
    [@optional]
    vAlphabetic: string,
    [@optional]
    value: string,
    [@optional]
    values: string,
    [@optional]
    vectorEffect: string,
    [@optional]
    version: string,
    [@optional]
    vertAdvX: string,
    [@optional]
    vertAdvY: string,
    [@optional]
    vertOriginX: string,
    [@optional]
    vertOriginY: string,
    [@optional]
    vHanging: string,
    [@optional]
    vIdeographic: string,
    [@optional]
    viewBox: string,
    [@optional]
    viewTarget: string,
    [@optional]
    visibility: string,
    [@optional]
    vMathematical: string,
    [@optional]
    vocab: string,
    [@optional]
    width: string,
    [@optional]
    widths: string,
    [@optional]
    wordSpacing: string,
    [@optional]
    wrap: string,
    [@optional]
    writingMode: string,
    [@optional]
    x: string,
    [@optional]
    x1: string,
    [@optional]
    x2: string,
    [@optional]
    xChannelSelector: string,
    [@optional]
    xHeight: string,
    [@optional]
    xlinkActuate: string,
    [@optional]
    xlinkArcrole: string,
    [@optional]
    xlinkHref: string,
    [@optional]
    xlinkRole: string,
    [@optional]
    xlinkShow: string,
    [@optional]
    xlinkTitle: string,
    [@optional]
    xlinkType: string,
    [@optional]
    xmlBase: string,
    [@optional]
    xmlLang: string,
    [@optional]
    xmlns: string,
    [@optional]
    xmlnsXlink: string,
    [@optional]
    xmlSpace: string,
    [@optional]
    y: string,
    [@optional]
    y1: string,
    [@optional]
    y2: string,
    [@optional]
    yChannelSelector: string,
    [@optional]
    z: string,
    [@optional]
    zoomAndPan: string,
    [@optional]
    onAbort: ReactEvent.Media.t => unit,
    [@optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@optional]
    onChange: ReactEvent.Form.t => unit,
    [@optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@optional]
    onEnded: ReactEvent.Media.t => unit,
    [@optional]
    onError: ReactEvent.Media.t => unit,
    [@optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@optional]
    onInput: ReactEvent.Form.t => unit,
    [@optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@optional]
    onPause: ReactEvent.Media.t => unit,
    [@optional]
    onPlay: ReactEvent.Media.t => unit,
    [@optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@optional]
    onProgress: ReactEvent.Media.t => unit,
    [@optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@optional]
    onScroll: ReactEvent.UI.t => unit,
    [@optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@optional]
    onStalled: ReactEvent.Media.t => unit,
    [@optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@optional]
    onWheel: ReactEvent.Wheel.t => unit,
    var: 'var,
  };
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles = (~var, _) =>
    CssJs.style(. [|
      CssJs.label("DynamicComponent"),
      (CssJs.color(var): CssJs.rule),
      CssJs.display(`block),
    |]);
  let make = (props: props('var)) => {
    let className =
      styles(~var=props.var, ()) ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "var"));
    createVariadicElement("div", newProps);
  };
};
module SelectorsMediaQueries = {
  type props = JsxDOM.domProps;
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles =
    CssJs.style(. [|
      CssJs.label("SelectorsMediaQueries"),
      CssJs.media(.
        {js|(min-width: 600px)|js},
        [|CssJs.backgroundColor(CssJs.blue)|],
      ),
      CssJs.selector(.
        {js|&:hover|js},
        [|CssJs.backgroundColor(CssJs.green)|],
      ),
      CssJs.selector(.
        {js|& > p|js},
        [|CssJs.color(CssJs.pink), CssJs.fontSize(`pxFloat(24.))|],
      ),
    |]);
  let make = (props: props) => {
    let className = styles ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    createVariadicElement("div", newProps);
  };
};
let keyframe =
  CssJs.keyframes(. [|
    (0, [|CssJs.opacity(0.)|]),
    (100, [|CssJs.opacity(1.)|]),
  |]);
module ArrayDynamicComponent = {
  type props('var) = {
    ref: ReactDOM.domRef,
    children: React.element,
    [@optional]
    about: string,
    [@optional]
    accentHeight: string,
    [@optional]
    accept: string,
    [@optional]
    acceptCharset: string,
    [@optional]
    accessKey: string,
    [@optional]
    accumulate: string,
    [@optional]
    action: string,
    [@optional]
    additive: string,
    [@optional]
    alignmentBaseline: string,
    [@optional]
    allowFullScreen: bool,
    [@optional]
    allowReorder: string,
    [@optional]
    alphabetic: string,
    [@optional]
    alt: string,
    [@optional]
    amplitude: string,
    [@optional]
    arabicForm: string,
    [@optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@optional]
    ascent: string,
    [@optional]
    async: bool,
    [@optional]
    attributeName: string,
    [@optional]
    attributeType: string,
    [@optional]
    autoComplete: string,
    [@optional]
    autoFocus: bool,
    [@optional]
    autoPlay: bool,
    [@optional]
    autoReverse: string,
    [@optional]
    azimuth: string,
    [@optional]
    baseFrequency: string,
    [@optional]
    baselineShift: string,
    [@optional]
    baseProfile: string,
    [@optional]
    bbox: string,
    [@optional]
    begin_: string,
    [@optional]
    bias: string,
    [@optional]
    by: string,
    [@optional]
    calcMode: string,
    [@optional]
    capHeight: string,
    [@optional]
    challenge: string,
    [@optional]
    charSet: string,
    [@optional]
    checked: bool,
    [@optional]
    cite: string,
    [@optional]
    className: string,
    [@optional]
    clip: string,
    [@optional]
    clipPath: string,
    [@optional]
    clipPathUnits: string,
    [@optional]
    clipRule: string,
    [@optional]
    colorInterpolation: string,
    [@optional]
    colorInterpolationFilters: string,
    [@optional]
    colorProfile: string,
    [@optional]
    colorRendering: string,
    [@optional]
    cols: int,
    [@optional]
    colSpan: int,
    [@optional]
    content: string,
    [@optional]
    contentEditable: bool,
    [@optional]
    contentScriptType: string,
    [@optional]
    contentStyleType: string,
    [@optional]
    contextMenu: string,
    [@optional]
    controls: bool,
    [@optional]
    coords: string,
    [@optional]
    crossorigin: bool,
    [@optional]
    cursor: string,
    [@optional]
    cx: string,
    [@optional]
    cy: string,
    [@optional]
    d: string,
    [@optional]
    data: string,
    [@optional]
    datatype: string,
    [@optional]
    dateTime: string,
    [@optional]
    decelerate: string,
    [@optional]
    default: bool,
    [@optional]
    defaultChecked: bool,
    [@optional]
    defaultValue: string,
    [@optional]
    defer: bool,
    [@optional]
    descent: string,
    [@optional]
    diffuseConstant: string,
    [@optional]
    dir: string,
    [@optional]
    direction: string,
    [@optional]
    disabled: bool,
    [@optional]
    display: string,
    [@optional]
    divisor: string,
    [@optional]
    dominantBaseline: string,
    [@optional]
    download: string,
    [@optional]
    draggable: bool,
    [@optional]
    dur: string,
    [@optional]
    dx: string,
    [@optional]
    dy: string,
    [@optional]
    edgeMode: string,
    [@optional]
    elevation: string,
    [@optional]
    enableBackground: string,
    [@optional]
    encType: string,
    [@optional]
    end_: string,
    [@optional]
    exponent: string,
    [@optional]
    externalResourcesRequired: string,
    [@optional]
    fill: string,
    [@optional]
    fillOpacity: string,
    [@optional]
    fillRule: string,
    [@optional]
    filter: string,
    [@optional]
    filterRes: string,
    [@optional]
    filterUnits: string,
    [@optional]
    floodColor: string,
    [@optional]
    floodOpacity: string,
    [@optional]
    focusable: string,
    [@optional]
    fomat: string,
    [@optional]
    fontFamily: string,
    [@optional]
    fontSize: string,
    [@optional]
    fontSizeAdjust: string,
    [@optional]
    fontStretch: string,
    [@optional]
    fontStyle: string,
    [@optional]
    fontVariant: string,
    [@optional]
    fontWeight: string,
    [@optional]
    form: string,
    [@optional]
    formAction: string,
    [@optional]
    formMethod: string,
    [@optional]
    formTarget: string,
    [@optional]
    from: string,
    [@optional]
    fx: string,
    [@optional]
    fy: string,
    [@optional]
    g1: string,
    [@optional]
    g2: string,
    [@optional]
    glyphName: string,
    [@optional]
    glyphOrientationHorizontal: string,
    [@optional]
    glyphOrientationVertical: string,
    [@optional]
    glyphRef: string,
    [@optional]
    gradientTransform: string,
    [@optional]
    gradientUnits: string,
    [@optional]
    hanging: string,
    [@optional]
    headers: string,
    [@optional]
    height: string,
    [@optional]
    hidden: bool,
    [@optional]
    high: int,
    [@optional]
    horizAdvX: string,
    [@optional]
    horizOriginX: string,
    [@optional]
    href: string,
    [@optional]
    hrefLang: string,
    [@optional]
    htmlFor: string,
    [@optional]
    httpEquiv: string,
    [@optional]
    icon: string,
    [@optional]
    id: string,
    [@optional]
    ideographic: string,
    [@optional]
    imageRendering: string,
    [@optional]
    in_: string,
    [@optional]
    in2: string,
    [@optional]
    inlist: string,
    [@optional]
    inputMode: string,
    [@optional]
    integrity: string,
    [@optional]
    intercept: string,
    [@optional]
    itemID: string,
    [@optional]
    itemProp: string,
    [@optional]
    itemRef: string,
    [@optional]
    itemScope: bool,
    [@optional]
    itemType: string,
    [@optional]
    k: string,
    [@optional]
    k1: string,
    [@optional]
    k2: string,
    [@optional]
    k3: string,
    [@optional]
    k4: string,
    [@optional]
    kernelMatrix: string,
    [@optional]
    kernelUnitLength: string,
    [@optional]
    kerning: string,
    [@optional]
    key: string,
    [@optional]
    keyPoints: string,
    [@optional]
    keySplines: string,
    [@optional]
    keyTimes: string,
    [@optional]
    keyType: string,
    [@optional]
    kind: string,
    [@optional]
    label: string,
    [@optional]
    lang: string,
    [@optional]
    lengthAdjust: string,
    [@optional]
    letterSpacing: string,
    [@optional]
    lightingColor: string,
    [@optional]
    limitingConeAngle: string,
    [@optional]
    list: string,
    [@optional]
    local: string,
    [@optional]
    loop: bool,
    [@optional]
    low: int,
    [@optional]
    manifest: string,
    [@optional]
    markerEnd: string,
    [@optional]
    markerHeight: string,
    [@optional]
    markerMid: string,
    [@optional]
    markerStart: string,
    [@optional]
    markerUnits: string,
    [@optional]
    markerWidth: string,
    [@optional]
    mask: string,
    [@optional]
    maskContentUnits: string,
    [@optional]
    maskUnits: string,
    [@optional]
    mathematical: string,
    [@optional]
    max: string,
    [@optional]
    maxLength: int,
    [@optional]
    media: string,
    [@optional]
    mediaGroup: string,
    [@optional]
    min: int,
    [@optional]
    minLength: int,
    [@optional]
    mode: string,
    [@optional]
    multiple: bool,
    [@optional]
    muted: bool,
    [@optional]
    name: string,
    [@optional]
    nonce: string,
    [@optional]
    noValidate: bool,
    [@optional]
    numOctaves: string,
    [@optional]
    offset: string,
    [@optional]
    opacity: string,
    [@optional]
    open_: bool,
    [@optional]
    operator: string,
    [@optional]
    optimum: int,
    [@optional]
    order: string,
    [@optional]
    orient: string,
    [@optional]
    orientation: string,
    [@optional]
    origin: string,
    [@optional]
    overflow: string,
    [@optional]
    overflowX: string,
    [@optional]
    overflowY: string,
    [@optional]
    overlinePosition: string,
    [@optional]
    overlineThickness: string,
    [@optional]
    paintOrder: string,
    [@optional]
    panose1: string,
    [@optional]
    pathLength: string,
    [@optional]
    pattern: string,
    [@optional]
    patternContentUnits: string,
    [@optional]
    patternTransform: string,
    [@optional]
    patternUnits: string,
    [@optional]
    placeholder: string,
    [@optional]
    pointerEvents: string,
    [@optional]
    points: string,
    [@optional]
    pointsAtX: string,
    [@optional]
    pointsAtY: string,
    [@optional]
    pointsAtZ: string,
    [@optional]
    poster: string,
    [@optional]
    prefix: string,
    [@optional]
    preload: string,
    [@optional]
    preserveAlpha: string,
    [@optional]
    preserveAspectRatio: string,
    [@optional]
    primitiveUnits: string,
    [@optional]
    property: string,
    [@optional]
    r: string,
    [@optional]
    radioGroup: string,
    [@optional]
    radius: string,
    [@optional]
    readOnly: bool,
    [@optional]
    refX: string,
    [@optional]
    refY: string,
    [@optional]
    rel: string,
    [@optional]
    renderingIntent: string,
    [@optional]
    repeatCount: string,
    [@optional]
    repeatDur: string,
    [@optional]
    required: bool,
    [@optional]
    requiredExtensions: string,
    [@optional]
    requiredFeatures: string,
    [@optional]
    resource: string,
    [@optional]
    restart: string,
    [@optional]
    result: string,
    [@optional]
    reversed: bool,
    [@optional]
    role: string,
    [@optional]
    rotate: string,
    [@optional]
    rows: int,
    [@optional]
    rowSpan: int,
    [@optional]
    rx: string,
    [@optional]
    ry: string,
    [@optional]
    sandbox: string,
    [@optional]
    scale: string,
    [@optional]
    scope: string,
    [@optional]
    scoped: bool,
    [@optional]
    scrolling: string,
    [@optional]
    seed: string,
    [@optional]
    selected: bool,
    [@optional]
    shape: string,
    [@optional]
    shapeRendering: string,
    [@optional]
    size: int,
    [@optional]
    sizes: string,
    [@optional]
    slope: string,
    [@optional]
    spacing: string,
    [@optional]
    span: int,
    [@optional]
    specularConstant: string,
    [@optional]
    specularExponent: string,
    [@optional]
    speed: string,
    [@optional]
    spellCheck: bool,
    [@optional]
    spreadMethod: string,
    [@optional]
    src: string,
    [@optional]
    srcDoc: string,
    [@optional]
    srcLang: string,
    [@optional]
    srcSet: string,
    [@optional]
    start: int,
    [@optional]
    startOffset: string,
    [@optional]
    stdDeviation: string,
    [@optional]
    stemh: string,
    [@optional]
    stemv: string,
    [@optional]
    step: float,
    [@optional]
    stitchTiles: string,
    [@optional]
    stopColor: string,
    [@optional]
    stopOpacity: string,
    [@optional]
    strikethroughPosition: string,
    [@optional]
    strikethroughThickness: string,
    [@optional]
    stroke: string,
    [@optional]
    strokeDasharray: string,
    [@optional]
    strokeDashoffset: string,
    [@optional]
    strokeLinecap: string,
    [@optional]
    strokeLinejoin: string,
    [@optional]
    strokeMiterlimit: string,
    [@optional]
    strokeOpacity: string,
    [@optional]
    strokeWidth: string,
    [@optional]
    style: ReactDOM.Style.t,
    [@optional]
    summary: string,
    [@optional]
    suppressContentEditableWarning: bool,
    [@optional]
    surfaceScale: string,
    [@optional]
    systemLanguage: string,
    [@optional]
    tabIndex: int,
    [@optional]
    tableValues: string,
    [@optional]
    target: string,
    [@optional]
    targetX: string,
    [@optional]
    targetY: string,
    [@optional]
    textAnchor: string,
    [@optional]
    textDecoration: string,
    [@optional]
    textLength: string,
    [@optional]
    textRendering: string,
    [@optional]
    title: string,
    [@optional]
    to_: string,
    [@optional]
    transform: string,
    [@optional] [@bs.as "type"]
    type_: string,
    [@optional]
    typeof: string,
    [@optional]
    u1: string,
    [@optional]
    u2: string,
    [@optional]
    underlinePosition: string,
    [@optional]
    underlineThickness: string,
    [@optional]
    unicode: string,
    [@optional]
    unicodeBidi: string,
    [@optional]
    unicodeRange: string,
    [@optional]
    unitsPerEm: string,
    [@optional]
    useMap: string,
    [@optional]
    vAlphabetic: string,
    [@optional]
    value: string,
    [@optional]
    values: string,
    [@optional]
    vectorEffect: string,
    [@optional]
    version: string,
    [@optional]
    vertAdvX: string,
    [@optional]
    vertAdvY: string,
    [@optional]
    vertOriginX: string,
    [@optional]
    vertOriginY: string,
    [@optional]
    vHanging: string,
    [@optional]
    vIdeographic: string,
    [@optional]
    viewBox: string,
    [@optional]
    viewTarget: string,
    [@optional]
    visibility: string,
    [@optional]
    vMathematical: string,
    [@optional]
    vocab: string,
    [@optional]
    width: string,
    [@optional]
    widths: string,
    [@optional]
    wordSpacing: string,
    [@optional]
    wrap: string,
    [@optional]
    writingMode: string,
    [@optional]
    x: string,
    [@optional]
    x1: string,
    [@optional]
    x2: string,
    [@optional]
    xChannelSelector: string,
    [@optional]
    xHeight: string,
    [@optional]
    xlinkActuate: string,
    [@optional]
    xlinkArcrole: string,
    [@optional]
    xlinkHref: string,
    [@optional]
    xlinkRole: string,
    [@optional]
    xlinkShow: string,
    [@optional]
    xlinkTitle: string,
    [@optional]
    xlinkType: string,
    [@optional]
    xmlBase: string,
    [@optional]
    xmlLang: string,
    [@optional]
    xmlns: string,
    [@optional]
    xmlnsXlink: string,
    [@optional]
    xmlSpace: string,
    [@optional]
    y: string,
    [@optional]
    y1: string,
    [@optional]
    y2: string,
    [@optional]
    yChannelSelector: string,
    [@optional]
    z: string,
    [@optional]
    zoomAndPan: string,
    [@optional]
    onAbort: ReactEvent.Media.t => unit,
    [@optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@optional]
    onChange: ReactEvent.Form.t => unit,
    [@optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@optional]
    onEnded: ReactEvent.Media.t => unit,
    [@optional]
    onError: ReactEvent.Media.t => unit,
    [@optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@optional]
    onInput: ReactEvent.Form.t => unit,
    [@optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@optional]
    onPause: ReactEvent.Media.t => unit,
    [@optional]
    onPlay: ReactEvent.Media.t => unit,
    [@optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@optional]
    onProgress: ReactEvent.Media.t => unit,
    [@optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@optional]
    onScroll: ReactEvent.UI.t => unit,
    [@optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@optional]
    onStalled: ReactEvent.Media.t => unit,
    [@optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@optional]
    onWheel: ReactEvent.Wheel.t => unit,
    var: 'var,
  };
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles = (~var, _) =>
    CssJs.style(. [|
      CssJs.label("ArrayDynamicComponent"),
      CssJs.display(`block),
      switch (var) {
      | `Black => CssJs.color(`hex({js|999999|js}))
      | `White => CssJs.color(`hex({js|FAFAFA|js}))
      },
    |]);
  let make = (props: props('var)) => {
    let className =
      styles(~var=props.var, ()) ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "var"));
    createVariadicElement("div", newProps);
  };
};
module SequenceDynamicComponent = {
  type props('size) = {
    ref: ReactDOM.domRef,
    children: React.element,
    [@optional]
    about: string,
    [@optional]
    accentHeight: string,
    [@optional]
    accept: string,
    [@optional]
    acceptCharset: string,
    [@optional]
    accessKey: string,
    [@optional]
    accumulate: string,
    [@optional]
    action: string,
    [@optional]
    additive: string,
    [@optional]
    alignmentBaseline: string,
    [@optional]
    allowFullScreen: bool,
    [@optional]
    allowReorder: string,
    [@optional]
    alphabetic: string,
    [@optional]
    alt: string,
    [@optional]
    amplitude: string,
    [@optional]
    arabicForm: string,
    [@optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@optional]
    ascent: string,
    [@optional]
    async: bool,
    [@optional]
    attributeName: string,
    [@optional]
    attributeType: string,
    [@optional]
    autoComplete: string,
    [@optional]
    autoFocus: bool,
    [@optional]
    autoPlay: bool,
    [@optional]
    autoReverse: string,
    [@optional]
    azimuth: string,
    [@optional]
    baseFrequency: string,
    [@optional]
    baselineShift: string,
    [@optional]
    baseProfile: string,
    [@optional]
    bbox: string,
    [@optional]
    begin_: string,
    [@optional]
    bias: string,
    [@optional]
    by: string,
    [@optional]
    calcMode: string,
    [@optional]
    capHeight: string,
    [@optional]
    challenge: string,
    [@optional]
    charSet: string,
    [@optional]
    checked: bool,
    [@optional]
    cite: string,
    [@optional]
    className: string,
    [@optional]
    clip: string,
    [@optional]
    clipPath: string,
    [@optional]
    clipPathUnits: string,
    [@optional]
    clipRule: string,
    [@optional]
    colorInterpolation: string,
    [@optional]
    colorInterpolationFilters: string,
    [@optional]
    colorProfile: string,
    [@optional]
    colorRendering: string,
    [@optional]
    cols: int,
    [@optional]
    colSpan: int,
    [@optional]
    content: string,
    [@optional]
    contentEditable: bool,
    [@optional]
    contentScriptType: string,
    [@optional]
    contentStyleType: string,
    [@optional]
    contextMenu: string,
    [@optional]
    controls: bool,
    [@optional]
    coords: string,
    [@optional]
    crossorigin: bool,
    [@optional]
    cursor: string,
    [@optional]
    cx: string,
    [@optional]
    cy: string,
    [@optional]
    d: string,
    [@optional]
    data: string,
    [@optional]
    datatype: string,
    [@optional]
    dateTime: string,
    [@optional]
    decelerate: string,
    [@optional]
    default: bool,
    [@optional]
    defaultChecked: bool,
    [@optional]
    defaultValue: string,
    [@optional]
    defer: bool,
    [@optional]
    descent: string,
    [@optional]
    diffuseConstant: string,
    [@optional]
    dir: string,
    [@optional]
    direction: string,
    [@optional]
    disabled: bool,
    [@optional]
    display: string,
    [@optional]
    divisor: string,
    [@optional]
    dominantBaseline: string,
    [@optional]
    download: string,
    [@optional]
    draggable: bool,
    [@optional]
    dur: string,
    [@optional]
    dx: string,
    [@optional]
    dy: string,
    [@optional]
    edgeMode: string,
    [@optional]
    elevation: string,
    [@optional]
    enableBackground: string,
    [@optional]
    encType: string,
    [@optional]
    end_: string,
    [@optional]
    exponent: string,
    [@optional]
    externalResourcesRequired: string,
    [@optional]
    fill: string,
    [@optional]
    fillOpacity: string,
    [@optional]
    fillRule: string,
    [@optional]
    filter: string,
    [@optional]
    filterRes: string,
    [@optional]
    filterUnits: string,
    [@optional]
    floodColor: string,
    [@optional]
    floodOpacity: string,
    [@optional]
    focusable: string,
    [@optional]
    fomat: string,
    [@optional]
    fontFamily: string,
    [@optional]
    fontSize: string,
    [@optional]
    fontSizeAdjust: string,
    [@optional]
    fontStretch: string,
    [@optional]
    fontStyle: string,
    [@optional]
    fontVariant: string,
    [@optional]
    fontWeight: string,
    [@optional]
    form: string,
    [@optional]
    formAction: string,
    [@optional]
    formMethod: string,
    [@optional]
    formTarget: string,
    [@optional]
    from: string,
    [@optional]
    fx: string,
    [@optional]
    fy: string,
    [@optional]
    g1: string,
    [@optional]
    g2: string,
    [@optional]
    glyphName: string,
    [@optional]
    glyphOrientationHorizontal: string,
    [@optional]
    glyphOrientationVertical: string,
    [@optional]
    glyphRef: string,
    [@optional]
    gradientTransform: string,
    [@optional]
    gradientUnits: string,
    [@optional]
    hanging: string,
    [@optional]
    headers: string,
    [@optional]
    height: string,
    [@optional]
    hidden: bool,
    [@optional]
    high: int,
    [@optional]
    horizAdvX: string,
    [@optional]
    horizOriginX: string,
    [@optional]
    href: string,
    [@optional]
    hrefLang: string,
    [@optional]
    htmlFor: string,
    [@optional]
    httpEquiv: string,
    [@optional]
    icon: string,
    [@optional]
    id: string,
    [@optional]
    ideographic: string,
    [@optional]
    imageRendering: string,
    [@optional]
    in_: string,
    [@optional]
    in2: string,
    [@optional]
    inlist: string,
    [@optional]
    inputMode: string,
    [@optional]
    integrity: string,
    [@optional]
    intercept: string,
    [@optional]
    itemID: string,
    [@optional]
    itemProp: string,
    [@optional]
    itemRef: string,
    [@optional]
    itemScope: bool,
    [@optional]
    itemType: string,
    [@optional]
    k: string,
    [@optional]
    k1: string,
    [@optional]
    k2: string,
    [@optional]
    k3: string,
    [@optional]
    k4: string,
    [@optional]
    kernelMatrix: string,
    [@optional]
    kernelUnitLength: string,
    [@optional]
    kerning: string,
    [@optional]
    key: string,
    [@optional]
    keyPoints: string,
    [@optional]
    keySplines: string,
    [@optional]
    keyTimes: string,
    [@optional]
    keyType: string,
    [@optional]
    kind: string,
    [@optional]
    label: string,
    [@optional]
    lang: string,
    [@optional]
    lengthAdjust: string,
    [@optional]
    letterSpacing: string,
    [@optional]
    lightingColor: string,
    [@optional]
    limitingConeAngle: string,
    [@optional]
    list: string,
    [@optional]
    local: string,
    [@optional]
    loop: bool,
    [@optional]
    low: int,
    [@optional]
    manifest: string,
    [@optional]
    markerEnd: string,
    [@optional]
    markerHeight: string,
    [@optional]
    markerMid: string,
    [@optional]
    markerStart: string,
    [@optional]
    markerUnits: string,
    [@optional]
    markerWidth: string,
    [@optional]
    mask: string,
    [@optional]
    maskContentUnits: string,
    [@optional]
    maskUnits: string,
    [@optional]
    mathematical: string,
    [@optional]
    max: string,
    [@optional]
    maxLength: int,
    [@optional]
    media: string,
    [@optional]
    mediaGroup: string,
    [@optional]
    min: int,
    [@optional]
    minLength: int,
    [@optional]
    mode: string,
    [@optional]
    multiple: bool,
    [@optional]
    muted: bool,
    [@optional]
    name: string,
    [@optional]
    nonce: string,
    [@optional]
    noValidate: bool,
    [@optional]
    numOctaves: string,
    [@optional]
    offset: string,
    [@optional]
    opacity: string,
    [@optional]
    open_: bool,
    [@optional]
    operator: string,
    [@optional]
    optimum: int,
    [@optional]
    order: string,
    [@optional]
    orient: string,
    [@optional]
    orientation: string,
    [@optional]
    origin: string,
    [@optional]
    overflow: string,
    [@optional]
    overflowX: string,
    [@optional]
    overflowY: string,
    [@optional]
    overlinePosition: string,
    [@optional]
    overlineThickness: string,
    [@optional]
    paintOrder: string,
    [@optional]
    panose1: string,
    [@optional]
    pathLength: string,
    [@optional]
    pattern: string,
    [@optional]
    patternContentUnits: string,
    [@optional]
    patternTransform: string,
    [@optional]
    patternUnits: string,
    [@optional]
    placeholder: string,
    [@optional]
    pointerEvents: string,
    [@optional]
    points: string,
    [@optional]
    pointsAtX: string,
    [@optional]
    pointsAtY: string,
    [@optional]
    pointsAtZ: string,
    [@optional]
    poster: string,
    [@optional]
    prefix: string,
    [@optional]
    preload: string,
    [@optional]
    preserveAlpha: string,
    [@optional]
    preserveAspectRatio: string,
    [@optional]
    primitiveUnits: string,
    [@optional]
    property: string,
    [@optional]
    r: string,
    [@optional]
    radioGroup: string,
    [@optional]
    radius: string,
    [@optional]
    readOnly: bool,
    [@optional]
    refX: string,
    [@optional]
    refY: string,
    [@optional]
    rel: string,
    [@optional]
    renderingIntent: string,
    [@optional]
    repeatCount: string,
    [@optional]
    repeatDur: string,
    [@optional]
    required: bool,
    [@optional]
    requiredExtensions: string,
    [@optional]
    requiredFeatures: string,
    [@optional]
    resource: string,
    [@optional]
    restart: string,
    [@optional]
    result: string,
    [@optional]
    reversed: bool,
    [@optional]
    role: string,
    [@optional]
    rotate: string,
    [@optional]
    rows: int,
    [@optional]
    rowSpan: int,
    [@optional]
    rx: string,
    [@optional]
    ry: string,
    [@optional]
    sandbox: string,
    [@optional]
    scale: string,
    [@optional]
    scope: string,
    [@optional]
    scoped: bool,
    [@optional]
    scrolling: string,
    [@optional]
    seed: string,
    [@optional]
    selected: bool,
    [@optional]
    shape: string,
    [@optional]
    shapeRendering: string,
    [@optional]
    sizes: string,
    [@optional]
    slope: string,
    [@optional]
    spacing: string,
    [@optional]
    span: int,
    [@optional]
    specularConstant: string,
    [@optional]
    specularExponent: string,
    [@optional]
    speed: string,
    [@optional]
    spellCheck: bool,
    [@optional]
    spreadMethod: string,
    [@optional]
    src: string,
    [@optional]
    srcDoc: string,
    [@optional]
    srcLang: string,
    [@optional]
    srcSet: string,
    [@optional]
    start: int,
    [@optional]
    startOffset: string,
    [@optional]
    stdDeviation: string,
    [@optional]
    stemh: string,
    [@optional]
    stemv: string,
    [@optional]
    step: float,
    [@optional]
    stitchTiles: string,
    [@optional]
    stopColor: string,
    [@optional]
    stopOpacity: string,
    [@optional]
    strikethroughPosition: string,
    [@optional]
    strikethroughThickness: string,
    [@optional]
    stroke: string,
    [@optional]
    strokeDasharray: string,
    [@optional]
    strokeDashoffset: string,
    [@optional]
    strokeLinecap: string,
    [@optional]
    strokeLinejoin: string,
    [@optional]
    strokeMiterlimit: string,
    [@optional]
    strokeOpacity: string,
    [@optional]
    strokeWidth: string,
    [@optional]
    style: ReactDOM.Style.t,
    [@optional]
    summary: string,
    [@optional]
    suppressContentEditableWarning: bool,
    [@optional]
    surfaceScale: string,
    [@optional]
    systemLanguage: string,
    [@optional]
    tabIndex: int,
    [@optional]
    tableValues: string,
    [@optional]
    target: string,
    [@optional]
    targetX: string,
    [@optional]
    targetY: string,
    [@optional]
    textAnchor: string,
    [@optional]
    textDecoration: string,
    [@optional]
    textLength: string,
    [@optional]
    textRendering: string,
    [@optional]
    title: string,
    [@optional]
    to_: string,
    [@optional]
    transform: string,
    [@optional] [@bs.as "type"]
    type_: string,
    [@optional]
    typeof: string,
    [@optional]
    u1: string,
    [@optional]
    u2: string,
    [@optional]
    underlinePosition: string,
    [@optional]
    underlineThickness: string,
    [@optional]
    unicode: string,
    [@optional]
    unicodeBidi: string,
    [@optional]
    unicodeRange: string,
    [@optional]
    unitsPerEm: string,
    [@optional]
    useMap: string,
    [@optional]
    vAlphabetic: string,
    [@optional]
    value: string,
    [@optional]
    values: string,
    [@optional]
    vectorEffect: string,
    [@optional]
    version: string,
    [@optional]
    vertAdvX: string,
    [@optional]
    vertAdvY: string,
    [@optional]
    vertOriginX: string,
    [@optional]
    vertOriginY: string,
    [@optional]
    vHanging: string,
    [@optional]
    vIdeographic: string,
    [@optional]
    viewBox: string,
    [@optional]
    viewTarget: string,
    [@optional]
    visibility: string,
    [@optional]
    vMathematical: string,
    [@optional]
    vocab: string,
    [@optional]
    width: string,
    [@optional]
    widths: string,
    [@optional]
    wordSpacing: string,
    [@optional]
    wrap: string,
    [@optional]
    writingMode: string,
    [@optional]
    x: string,
    [@optional]
    x1: string,
    [@optional]
    x2: string,
    [@optional]
    xChannelSelector: string,
    [@optional]
    xHeight: string,
    [@optional]
    xlinkActuate: string,
    [@optional]
    xlinkArcrole: string,
    [@optional]
    xlinkHref: string,
    [@optional]
    xlinkRole: string,
    [@optional]
    xlinkShow: string,
    [@optional]
    xlinkTitle: string,
    [@optional]
    xlinkType: string,
    [@optional]
    xmlBase: string,
    [@optional]
    xmlLang: string,
    [@optional]
    xmlns: string,
    [@optional]
    xmlnsXlink: string,
    [@optional]
    xmlSpace: string,
    [@optional]
    y: string,
    [@optional]
    y1: string,
    [@optional]
    y2: string,
    [@optional]
    yChannelSelector: string,
    [@optional]
    z: string,
    [@optional]
    zoomAndPan: string,
    [@optional]
    onAbort: ReactEvent.Media.t => unit,
    [@optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@optional]
    onChange: ReactEvent.Form.t => unit,
    [@optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@optional]
    onEnded: ReactEvent.Media.t => unit,
    [@optional]
    onError: ReactEvent.Media.t => unit,
    [@optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@optional]
    onInput: ReactEvent.Form.t => unit,
    [@optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@optional]
    onPause: ReactEvent.Media.t => unit,
    [@optional]
    onPlay: ReactEvent.Media.t => unit,
    [@optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@optional]
    onProgress: ReactEvent.Media.t => unit,
    [@optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@optional]
    onScroll: ReactEvent.UI.t => unit,
    [@optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@optional]
    onStalled: ReactEvent.Media.t => unit,
    [@optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@optional]
    onWheel: ReactEvent.Wheel.t => unit,
    size: 'size,
  };
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles = (~size, _) => {
    Js.log("Logging when render");
    CssJs.style(. [|
      (CssJs.width(size): CssJs.rule),
      CssJs.display(`block),
    |]);
  };
  let make = (props: props('size)) => {
    let className =
      styles(~size=props.size, ()) ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "size"));
    createVariadicElement("div", newProps);
  };
};
module DynamicComponentWithDefaultValue = {
  type props('var) = {
    ref: ReactDOM.domRef,
    children: React.element,
    [@optional]
    about: string,
    [@optional]
    accentHeight: string,
    [@optional]
    accept: string,
    [@optional]
    acceptCharset: string,
    [@optional]
    accessKey: string,
    [@optional]
    accumulate: string,
    [@optional]
    action: string,
    [@optional]
    additive: string,
    [@optional]
    alignmentBaseline: string,
    [@optional]
    allowFullScreen: bool,
    [@optional]
    allowReorder: string,
    [@optional]
    alphabetic: string,
    [@optional]
    alt: string,
    [@optional]
    amplitude: string,
    [@optional]
    arabicForm: string,
    [@optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@optional]
    ascent: string,
    [@optional]
    async: bool,
    [@optional]
    attributeName: string,
    [@optional]
    attributeType: string,
    [@optional]
    autoComplete: string,
    [@optional]
    autoFocus: bool,
    [@optional]
    autoPlay: bool,
    [@optional]
    autoReverse: string,
    [@optional]
    azimuth: string,
    [@optional]
    baseFrequency: string,
    [@optional]
    baselineShift: string,
    [@optional]
    baseProfile: string,
    [@optional]
    bbox: string,
    [@optional]
    begin_: string,
    [@optional]
    bias: string,
    [@optional]
    by: string,
    [@optional]
    calcMode: string,
    [@optional]
    capHeight: string,
    [@optional]
    challenge: string,
    [@optional]
    charSet: string,
    [@optional]
    checked: bool,
    [@optional]
    cite: string,
    [@optional]
    className: string,
    [@optional]
    clip: string,
    [@optional]
    clipPath: string,
    [@optional]
    clipPathUnits: string,
    [@optional]
    clipRule: string,
    [@optional]
    colorInterpolation: string,
    [@optional]
    colorInterpolationFilters: string,
    [@optional]
    colorProfile: string,
    [@optional]
    colorRendering: string,
    [@optional]
    cols: int,
    [@optional]
    colSpan: int,
    [@optional]
    content: string,
    [@optional]
    contentEditable: bool,
    [@optional]
    contentScriptType: string,
    [@optional]
    contentStyleType: string,
    [@optional]
    contextMenu: string,
    [@optional]
    controls: bool,
    [@optional]
    coords: string,
    [@optional]
    crossorigin: bool,
    [@optional]
    cursor: string,
    [@optional]
    cx: string,
    [@optional]
    cy: string,
    [@optional]
    d: string,
    [@optional]
    data: string,
    [@optional]
    datatype: string,
    [@optional]
    dateTime: string,
    [@optional]
    decelerate: string,
    [@optional]
    default: bool,
    [@optional]
    defaultChecked: bool,
    [@optional]
    defaultValue: string,
    [@optional]
    defer: bool,
    [@optional]
    descent: string,
    [@optional]
    diffuseConstant: string,
    [@optional]
    dir: string,
    [@optional]
    direction: string,
    [@optional]
    disabled: bool,
    [@optional]
    display: string,
    [@optional]
    divisor: string,
    [@optional]
    dominantBaseline: string,
    [@optional]
    download: string,
    [@optional]
    draggable: bool,
    [@optional]
    dur: string,
    [@optional]
    dx: string,
    [@optional]
    dy: string,
    [@optional]
    edgeMode: string,
    [@optional]
    elevation: string,
    [@optional]
    enableBackground: string,
    [@optional]
    encType: string,
    [@optional]
    end_: string,
    [@optional]
    exponent: string,
    [@optional]
    externalResourcesRequired: string,
    [@optional]
    fill: string,
    [@optional]
    fillOpacity: string,
    [@optional]
    fillRule: string,
    [@optional]
    filter: string,
    [@optional]
    filterRes: string,
    [@optional]
    filterUnits: string,
    [@optional]
    floodColor: string,
    [@optional]
    floodOpacity: string,
    [@optional]
    focusable: string,
    [@optional]
    fomat: string,
    [@optional]
    fontFamily: string,
    [@optional]
    fontSize: string,
    [@optional]
    fontSizeAdjust: string,
    [@optional]
    fontStretch: string,
    [@optional]
    fontStyle: string,
    [@optional]
    fontVariant: string,
    [@optional]
    fontWeight: string,
    [@optional]
    form: string,
    [@optional]
    formAction: string,
    [@optional]
    formMethod: string,
    [@optional]
    formTarget: string,
    [@optional]
    from: string,
    [@optional]
    fx: string,
    [@optional]
    fy: string,
    [@optional]
    g1: string,
    [@optional]
    g2: string,
    [@optional]
    glyphName: string,
    [@optional]
    glyphOrientationHorizontal: string,
    [@optional]
    glyphOrientationVertical: string,
    [@optional]
    glyphRef: string,
    [@optional]
    gradientTransform: string,
    [@optional]
    gradientUnits: string,
    [@optional]
    hanging: string,
    [@optional]
    headers: string,
    [@optional]
    height: string,
    [@optional]
    hidden: bool,
    [@optional]
    high: int,
    [@optional]
    horizAdvX: string,
    [@optional]
    horizOriginX: string,
    [@optional]
    href: string,
    [@optional]
    hrefLang: string,
    [@optional]
    htmlFor: string,
    [@optional]
    httpEquiv: string,
    [@optional]
    icon: string,
    [@optional]
    id: string,
    [@optional]
    ideographic: string,
    [@optional]
    imageRendering: string,
    [@optional]
    in_: string,
    [@optional]
    in2: string,
    [@optional]
    inlist: string,
    [@optional]
    inputMode: string,
    [@optional]
    integrity: string,
    [@optional]
    intercept: string,
    [@optional]
    itemID: string,
    [@optional]
    itemProp: string,
    [@optional]
    itemRef: string,
    [@optional]
    itemScope: bool,
    [@optional]
    itemType: string,
    [@optional]
    k: string,
    [@optional]
    k1: string,
    [@optional]
    k2: string,
    [@optional]
    k3: string,
    [@optional]
    k4: string,
    [@optional]
    kernelMatrix: string,
    [@optional]
    kernelUnitLength: string,
    [@optional]
    kerning: string,
    [@optional]
    key: string,
    [@optional]
    keyPoints: string,
    [@optional]
    keySplines: string,
    [@optional]
    keyTimes: string,
    [@optional]
    keyType: string,
    [@optional]
    kind: string,
    [@optional]
    label: string,
    [@optional]
    lang: string,
    [@optional]
    lengthAdjust: string,
    [@optional]
    letterSpacing: string,
    [@optional]
    lightingColor: string,
    [@optional]
    limitingConeAngle: string,
    [@optional]
    list: string,
    [@optional]
    local: string,
    [@optional]
    loop: bool,
    [@optional]
    low: int,
    [@optional]
    manifest: string,
    [@optional]
    markerEnd: string,
    [@optional]
    markerHeight: string,
    [@optional]
    markerMid: string,
    [@optional]
    markerStart: string,
    [@optional]
    markerUnits: string,
    [@optional]
    markerWidth: string,
    [@optional]
    mask: string,
    [@optional]
    maskContentUnits: string,
    [@optional]
    maskUnits: string,
    [@optional]
    mathematical: string,
    [@optional]
    max: string,
    [@optional]
    maxLength: int,
    [@optional]
    media: string,
    [@optional]
    mediaGroup: string,
    [@optional]
    min: int,
    [@optional]
    minLength: int,
    [@optional]
    mode: string,
    [@optional]
    multiple: bool,
    [@optional]
    muted: bool,
    [@optional]
    name: string,
    [@optional]
    nonce: string,
    [@optional]
    noValidate: bool,
    [@optional]
    numOctaves: string,
    [@optional]
    offset: string,
    [@optional]
    opacity: string,
    [@optional]
    open_: bool,
    [@optional]
    operator: string,
    [@optional]
    optimum: int,
    [@optional]
    order: string,
    [@optional]
    orient: string,
    [@optional]
    orientation: string,
    [@optional]
    origin: string,
    [@optional]
    overflow: string,
    [@optional]
    overflowX: string,
    [@optional]
    overflowY: string,
    [@optional]
    overlinePosition: string,
    [@optional]
    overlineThickness: string,
    [@optional]
    paintOrder: string,
    [@optional]
    panose1: string,
    [@optional]
    pathLength: string,
    [@optional]
    pattern: string,
    [@optional]
    patternContentUnits: string,
    [@optional]
    patternTransform: string,
    [@optional]
    patternUnits: string,
    [@optional]
    placeholder: string,
    [@optional]
    pointerEvents: string,
    [@optional]
    points: string,
    [@optional]
    pointsAtX: string,
    [@optional]
    pointsAtY: string,
    [@optional]
    pointsAtZ: string,
    [@optional]
    poster: string,
    [@optional]
    prefix: string,
    [@optional]
    preload: string,
    [@optional]
    preserveAlpha: string,
    [@optional]
    preserveAspectRatio: string,
    [@optional]
    primitiveUnits: string,
    [@optional]
    property: string,
    [@optional]
    r: string,
    [@optional]
    radioGroup: string,
    [@optional]
    radius: string,
    [@optional]
    readOnly: bool,
    [@optional]
    refX: string,
    [@optional]
    refY: string,
    [@optional]
    rel: string,
    [@optional]
    renderingIntent: string,
    [@optional]
    repeatCount: string,
    [@optional]
    repeatDur: string,
    [@optional]
    required: bool,
    [@optional]
    requiredExtensions: string,
    [@optional]
    requiredFeatures: string,
    [@optional]
    resource: string,
    [@optional]
    restart: string,
    [@optional]
    result: string,
    [@optional]
    reversed: bool,
    [@optional]
    role: string,
    [@optional]
    rotate: string,
    [@optional]
    rows: int,
    [@optional]
    rowSpan: int,
    [@optional]
    rx: string,
    [@optional]
    ry: string,
    [@optional]
    sandbox: string,
    [@optional]
    scale: string,
    [@optional]
    scope: string,
    [@optional]
    scoped: bool,
    [@optional]
    scrolling: string,
    [@optional]
    seed: string,
    [@optional]
    selected: bool,
    [@optional]
    shape: string,
    [@optional]
    shapeRendering: string,
    [@optional]
    size: int,
    [@optional]
    sizes: string,
    [@optional]
    slope: string,
    [@optional]
    spacing: string,
    [@optional]
    span: int,
    [@optional]
    specularConstant: string,
    [@optional]
    specularExponent: string,
    [@optional]
    speed: string,
    [@optional]
    spellCheck: bool,
    [@optional]
    spreadMethod: string,
    [@optional]
    src: string,
    [@optional]
    srcDoc: string,
    [@optional]
    srcLang: string,
    [@optional]
    srcSet: string,
    [@optional]
    start: int,
    [@optional]
    startOffset: string,
    [@optional]
    stdDeviation: string,
    [@optional]
    stemh: string,
    [@optional]
    stemv: string,
    [@optional]
    step: float,
    [@optional]
    stitchTiles: string,
    [@optional]
    stopColor: string,
    [@optional]
    stopOpacity: string,
    [@optional]
    strikethroughPosition: string,
    [@optional]
    strikethroughThickness: string,
    [@optional]
    stroke: string,
    [@optional]
    strokeDasharray: string,
    [@optional]
    strokeDashoffset: string,
    [@optional]
    strokeLinecap: string,
    [@optional]
    strokeLinejoin: string,
    [@optional]
    strokeMiterlimit: string,
    [@optional]
    strokeOpacity: string,
    [@optional]
    strokeWidth: string,
    [@optional]
    style: ReactDOM.Style.t,
    [@optional]
    summary: string,
    [@optional]
    suppressContentEditableWarning: bool,
    [@optional]
    surfaceScale: string,
    [@optional]
    systemLanguage: string,
    [@optional]
    tabIndex: int,
    [@optional]
    tableValues: string,
    [@optional]
    target: string,
    [@optional]
    targetX: string,
    [@optional]
    targetY: string,
    [@optional]
    textAnchor: string,
    [@optional]
    textDecoration: string,
    [@optional]
    textLength: string,
    [@optional]
    textRendering: string,
    [@optional]
    title: string,
    [@optional]
    to_: string,
    [@optional]
    transform: string,
    [@optional] [@bs.as "type"]
    type_: string,
    [@optional]
    typeof: string,
    [@optional]
    u1: string,
    [@optional]
    u2: string,
    [@optional]
    underlinePosition: string,
    [@optional]
    underlineThickness: string,
    [@optional]
    unicode: string,
    [@optional]
    unicodeBidi: string,
    [@optional]
    unicodeRange: string,
    [@optional]
    unitsPerEm: string,
    [@optional]
    useMap: string,
    [@optional]
    vAlphabetic: string,
    [@optional]
    value: string,
    [@optional]
    values: string,
    [@optional]
    vectorEffect: string,
    [@optional]
    version: string,
    [@optional]
    vertAdvX: string,
    [@optional]
    vertAdvY: string,
    [@optional]
    vertOriginX: string,
    [@optional]
    vertOriginY: string,
    [@optional]
    vHanging: string,
    [@optional]
    vIdeographic: string,
    [@optional]
    viewBox: string,
    [@optional]
    viewTarget: string,
    [@optional]
    visibility: string,
    [@optional]
    vMathematical: string,
    [@optional]
    vocab: string,
    [@optional]
    width: string,
    [@optional]
    widths: string,
    [@optional]
    wordSpacing: string,
    [@optional]
    wrap: string,
    [@optional]
    writingMode: string,
    [@optional]
    x: string,
    [@optional]
    x1: string,
    [@optional]
    x2: string,
    [@optional]
    xChannelSelector: string,
    [@optional]
    xHeight: string,
    [@optional]
    xlinkActuate: string,
    [@optional]
    xlinkArcrole: string,
    [@optional]
    xlinkHref: string,
    [@optional]
    xlinkRole: string,
    [@optional]
    xlinkShow: string,
    [@optional]
    xlinkTitle: string,
    [@optional]
    xlinkType: string,
    [@optional]
    xmlBase: string,
    [@optional]
    xmlLang: string,
    [@optional]
    xmlns: string,
    [@optional]
    xmlnsXlink: string,
    [@optional]
    xmlSpace: string,
    [@optional]
    y: string,
    [@optional]
    y1: string,
    [@optional]
    y2: string,
    [@optional]
    yChannelSelector: string,
    [@optional]
    z: string,
    [@optional]
    zoomAndPan: string,
    [@optional]
    onAbort: ReactEvent.Media.t => unit,
    [@optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@optional]
    onChange: ReactEvent.Form.t => unit,
    [@optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@optional]
    onEnded: ReactEvent.Media.t => unit,
    [@optional]
    onError: ReactEvent.Media.t => unit,
    [@optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@optional]
    onInput: ReactEvent.Form.t => unit,
    [@optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@optional]
    onPause: ReactEvent.Media.t => unit,
    [@optional]
    onPlay: ReactEvent.Media.t => unit,
    [@optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@optional]
    onProgress: ReactEvent.Media.t => unit,
    [@optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@optional]
    onScroll: ReactEvent.UI.t => unit,
    [@optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@optional]
    onStalled: ReactEvent.Media.t => unit,
    [@optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@optional]
    onWheel: ReactEvent.Wheel.t => unit,
    var: 'var,
  };
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles = (~var=CssJs.hex("333"), _) =>
    CssJs.style(. [|
      CssJs.label("DynamicComponentWithDefaultValue"),
      CssJs.display(`block),
      (CssJs.color(var): CssJs.rule),
    |]);
  let make = (props: props('var)) => {
    let className =
      styles(~var=?props.var, ()) ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "var"));
    createVariadicElement("div", newProps);
  };
};
let width = "120px";
let orientation = "landscape";
module SelectorWithInterpolation = {
  type props = JsxDOM.domProps;
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles =
    CssJs.style(. [|
      CssJs.label("SelectorWithInterpolation"),
      CssJs.media(.
        {js|only screen and (min-width: |js} ++ width ++ {js|)|js},
        [|CssJs.color(CssJs.blue)|],
      ),
      CssJs.media(.
        {js|(min-width: 700px) and (orientation: |js}
        ++ orientation
        ++ {js|)|js},
        [|CssJs.display(`none)|],
      ),
    |]);
  let make = (props: props) => {
    let className = styles ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    createVariadicElement("div", newProps);
  };
};
module MediaQueryCalc = {
  type props = JsxDOM.domProps;
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles =
    CssJs.style(. [|
      CssJs.label("MediaQueryCalc"),
      CssJs.media(.
        {js|(min-width: calc(2px + 1px))|js},
        [|CssJs.color(CssJs.red)|],
      ),
      CssJs.media(.
        {js|(min-width: calc(1000px - 2%))|js},
        [|CssJs.color(CssJs.red)|],
      ),
    |]);
  let make = (props: props) => {
    let className = styles ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    createVariadicElement("div", newProps);
  };
};
module DynamicComponentWithSequence = {
  type props('variant) = {
    ref: ReactDOM.domRef,
    children: React.element,
    [@optional]
    about: string,
    [@optional]
    accentHeight: string,
    [@optional]
    accept: string,
    [@optional]
    acceptCharset: string,
    [@optional]
    accessKey: string,
    [@optional]
    accumulate: string,
    [@optional]
    action: string,
    [@optional]
    additive: string,
    [@optional]
    alignmentBaseline: string,
    [@optional]
    allowFullScreen: bool,
    [@optional]
    allowReorder: string,
    [@optional]
    alphabetic: string,
    [@optional]
    alt: string,
    [@optional]
    amplitude: string,
    [@optional]
    arabicForm: string,
    [@optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@optional]
    ascent: string,
    [@optional]
    async: bool,
    [@optional]
    attributeName: string,
    [@optional]
    attributeType: string,
    [@optional]
    autoComplete: string,
    [@optional]
    autoFocus: bool,
    [@optional]
    autoPlay: bool,
    [@optional]
    autoReverse: string,
    [@optional]
    azimuth: string,
    [@optional]
    baseFrequency: string,
    [@optional]
    baselineShift: string,
    [@optional]
    baseProfile: string,
    [@optional]
    bbox: string,
    [@optional]
    begin_: string,
    [@optional]
    bias: string,
    [@optional]
    by: string,
    [@optional]
    calcMode: string,
    [@optional]
    capHeight: string,
    [@optional]
    challenge: string,
    [@optional]
    charSet: string,
    [@optional]
    checked: bool,
    [@optional]
    cite: string,
    [@optional]
    className: string,
    [@optional]
    clip: string,
    [@optional]
    clipPath: string,
    [@optional]
    clipPathUnits: string,
    [@optional]
    clipRule: string,
    [@optional]
    colorInterpolation: string,
    [@optional]
    colorInterpolationFilters: string,
    [@optional]
    colorProfile: string,
    [@optional]
    colorRendering: string,
    [@optional]
    cols: int,
    [@optional]
    colSpan: int,
    [@optional]
    content: string,
    [@optional]
    contentEditable: bool,
    [@optional]
    contentScriptType: string,
    [@optional]
    contentStyleType: string,
    [@optional]
    contextMenu: string,
    [@optional]
    controls: bool,
    [@optional]
    coords: string,
    [@optional]
    crossorigin: bool,
    [@optional]
    cursor: string,
    [@optional]
    cx: string,
    [@optional]
    cy: string,
    [@optional]
    d: string,
    [@optional]
    data: string,
    [@optional]
    datatype: string,
    [@optional]
    dateTime: string,
    [@optional]
    decelerate: string,
    [@optional]
    default: bool,
    [@optional]
    defaultChecked: bool,
    [@optional]
    defaultValue: string,
    [@optional]
    defer: bool,
    [@optional]
    descent: string,
    [@optional]
    diffuseConstant: string,
    [@optional]
    dir: string,
    [@optional]
    direction: string,
    [@optional]
    disabled: bool,
    [@optional]
    display: string,
    [@optional]
    divisor: string,
    [@optional]
    dominantBaseline: string,
    [@optional]
    download: string,
    [@optional]
    draggable: bool,
    [@optional]
    dur: string,
    [@optional]
    dx: string,
    [@optional]
    dy: string,
    [@optional]
    edgeMode: string,
    [@optional]
    elevation: string,
    [@optional]
    enableBackground: string,
    [@optional]
    encType: string,
    [@optional]
    end_: string,
    [@optional]
    exponent: string,
    [@optional]
    externalResourcesRequired: string,
    [@optional]
    fill: string,
    [@optional]
    fillOpacity: string,
    [@optional]
    fillRule: string,
    [@optional]
    filter: string,
    [@optional]
    filterRes: string,
    [@optional]
    filterUnits: string,
    [@optional]
    floodColor: string,
    [@optional]
    floodOpacity: string,
    [@optional]
    focusable: string,
    [@optional]
    fomat: string,
    [@optional]
    fontFamily: string,
    [@optional]
    fontSize: string,
    [@optional]
    fontSizeAdjust: string,
    [@optional]
    fontStretch: string,
    [@optional]
    fontStyle: string,
    [@optional]
    fontVariant: string,
    [@optional]
    fontWeight: string,
    [@optional]
    form: string,
    [@optional]
    formAction: string,
    [@optional]
    formMethod: string,
    [@optional]
    formTarget: string,
    [@optional]
    from: string,
    [@optional]
    fx: string,
    [@optional]
    fy: string,
    [@optional]
    g1: string,
    [@optional]
    g2: string,
    [@optional]
    glyphName: string,
    [@optional]
    glyphOrientationHorizontal: string,
    [@optional]
    glyphOrientationVertical: string,
    [@optional]
    glyphRef: string,
    [@optional]
    gradientTransform: string,
    [@optional]
    gradientUnits: string,
    [@optional]
    hanging: string,
    [@optional]
    headers: string,
    [@optional]
    height: string,
    [@optional]
    hidden: bool,
    [@optional]
    high: int,
    [@optional]
    horizAdvX: string,
    [@optional]
    horizOriginX: string,
    [@optional]
    href: string,
    [@optional]
    hrefLang: string,
    [@optional]
    htmlFor: string,
    [@optional]
    httpEquiv: string,
    [@optional]
    icon: string,
    [@optional]
    id: string,
    [@optional]
    ideographic: string,
    [@optional]
    imageRendering: string,
    [@optional]
    in_: string,
    [@optional]
    in2: string,
    [@optional]
    inlist: string,
    [@optional]
    inputMode: string,
    [@optional]
    integrity: string,
    [@optional]
    intercept: string,
    [@optional]
    itemID: string,
    [@optional]
    itemProp: string,
    [@optional]
    itemRef: string,
    [@optional]
    itemScope: bool,
    [@optional]
    itemType: string,
    [@optional]
    k: string,
    [@optional]
    k1: string,
    [@optional]
    k2: string,
    [@optional]
    k3: string,
    [@optional]
    k4: string,
    [@optional]
    kernelMatrix: string,
    [@optional]
    kernelUnitLength: string,
    [@optional]
    kerning: string,
    [@optional]
    key: string,
    [@optional]
    keyPoints: string,
    [@optional]
    keySplines: string,
    [@optional]
    keyTimes: string,
    [@optional]
    keyType: string,
    [@optional]
    kind: string,
    [@optional]
    label: string,
    [@optional]
    lang: string,
    [@optional]
    lengthAdjust: string,
    [@optional]
    letterSpacing: string,
    [@optional]
    lightingColor: string,
    [@optional]
    limitingConeAngle: string,
    [@optional]
    list: string,
    [@optional]
    local: string,
    [@optional]
    loop: bool,
    [@optional]
    low: int,
    [@optional]
    manifest: string,
    [@optional]
    markerEnd: string,
    [@optional]
    markerHeight: string,
    [@optional]
    markerMid: string,
    [@optional]
    markerStart: string,
    [@optional]
    markerUnits: string,
    [@optional]
    markerWidth: string,
    [@optional]
    mask: string,
    [@optional]
    maskContentUnits: string,
    [@optional]
    maskUnits: string,
    [@optional]
    mathematical: string,
    [@optional]
    max: string,
    [@optional]
    maxLength: int,
    [@optional]
    media: string,
    [@optional]
    mediaGroup: string,
    [@optional]
    min: int,
    [@optional]
    minLength: int,
    [@optional]
    mode: string,
    [@optional]
    multiple: bool,
    [@optional]
    muted: bool,
    [@optional]
    name: string,
    [@optional]
    nonce: string,
    [@optional]
    noValidate: bool,
    [@optional]
    numOctaves: string,
    [@optional]
    offset: string,
    [@optional]
    opacity: string,
    [@optional]
    open_: bool,
    [@optional]
    operator: string,
    [@optional]
    optimum: int,
    [@optional]
    order: string,
    [@optional]
    orient: string,
    [@optional]
    orientation: string,
    [@optional]
    origin: string,
    [@optional]
    overflow: string,
    [@optional]
    overflowX: string,
    [@optional]
    overflowY: string,
    [@optional]
    overlinePosition: string,
    [@optional]
    overlineThickness: string,
    [@optional]
    paintOrder: string,
    [@optional]
    panose1: string,
    [@optional]
    pathLength: string,
    [@optional]
    pattern: string,
    [@optional]
    patternContentUnits: string,
    [@optional]
    patternTransform: string,
    [@optional]
    patternUnits: string,
    [@optional]
    placeholder: string,
    [@optional]
    pointerEvents: string,
    [@optional]
    points: string,
    [@optional]
    pointsAtX: string,
    [@optional]
    pointsAtY: string,
    [@optional]
    pointsAtZ: string,
    [@optional]
    poster: string,
    [@optional]
    prefix: string,
    [@optional]
    preload: string,
    [@optional]
    preserveAlpha: string,
    [@optional]
    preserveAspectRatio: string,
    [@optional]
    primitiveUnits: string,
    [@optional]
    property: string,
    [@optional]
    r: string,
    [@optional]
    radioGroup: string,
    [@optional]
    radius: string,
    [@optional]
    readOnly: bool,
    [@optional]
    refX: string,
    [@optional]
    refY: string,
    [@optional]
    rel: string,
    [@optional]
    renderingIntent: string,
    [@optional]
    repeatCount: string,
    [@optional]
    repeatDur: string,
    [@optional]
    required: bool,
    [@optional]
    requiredExtensions: string,
    [@optional]
    requiredFeatures: string,
    [@optional]
    resource: string,
    [@optional]
    restart: string,
    [@optional]
    result: string,
    [@optional]
    reversed: bool,
    [@optional]
    role: string,
    [@optional]
    rotate: string,
    [@optional]
    rows: int,
    [@optional]
    rowSpan: int,
    [@optional]
    rx: string,
    [@optional]
    ry: string,
    [@optional]
    sandbox: string,
    [@optional]
    scale: string,
    [@optional]
    scope: string,
    [@optional]
    scoped: bool,
    [@optional]
    scrolling: string,
    [@optional]
    seed: string,
    [@optional]
    selected: bool,
    [@optional]
    shape: string,
    [@optional]
    shapeRendering: string,
    [@optional]
    size: int,
    [@optional]
    sizes: string,
    [@optional]
    slope: string,
    [@optional]
    spacing: string,
    [@optional]
    span: int,
    [@optional]
    specularConstant: string,
    [@optional]
    specularExponent: string,
    [@optional]
    speed: string,
    [@optional]
    spellCheck: bool,
    [@optional]
    spreadMethod: string,
    [@optional]
    src: string,
    [@optional]
    srcDoc: string,
    [@optional]
    srcLang: string,
    [@optional]
    srcSet: string,
    [@optional]
    start: int,
    [@optional]
    startOffset: string,
    [@optional]
    stdDeviation: string,
    [@optional]
    stemh: string,
    [@optional]
    stemv: string,
    [@optional]
    step: float,
    [@optional]
    stitchTiles: string,
    [@optional]
    stopColor: string,
    [@optional]
    stopOpacity: string,
    [@optional]
    strikethroughPosition: string,
    [@optional]
    strikethroughThickness: string,
    [@optional]
    stroke: string,
    [@optional]
    strokeDasharray: string,
    [@optional]
    strokeDashoffset: string,
    [@optional]
    strokeLinecap: string,
    [@optional]
    strokeLinejoin: string,
    [@optional]
    strokeMiterlimit: string,
    [@optional]
    strokeOpacity: string,
    [@optional]
    strokeWidth: string,
    [@optional]
    style: ReactDOM.Style.t,
    [@optional]
    summary: string,
    [@optional]
    suppressContentEditableWarning: bool,
    [@optional]
    surfaceScale: string,
    [@optional]
    systemLanguage: string,
    [@optional]
    tabIndex: int,
    [@optional]
    tableValues: string,
    [@optional]
    target: string,
    [@optional]
    targetX: string,
    [@optional]
    targetY: string,
    [@optional]
    textAnchor: string,
    [@optional]
    textDecoration: string,
    [@optional]
    textLength: string,
    [@optional]
    textRendering: string,
    [@optional]
    title: string,
    [@optional]
    to_: string,
    [@optional]
    transform: string,
    [@optional] [@bs.as "type"]
    type_: string,
    [@optional]
    typeof: string,
    [@optional]
    u1: string,
    [@optional]
    u2: string,
    [@optional]
    underlinePosition: string,
    [@optional]
    underlineThickness: string,
    [@optional]
    unicode: string,
    [@optional]
    unicodeBidi: string,
    [@optional]
    unicodeRange: string,
    [@optional]
    unitsPerEm: string,
    [@optional]
    useMap: string,
    [@optional]
    vAlphabetic: string,
    [@optional]
    value: string,
    [@optional]
    values: string,
    [@optional]
    vectorEffect: string,
    [@optional]
    version: string,
    [@optional]
    vertAdvX: string,
    [@optional]
    vertAdvY: string,
    [@optional]
    vertOriginX: string,
    [@optional]
    vertOriginY: string,
    [@optional]
    vHanging: string,
    [@optional]
    vIdeographic: string,
    [@optional]
    viewBox: string,
    [@optional]
    viewTarget: string,
    [@optional]
    visibility: string,
    [@optional]
    vMathematical: string,
    [@optional]
    vocab: string,
    [@optional]
    width: string,
    [@optional]
    widths: string,
    [@optional]
    wordSpacing: string,
    [@optional]
    wrap: string,
    [@optional]
    writingMode: string,
    [@optional]
    x: string,
    [@optional]
    x1: string,
    [@optional]
    x2: string,
    [@optional]
    xChannelSelector: string,
    [@optional]
    xHeight: string,
    [@optional]
    xlinkActuate: string,
    [@optional]
    xlinkArcrole: string,
    [@optional]
    xlinkHref: string,
    [@optional]
    xlinkRole: string,
    [@optional]
    xlinkShow: string,
    [@optional]
    xlinkTitle: string,
    [@optional]
    xlinkType: string,
    [@optional]
    xmlBase: string,
    [@optional]
    xmlLang: string,
    [@optional]
    xmlns: string,
    [@optional]
    xmlnsXlink: string,
    [@optional]
    xmlSpace: string,
    [@optional]
    y: string,
    [@optional]
    y1: string,
    [@optional]
    y2: string,
    [@optional]
    yChannelSelector: string,
    [@optional]
    z: string,
    [@optional]
    zoomAndPan: string,
    [@optional]
    onAbort: ReactEvent.Media.t => unit,
    [@optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@optional]
    onChange: ReactEvent.Form.t => unit,
    [@optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@optional]
    onEnded: ReactEvent.Media.t => unit,
    [@optional]
    onError: ReactEvent.Media.t => unit,
    [@optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@optional]
    onInput: ReactEvent.Form.t => unit,
    [@optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@optional]
    onPause: ReactEvent.Media.t => unit,
    [@optional]
    onPlay: ReactEvent.Media.t => unit,
    [@optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@optional]
    onProgress: ReactEvent.Media.t => unit,
    [@optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@optional]
    onScroll: ReactEvent.UI.t => unit,
    [@optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@optional]
    onStalled: ReactEvent.Media.t => unit,
    [@optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@optional]
    onWheel: ReactEvent.Wheel.t => unit,
    variant: 'variant,
  };
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles = (~variant, _) => {
    let color = Theme.button(variant);
    CssJs.style(. [|
      CssJs.display(`inlineFlex),
      (CssJs.color(color): CssJs.rule),
      CssJs.width(`percent(100.)),
    |]);
  };
  let make = (props: props('variant)) => {
    let className =
      styles(~variant=props.variant, ()) ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "variant"));
    createVariadicElement("button", newProps);
  };
};
module DynamicComponentWithArray = {
  type props('color, 'size) = {
    ref: ReactDOM.domRef,
    children: React.element,
    [@optional]
    about: string,
    [@optional]
    accentHeight: string,
    [@optional]
    accept: string,
    [@optional]
    acceptCharset: string,
    [@optional]
    accessKey: string,
    [@optional]
    accumulate: string,
    [@optional]
    action: string,
    [@optional]
    additive: string,
    [@optional]
    alignmentBaseline: string,
    [@optional]
    allowFullScreen: bool,
    [@optional]
    allowReorder: string,
    [@optional]
    alphabetic: string,
    [@optional]
    alt: string,
    [@optional]
    amplitude: string,
    [@optional]
    arabicForm: string,
    [@optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@optional]
    ascent: string,
    [@optional]
    async: bool,
    [@optional]
    attributeName: string,
    [@optional]
    attributeType: string,
    [@optional]
    autoComplete: string,
    [@optional]
    autoFocus: bool,
    [@optional]
    autoPlay: bool,
    [@optional]
    autoReverse: string,
    [@optional]
    azimuth: string,
    [@optional]
    baseFrequency: string,
    [@optional]
    baselineShift: string,
    [@optional]
    baseProfile: string,
    [@optional]
    bbox: string,
    [@optional]
    begin_: string,
    [@optional]
    bias: string,
    [@optional]
    by: string,
    [@optional]
    calcMode: string,
    [@optional]
    capHeight: string,
    [@optional]
    challenge: string,
    [@optional]
    charSet: string,
    [@optional]
    checked: bool,
    [@optional]
    cite: string,
    [@optional]
    className: string,
    [@optional]
    clip: string,
    [@optional]
    clipPath: string,
    [@optional]
    clipPathUnits: string,
    [@optional]
    clipRule: string,
    [@optional]
    colorInterpolation: string,
    [@optional]
    colorInterpolationFilters: string,
    [@optional]
    colorProfile: string,
    [@optional]
    colorRendering: string,
    [@optional]
    cols: int,
    [@optional]
    colSpan: int,
    [@optional]
    content: string,
    [@optional]
    contentEditable: bool,
    [@optional]
    contentScriptType: string,
    [@optional]
    contentStyleType: string,
    [@optional]
    contextMenu: string,
    [@optional]
    controls: bool,
    [@optional]
    coords: string,
    [@optional]
    crossorigin: bool,
    [@optional]
    cursor: string,
    [@optional]
    cx: string,
    [@optional]
    cy: string,
    [@optional]
    d: string,
    [@optional]
    data: string,
    [@optional]
    datatype: string,
    [@optional]
    dateTime: string,
    [@optional]
    decelerate: string,
    [@optional]
    default: bool,
    [@optional]
    defaultChecked: bool,
    [@optional]
    defaultValue: string,
    [@optional]
    defer: bool,
    [@optional]
    descent: string,
    [@optional]
    diffuseConstant: string,
    [@optional]
    dir: string,
    [@optional]
    direction: string,
    [@optional]
    disabled: bool,
    [@optional]
    display: string,
    [@optional]
    divisor: string,
    [@optional]
    dominantBaseline: string,
    [@optional]
    download: string,
    [@optional]
    draggable: bool,
    [@optional]
    dur: string,
    [@optional]
    dx: string,
    [@optional]
    dy: string,
    [@optional]
    edgeMode: string,
    [@optional]
    elevation: string,
    [@optional]
    enableBackground: string,
    [@optional]
    encType: string,
    [@optional]
    end_: string,
    [@optional]
    exponent: string,
    [@optional]
    externalResourcesRequired: string,
    [@optional]
    fill: string,
    [@optional]
    fillOpacity: string,
    [@optional]
    fillRule: string,
    [@optional]
    filter: string,
    [@optional]
    filterRes: string,
    [@optional]
    filterUnits: string,
    [@optional]
    floodColor: string,
    [@optional]
    floodOpacity: string,
    [@optional]
    focusable: string,
    [@optional]
    fomat: string,
    [@optional]
    fontFamily: string,
    [@optional]
    fontSize: string,
    [@optional]
    fontSizeAdjust: string,
    [@optional]
    fontStretch: string,
    [@optional]
    fontStyle: string,
    [@optional]
    fontVariant: string,
    [@optional]
    fontWeight: string,
    [@optional]
    form: string,
    [@optional]
    formAction: string,
    [@optional]
    formMethod: string,
    [@optional]
    formTarget: string,
    [@optional]
    from: string,
    [@optional]
    fx: string,
    [@optional]
    fy: string,
    [@optional]
    g1: string,
    [@optional]
    g2: string,
    [@optional]
    glyphName: string,
    [@optional]
    glyphOrientationHorizontal: string,
    [@optional]
    glyphOrientationVertical: string,
    [@optional]
    glyphRef: string,
    [@optional]
    gradientTransform: string,
    [@optional]
    gradientUnits: string,
    [@optional]
    hanging: string,
    [@optional]
    headers: string,
    [@optional]
    height: string,
    [@optional]
    hidden: bool,
    [@optional]
    high: int,
    [@optional]
    horizAdvX: string,
    [@optional]
    horizOriginX: string,
    [@optional]
    href: string,
    [@optional]
    hrefLang: string,
    [@optional]
    htmlFor: string,
    [@optional]
    httpEquiv: string,
    [@optional]
    icon: string,
    [@optional]
    id: string,
    [@optional]
    ideographic: string,
    [@optional]
    imageRendering: string,
    [@optional]
    in_: string,
    [@optional]
    in2: string,
    [@optional]
    inlist: string,
    [@optional]
    inputMode: string,
    [@optional]
    integrity: string,
    [@optional]
    intercept: string,
    [@optional]
    itemID: string,
    [@optional]
    itemProp: string,
    [@optional]
    itemRef: string,
    [@optional]
    itemScope: bool,
    [@optional]
    itemType: string,
    [@optional]
    k: string,
    [@optional]
    k1: string,
    [@optional]
    k2: string,
    [@optional]
    k3: string,
    [@optional]
    k4: string,
    [@optional]
    kernelMatrix: string,
    [@optional]
    kernelUnitLength: string,
    [@optional]
    kerning: string,
    [@optional]
    key: string,
    [@optional]
    keyPoints: string,
    [@optional]
    keySplines: string,
    [@optional]
    keyTimes: string,
    [@optional]
    keyType: string,
    [@optional]
    kind: string,
    [@optional]
    label: string,
    [@optional]
    lang: string,
    [@optional]
    lengthAdjust: string,
    [@optional]
    letterSpacing: string,
    [@optional]
    lightingColor: string,
    [@optional]
    limitingConeAngle: string,
    [@optional]
    list: string,
    [@optional]
    local: string,
    [@optional]
    loop: bool,
    [@optional]
    low: int,
    [@optional]
    manifest: string,
    [@optional]
    markerEnd: string,
    [@optional]
    markerHeight: string,
    [@optional]
    markerMid: string,
    [@optional]
    markerStart: string,
    [@optional]
    markerUnits: string,
    [@optional]
    markerWidth: string,
    [@optional]
    mask: string,
    [@optional]
    maskContentUnits: string,
    [@optional]
    maskUnits: string,
    [@optional]
    mathematical: string,
    [@optional]
    max: string,
    [@optional]
    maxLength: int,
    [@optional]
    media: string,
    [@optional]
    mediaGroup: string,
    [@optional]
    min: int,
    [@optional]
    minLength: int,
    [@optional]
    mode: string,
    [@optional]
    multiple: bool,
    [@optional]
    muted: bool,
    [@optional]
    name: string,
    [@optional]
    nonce: string,
    [@optional]
    noValidate: bool,
    [@optional]
    numOctaves: string,
    [@optional]
    offset: string,
    [@optional]
    opacity: string,
    [@optional]
    open_: bool,
    [@optional]
    operator: string,
    [@optional]
    optimum: int,
    [@optional]
    order: string,
    [@optional]
    orient: string,
    [@optional]
    orientation: string,
    [@optional]
    origin: string,
    [@optional]
    overflow: string,
    [@optional]
    overflowX: string,
    [@optional]
    overflowY: string,
    [@optional]
    overlinePosition: string,
    [@optional]
    overlineThickness: string,
    [@optional]
    paintOrder: string,
    [@optional]
    panose1: string,
    [@optional]
    pathLength: string,
    [@optional]
    pattern: string,
    [@optional]
    patternContentUnits: string,
    [@optional]
    patternTransform: string,
    [@optional]
    patternUnits: string,
    [@optional]
    placeholder: string,
    [@optional]
    pointerEvents: string,
    [@optional]
    points: string,
    [@optional]
    pointsAtX: string,
    [@optional]
    pointsAtY: string,
    [@optional]
    pointsAtZ: string,
    [@optional]
    poster: string,
    [@optional]
    prefix: string,
    [@optional]
    preload: string,
    [@optional]
    preserveAlpha: string,
    [@optional]
    preserveAspectRatio: string,
    [@optional]
    primitiveUnits: string,
    [@optional]
    property: string,
    [@optional]
    r: string,
    [@optional]
    radioGroup: string,
    [@optional]
    radius: string,
    [@optional]
    readOnly: bool,
    [@optional]
    refX: string,
    [@optional]
    refY: string,
    [@optional]
    rel: string,
    [@optional]
    renderingIntent: string,
    [@optional]
    repeatCount: string,
    [@optional]
    repeatDur: string,
    [@optional]
    required: bool,
    [@optional]
    requiredExtensions: string,
    [@optional]
    requiredFeatures: string,
    [@optional]
    resource: string,
    [@optional]
    restart: string,
    [@optional]
    result: string,
    [@optional]
    reversed: bool,
    [@optional]
    role: string,
    [@optional]
    rotate: string,
    [@optional]
    rows: int,
    [@optional]
    rowSpan: int,
    [@optional]
    rx: string,
    [@optional]
    ry: string,
    [@optional]
    sandbox: string,
    [@optional]
    scale: string,
    [@optional]
    scope: string,
    [@optional]
    scoped: bool,
    [@optional]
    scrolling: string,
    [@optional]
    seed: string,
    [@optional]
    selected: bool,
    [@optional]
    shape: string,
    [@optional]
    shapeRendering: string,
    [@optional]
    sizes: string,
    [@optional]
    slope: string,
    [@optional]
    spacing: string,
    [@optional]
    span: int,
    [@optional]
    specularConstant: string,
    [@optional]
    specularExponent: string,
    [@optional]
    speed: string,
    [@optional]
    spellCheck: bool,
    [@optional]
    spreadMethod: string,
    [@optional]
    src: string,
    [@optional]
    srcDoc: string,
    [@optional]
    srcLang: string,
    [@optional]
    srcSet: string,
    [@optional]
    start: int,
    [@optional]
    startOffset: string,
    [@optional]
    stdDeviation: string,
    [@optional]
    stemh: string,
    [@optional]
    stemv: string,
    [@optional]
    step: float,
    [@optional]
    stitchTiles: string,
    [@optional]
    stopColor: string,
    [@optional]
    stopOpacity: string,
    [@optional]
    strikethroughPosition: string,
    [@optional]
    strikethroughThickness: string,
    [@optional]
    stroke: string,
    [@optional]
    strokeDasharray: string,
    [@optional]
    strokeDashoffset: string,
    [@optional]
    strokeLinecap: string,
    [@optional]
    strokeLinejoin: string,
    [@optional]
    strokeMiterlimit: string,
    [@optional]
    strokeOpacity: string,
    [@optional]
    strokeWidth: string,
    [@optional]
    style: ReactDOM.Style.t,
    [@optional]
    summary: string,
    [@optional]
    suppressContentEditableWarning: bool,
    [@optional]
    surfaceScale: string,
    [@optional]
    systemLanguage: string,
    [@optional]
    tabIndex: int,
    [@optional]
    tableValues: string,
    [@optional]
    target: string,
    [@optional]
    targetX: string,
    [@optional]
    targetY: string,
    [@optional]
    textAnchor: string,
    [@optional]
    textDecoration: string,
    [@optional]
    textLength: string,
    [@optional]
    textRendering: string,
    [@optional]
    title: string,
    [@optional]
    to_: string,
    [@optional]
    transform: string,
    [@optional] [@bs.as "type"]
    type_: string,
    [@optional]
    typeof: string,
    [@optional]
    u1: string,
    [@optional]
    u2: string,
    [@optional]
    underlinePosition: string,
    [@optional]
    underlineThickness: string,
    [@optional]
    unicode: string,
    [@optional]
    unicodeBidi: string,
    [@optional]
    unicodeRange: string,
    [@optional]
    unitsPerEm: string,
    [@optional]
    useMap: string,
    [@optional]
    vAlphabetic: string,
    [@optional]
    value: string,
    [@optional]
    values: string,
    [@optional]
    vectorEffect: string,
    [@optional]
    version: string,
    [@optional]
    vertAdvX: string,
    [@optional]
    vertAdvY: string,
    [@optional]
    vertOriginX: string,
    [@optional]
    vertOriginY: string,
    [@optional]
    vHanging: string,
    [@optional]
    vIdeographic: string,
    [@optional]
    viewBox: string,
    [@optional]
    viewTarget: string,
    [@optional]
    visibility: string,
    [@optional]
    vMathematical: string,
    [@optional]
    vocab: string,
    [@optional]
    width: string,
    [@optional]
    widths: string,
    [@optional]
    wordSpacing: string,
    [@optional]
    wrap: string,
    [@optional]
    writingMode: string,
    [@optional]
    x: string,
    [@optional]
    x1: string,
    [@optional]
    x2: string,
    [@optional]
    xChannelSelector: string,
    [@optional]
    xHeight: string,
    [@optional]
    xlinkActuate: string,
    [@optional]
    xlinkArcrole: string,
    [@optional]
    xlinkHref: string,
    [@optional]
    xlinkRole: string,
    [@optional]
    xlinkShow: string,
    [@optional]
    xlinkTitle: string,
    [@optional]
    xlinkType: string,
    [@optional]
    xmlBase: string,
    [@optional]
    xmlLang: string,
    [@optional]
    xmlns: string,
    [@optional]
    xmlnsXlink: string,
    [@optional]
    xmlSpace: string,
    [@optional]
    y: string,
    [@optional]
    y1: string,
    [@optional]
    y2: string,
    [@optional]
    yChannelSelector: string,
    [@optional]
    z: string,
    [@optional]
    zoomAndPan: string,
    [@optional]
    onAbort: ReactEvent.Media.t => unit,
    [@optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@optional]
    onChange: ReactEvent.Form.t => unit,
    [@optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@optional]
    onEnded: ReactEvent.Media.t => unit,
    [@optional]
    onError: ReactEvent.Media.t => unit,
    [@optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@optional]
    onInput: ReactEvent.Form.t => unit,
    [@optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@optional]
    onPause: ReactEvent.Media.t => unit,
    [@optional]
    onPlay: ReactEvent.Media.t => unit,
    [@optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@optional]
    onProgress: ReactEvent.Media.t => unit,
    [@optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@optional]
    onScroll: ReactEvent.UI.t => unit,
    [@optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@optional]
    onStalled: ReactEvent.Media.t => unit,
    [@optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@optional]
    onWheel: ReactEvent.Wheel.t => unit,
    color: 'color,
    size: 'size,
  };
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles = (~size, ~color, _) =>
    CssJs.style(. [|
      CssJs.label("DynamicComponentWithArray"),
      CssJs.width(`percent(100.)),
      CssJs.display(`block),
      (CssJs.color(color): CssJs.rule),
      (CssJs.width(size): CssJs.rule),
    |]);
  let make = (props: props('color, 'size)) => {
    let className =
      styles(~color=props.color, ~size=props.size, ())
      ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "color"));
    ignore(deleteProp(newProps, "size"));
    createVariadicElement("button", newProps);
  };
};
let sharedStylesBetweenDynamicComponents = (color): CssJs.rule =>
  CssJs.color(color);
module DynamicCompnentWithLetIn = {
  type props('color) = {
    ref: ReactDOM.domRef,
    children: React.element,
    [@optional]
    about: string,
    [@optional]
    accentHeight: string,
    [@optional]
    accept: string,
    [@optional]
    acceptCharset: string,
    [@optional]
    accessKey: string,
    [@optional]
    accumulate: string,
    [@optional]
    action: string,
    [@optional]
    additive: string,
    [@optional]
    alignmentBaseline: string,
    [@optional]
    allowFullScreen: bool,
    [@optional]
    allowReorder: string,
    [@optional]
    alphabetic: string,
    [@optional]
    alt: string,
    [@optional]
    amplitude: string,
    [@optional]
    arabicForm: string,
    [@optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@optional]
    ascent: string,
    [@optional]
    async: bool,
    [@optional]
    attributeName: string,
    [@optional]
    attributeType: string,
    [@optional]
    autoComplete: string,
    [@optional]
    autoFocus: bool,
    [@optional]
    autoPlay: bool,
    [@optional]
    autoReverse: string,
    [@optional]
    azimuth: string,
    [@optional]
    baseFrequency: string,
    [@optional]
    baselineShift: string,
    [@optional]
    baseProfile: string,
    [@optional]
    bbox: string,
    [@optional]
    begin_: string,
    [@optional]
    bias: string,
    [@optional]
    by: string,
    [@optional]
    calcMode: string,
    [@optional]
    capHeight: string,
    [@optional]
    challenge: string,
    [@optional]
    charSet: string,
    [@optional]
    checked: bool,
    [@optional]
    cite: string,
    [@optional]
    className: string,
    [@optional]
    clip: string,
    [@optional]
    clipPath: string,
    [@optional]
    clipPathUnits: string,
    [@optional]
    clipRule: string,
    [@optional]
    colorInterpolation: string,
    [@optional]
    colorInterpolationFilters: string,
    [@optional]
    colorProfile: string,
    [@optional]
    colorRendering: string,
    [@optional]
    cols: int,
    [@optional]
    colSpan: int,
    [@optional]
    content: string,
    [@optional]
    contentEditable: bool,
    [@optional]
    contentScriptType: string,
    [@optional]
    contentStyleType: string,
    [@optional]
    contextMenu: string,
    [@optional]
    controls: bool,
    [@optional]
    coords: string,
    [@optional]
    crossorigin: bool,
    [@optional]
    cursor: string,
    [@optional]
    cx: string,
    [@optional]
    cy: string,
    [@optional]
    d: string,
    [@optional]
    data: string,
    [@optional]
    datatype: string,
    [@optional]
    dateTime: string,
    [@optional]
    decelerate: string,
    [@optional]
    default: bool,
    [@optional]
    defaultChecked: bool,
    [@optional]
    defaultValue: string,
    [@optional]
    defer: bool,
    [@optional]
    descent: string,
    [@optional]
    diffuseConstant: string,
    [@optional]
    dir: string,
    [@optional]
    direction: string,
    [@optional]
    disabled: bool,
    [@optional]
    display: string,
    [@optional]
    divisor: string,
    [@optional]
    dominantBaseline: string,
    [@optional]
    download: string,
    [@optional]
    draggable: bool,
    [@optional]
    dur: string,
    [@optional]
    dx: string,
    [@optional]
    dy: string,
    [@optional]
    edgeMode: string,
    [@optional]
    elevation: string,
    [@optional]
    enableBackground: string,
    [@optional]
    encType: string,
    [@optional]
    end_: string,
    [@optional]
    exponent: string,
    [@optional]
    externalResourcesRequired: string,
    [@optional]
    fill: string,
    [@optional]
    fillOpacity: string,
    [@optional]
    fillRule: string,
    [@optional]
    filter: string,
    [@optional]
    filterRes: string,
    [@optional]
    filterUnits: string,
    [@optional]
    floodColor: string,
    [@optional]
    floodOpacity: string,
    [@optional]
    focusable: string,
    [@optional]
    fomat: string,
    [@optional]
    fontFamily: string,
    [@optional]
    fontSize: string,
    [@optional]
    fontSizeAdjust: string,
    [@optional]
    fontStretch: string,
    [@optional]
    fontStyle: string,
    [@optional]
    fontVariant: string,
    [@optional]
    fontWeight: string,
    [@optional]
    form: string,
    [@optional]
    formAction: string,
    [@optional]
    formMethod: string,
    [@optional]
    formTarget: string,
    [@optional]
    from: string,
    [@optional]
    fx: string,
    [@optional]
    fy: string,
    [@optional]
    g1: string,
    [@optional]
    g2: string,
    [@optional]
    glyphName: string,
    [@optional]
    glyphOrientationHorizontal: string,
    [@optional]
    glyphOrientationVertical: string,
    [@optional]
    glyphRef: string,
    [@optional]
    gradientTransform: string,
    [@optional]
    gradientUnits: string,
    [@optional]
    hanging: string,
    [@optional]
    headers: string,
    [@optional]
    height: string,
    [@optional]
    hidden: bool,
    [@optional]
    high: int,
    [@optional]
    horizAdvX: string,
    [@optional]
    horizOriginX: string,
    [@optional]
    href: string,
    [@optional]
    hrefLang: string,
    [@optional]
    htmlFor: string,
    [@optional]
    httpEquiv: string,
    [@optional]
    icon: string,
    [@optional]
    id: string,
    [@optional]
    ideographic: string,
    [@optional]
    imageRendering: string,
    [@optional]
    in_: string,
    [@optional]
    in2: string,
    [@optional]
    inlist: string,
    [@optional]
    inputMode: string,
    [@optional]
    integrity: string,
    [@optional]
    intercept: string,
    [@optional]
    itemID: string,
    [@optional]
    itemProp: string,
    [@optional]
    itemRef: string,
    [@optional]
    itemScope: bool,
    [@optional]
    itemType: string,
    [@optional]
    k: string,
    [@optional]
    k1: string,
    [@optional]
    k2: string,
    [@optional]
    k3: string,
    [@optional]
    k4: string,
    [@optional]
    kernelMatrix: string,
    [@optional]
    kernelUnitLength: string,
    [@optional]
    kerning: string,
    [@optional]
    key: string,
    [@optional]
    keyPoints: string,
    [@optional]
    keySplines: string,
    [@optional]
    keyTimes: string,
    [@optional]
    keyType: string,
    [@optional]
    kind: string,
    [@optional]
    label: string,
    [@optional]
    lang: string,
    [@optional]
    lengthAdjust: string,
    [@optional]
    letterSpacing: string,
    [@optional]
    lightingColor: string,
    [@optional]
    limitingConeAngle: string,
    [@optional]
    list: string,
    [@optional]
    local: string,
    [@optional]
    loop: bool,
    [@optional]
    low: int,
    [@optional]
    manifest: string,
    [@optional]
    markerEnd: string,
    [@optional]
    markerHeight: string,
    [@optional]
    markerMid: string,
    [@optional]
    markerStart: string,
    [@optional]
    markerUnits: string,
    [@optional]
    markerWidth: string,
    [@optional]
    mask: string,
    [@optional]
    maskContentUnits: string,
    [@optional]
    maskUnits: string,
    [@optional]
    mathematical: string,
    [@optional]
    max: string,
    [@optional]
    maxLength: int,
    [@optional]
    media: string,
    [@optional]
    mediaGroup: string,
    [@optional]
    min: int,
    [@optional]
    minLength: int,
    [@optional]
    mode: string,
    [@optional]
    multiple: bool,
    [@optional]
    muted: bool,
    [@optional]
    name: string,
    [@optional]
    nonce: string,
    [@optional]
    noValidate: bool,
    [@optional]
    numOctaves: string,
    [@optional]
    offset: string,
    [@optional]
    opacity: string,
    [@optional]
    open_: bool,
    [@optional]
    operator: string,
    [@optional]
    optimum: int,
    [@optional]
    order: string,
    [@optional]
    orient: string,
    [@optional]
    orientation: string,
    [@optional]
    origin: string,
    [@optional]
    overflow: string,
    [@optional]
    overflowX: string,
    [@optional]
    overflowY: string,
    [@optional]
    overlinePosition: string,
    [@optional]
    overlineThickness: string,
    [@optional]
    paintOrder: string,
    [@optional]
    panose1: string,
    [@optional]
    pathLength: string,
    [@optional]
    pattern: string,
    [@optional]
    patternContentUnits: string,
    [@optional]
    patternTransform: string,
    [@optional]
    patternUnits: string,
    [@optional]
    placeholder: string,
    [@optional]
    pointerEvents: string,
    [@optional]
    points: string,
    [@optional]
    pointsAtX: string,
    [@optional]
    pointsAtY: string,
    [@optional]
    pointsAtZ: string,
    [@optional]
    poster: string,
    [@optional]
    prefix: string,
    [@optional]
    preload: string,
    [@optional]
    preserveAlpha: string,
    [@optional]
    preserveAspectRatio: string,
    [@optional]
    primitiveUnits: string,
    [@optional]
    property: string,
    [@optional]
    r: string,
    [@optional]
    radioGroup: string,
    [@optional]
    radius: string,
    [@optional]
    readOnly: bool,
    [@optional]
    refX: string,
    [@optional]
    refY: string,
    [@optional]
    rel: string,
    [@optional]
    renderingIntent: string,
    [@optional]
    repeatCount: string,
    [@optional]
    repeatDur: string,
    [@optional]
    required: bool,
    [@optional]
    requiredExtensions: string,
    [@optional]
    requiredFeatures: string,
    [@optional]
    resource: string,
    [@optional]
    restart: string,
    [@optional]
    result: string,
    [@optional]
    reversed: bool,
    [@optional]
    role: string,
    [@optional]
    rotate: string,
    [@optional]
    rows: int,
    [@optional]
    rowSpan: int,
    [@optional]
    rx: string,
    [@optional]
    ry: string,
    [@optional]
    sandbox: string,
    [@optional]
    scale: string,
    [@optional]
    scope: string,
    [@optional]
    scoped: bool,
    [@optional]
    scrolling: string,
    [@optional]
    seed: string,
    [@optional]
    selected: bool,
    [@optional]
    shape: string,
    [@optional]
    shapeRendering: string,
    [@optional]
    size: int,
    [@optional]
    sizes: string,
    [@optional]
    slope: string,
    [@optional]
    spacing: string,
    [@optional]
    span: int,
    [@optional]
    specularConstant: string,
    [@optional]
    specularExponent: string,
    [@optional]
    speed: string,
    [@optional]
    spellCheck: bool,
    [@optional]
    spreadMethod: string,
    [@optional]
    src: string,
    [@optional]
    srcDoc: string,
    [@optional]
    srcLang: string,
    [@optional]
    srcSet: string,
    [@optional]
    start: int,
    [@optional]
    startOffset: string,
    [@optional]
    stdDeviation: string,
    [@optional]
    stemh: string,
    [@optional]
    stemv: string,
    [@optional]
    step: float,
    [@optional]
    stitchTiles: string,
    [@optional]
    stopColor: string,
    [@optional]
    stopOpacity: string,
    [@optional]
    strikethroughPosition: string,
    [@optional]
    strikethroughThickness: string,
    [@optional]
    stroke: string,
    [@optional]
    strokeDasharray: string,
    [@optional]
    strokeDashoffset: string,
    [@optional]
    strokeLinecap: string,
    [@optional]
    strokeLinejoin: string,
    [@optional]
    strokeMiterlimit: string,
    [@optional]
    strokeOpacity: string,
    [@optional]
    strokeWidth: string,
    [@optional]
    style: ReactDOM.Style.t,
    [@optional]
    summary: string,
    [@optional]
    suppressContentEditableWarning: bool,
    [@optional]
    surfaceScale: string,
    [@optional]
    systemLanguage: string,
    [@optional]
    tabIndex: int,
    [@optional]
    tableValues: string,
    [@optional]
    target: string,
    [@optional]
    targetX: string,
    [@optional]
    targetY: string,
    [@optional]
    textAnchor: string,
    [@optional]
    textDecoration: string,
    [@optional]
    textLength: string,
    [@optional]
    textRendering: string,
    [@optional]
    title: string,
    [@optional]
    to_: string,
    [@optional]
    transform: string,
    [@optional] [@bs.as "type"]
    type_: string,
    [@optional]
    typeof: string,
    [@optional]
    u1: string,
    [@optional]
    u2: string,
    [@optional]
    underlinePosition: string,
    [@optional]
    underlineThickness: string,
    [@optional]
    unicode: string,
    [@optional]
    unicodeBidi: string,
    [@optional]
    unicodeRange: string,
    [@optional]
    unitsPerEm: string,
    [@optional]
    useMap: string,
    [@optional]
    vAlphabetic: string,
    [@optional]
    value: string,
    [@optional]
    values: string,
    [@optional]
    vectorEffect: string,
    [@optional]
    version: string,
    [@optional]
    vertAdvX: string,
    [@optional]
    vertAdvY: string,
    [@optional]
    vertOriginX: string,
    [@optional]
    vertOriginY: string,
    [@optional]
    vHanging: string,
    [@optional]
    vIdeographic: string,
    [@optional]
    viewBox: string,
    [@optional]
    viewTarget: string,
    [@optional]
    visibility: string,
    [@optional]
    vMathematical: string,
    [@optional]
    vocab: string,
    [@optional]
    width: string,
    [@optional]
    widths: string,
    [@optional]
    wordSpacing: string,
    [@optional]
    wrap: string,
    [@optional]
    writingMode: string,
    [@optional]
    x: string,
    [@optional]
    x1: string,
    [@optional]
    x2: string,
    [@optional]
    xChannelSelector: string,
    [@optional]
    xHeight: string,
    [@optional]
    xlinkActuate: string,
    [@optional]
    xlinkArcrole: string,
    [@optional]
    xlinkHref: string,
    [@optional]
    xlinkRole: string,
    [@optional]
    xlinkShow: string,
    [@optional]
    xlinkTitle: string,
    [@optional]
    xlinkType: string,
    [@optional]
    xmlBase: string,
    [@optional]
    xmlLang: string,
    [@optional]
    xmlns: string,
    [@optional]
    xmlnsXlink: string,
    [@optional]
    xmlSpace: string,
    [@optional]
    y: string,
    [@optional]
    y1: string,
    [@optional]
    y2: string,
    [@optional]
    yChannelSelector: string,
    [@optional]
    z: string,
    [@optional]
    zoomAndPan: string,
    [@optional]
    onAbort: ReactEvent.Media.t => unit,
    [@optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@optional]
    onChange: ReactEvent.Form.t => unit,
    [@optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@optional]
    onEnded: ReactEvent.Media.t => unit,
    [@optional]
    onError: ReactEvent.Media.t => unit,
    [@optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@optional]
    onInput: ReactEvent.Form.t => unit,
    [@optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@optional]
    onPause: ReactEvent.Media.t => unit,
    [@optional]
    onPlay: ReactEvent.Media.t => unit,
    [@optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@optional]
    onProgress: ReactEvent.Media.t => unit,
    [@optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@optional]
    onScroll: ReactEvent.UI.t => unit,
    [@optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@optional]
    onStalled: ReactEvent.Media.t => unit,
    [@optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@optional]
    onWheel: ReactEvent.Wheel.t => unit,
    color: 'color,
  };
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles = (~color, _) => {
    let styles = sharedStylesBetweenDynamicComponents(color);
    CssJs.style(. styles);
  };
  let make = (props: props('color)) => {
    let className =
      styles(~color=props.color, ()) ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "color"));
    createVariadicElement("div", newProps);
  };
};
module DynamicCompnentWithIdent = {
  type props('a) = {
    ref: ReactDOM.domRef,
    children: React.element,
    [@optional]
    about: string,
    [@optional]
    accentHeight: string,
    [@optional]
    accept: string,
    [@optional]
    acceptCharset: string,
    [@optional]
    accessKey: string,
    [@optional]
    accumulate: string,
    [@optional]
    action: string,
    [@optional]
    additive: string,
    [@optional]
    alignmentBaseline: string,
    [@optional]
    allowFullScreen: bool,
    [@optional]
    allowReorder: string,
    [@optional]
    alphabetic: string,
    [@optional]
    alt: string,
    [@optional]
    amplitude: string,
    [@optional]
    arabicForm: string,
    [@optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@optional]
    ascent: string,
    [@optional]
    async: bool,
    [@optional]
    attributeName: string,
    [@optional]
    attributeType: string,
    [@optional]
    autoComplete: string,
    [@optional]
    autoFocus: bool,
    [@optional]
    autoPlay: bool,
    [@optional]
    autoReverse: string,
    [@optional]
    azimuth: string,
    [@optional]
    baseFrequency: string,
    [@optional]
    baselineShift: string,
    [@optional]
    baseProfile: string,
    [@optional]
    bbox: string,
    [@optional]
    begin_: string,
    [@optional]
    bias: string,
    [@optional]
    by: string,
    [@optional]
    calcMode: string,
    [@optional]
    capHeight: string,
    [@optional]
    challenge: string,
    [@optional]
    charSet: string,
    [@optional]
    checked: bool,
    [@optional]
    cite: string,
    [@optional]
    className: string,
    [@optional]
    clip: string,
    [@optional]
    clipPath: string,
    [@optional]
    clipPathUnits: string,
    [@optional]
    clipRule: string,
    [@optional]
    colorInterpolation: string,
    [@optional]
    colorInterpolationFilters: string,
    [@optional]
    colorProfile: string,
    [@optional]
    colorRendering: string,
    [@optional]
    cols: int,
    [@optional]
    colSpan: int,
    [@optional]
    content: string,
    [@optional]
    contentEditable: bool,
    [@optional]
    contentScriptType: string,
    [@optional]
    contentStyleType: string,
    [@optional]
    contextMenu: string,
    [@optional]
    controls: bool,
    [@optional]
    coords: string,
    [@optional]
    crossorigin: bool,
    [@optional]
    cursor: string,
    [@optional]
    cx: string,
    [@optional]
    cy: string,
    [@optional]
    d: string,
    [@optional]
    data: string,
    [@optional]
    datatype: string,
    [@optional]
    dateTime: string,
    [@optional]
    decelerate: string,
    [@optional]
    default: bool,
    [@optional]
    defaultChecked: bool,
    [@optional]
    defaultValue: string,
    [@optional]
    defer: bool,
    [@optional]
    descent: string,
    [@optional]
    diffuseConstant: string,
    [@optional]
    dir: string,
    [@optional]
    direction: string,
    [@optional]
    disabled: bool,
    [@optional]
    display: string,
    [@optional]
    divisor: string,
    [@optional]
    dominantBaseline: string,
    [@optional]
    download: string,
    [@optional]
    draggable: bool,
    [@optional]
    dur: string,
    [@optional]
    dx: string,
    [@optional]
    dy: string,
    [@optional]
    edgeMode: string,
    [@optional]
    elevation: string,
    [@optional]
    enableBackground: string,
    [@optional]
    encType: string,
    [@optional]
    end_: string,
    [@optional]
    exponent: string,
    [@optional]
    externalResourcesRequired: string,
    [@optional]
    fill: string,
    [@optional]
    fillOpacity: string,
    [@optional]
    fillRule: string,
    [@optional]
    filter: string,
    [@optional]
    filterRes: string,
    [@optional]
    filterUnits: string,
    [@optional]
    floodColor: string,
    [@optional]
    floodOpacity: string,
    [@optional]
    focusable: string,
    [@optional]
    fomat: string,
    [@optional]
    fontFamily: string,
    [@optional]
    fontSize: string,
    [@optional]
    fontSizeAdjust: string,
    [@optional]
    fontStretch: string,
    [@optional]
    fontStyle: string,
    [@optional]
    fontVariant: string,
    [@optional]
    fontWeight: string,
    [@optional]
    form: string,
    [@optional]
    formAction: string,
    [@optional]
    formMethod: string,
    [@optional]
    formTarget: string,
    [@optional]
    from: string,
    [@optional]
    fx: string,
    [@optional]
    fy: string,
    [@optional]
    g1: string,
    [@optional]
    g2: string,
    [@optional]
    glyphName: string,
    [@optional]
    glyphOrientationHorizontal: string,
    [@optional]
    glyphOrientationVertical: string,
    [@optional]
    glyphRef: string,
    [@optional]
    gradientTransform: string,
    [@optional]
    gradientUnits: string,
    [@optional]
    hanging: string,
    [@optional]
    headers: string,
    [@optional]
    height: string,
    [@optional]
    hidden: bool,
    [@optional]
    high: int,
    [@optional]
    horizAdvX: string,
    [@optional]
    horizOriginX: string,
    [@optional]
    href: string,
    [@optional]
    hrefLang: string,
    [@optional]
    htmlFor: string,
    [@optional]
    httpEquiv: string,
    [@optional]
    icon: string,
    [@optional]
    id: string,
    [@optional]
    ideographic: string,
    [@optional]
    imageRendering: string,
    [@optional]
    in_: string,
    [@optional]
    in2: string,
    [@optional]
    inlist: string,
    [@optional]
    inputMode: string,
    [@optional]
    integrity: string,
    [@optional]
    intercept: string,
    [@optional]
    itemID: string,
    [@optional]
    itemProp: string,
    [@optional]
    itemRef: string,
    [@optional]
    itemScope: bool,
    [@optional]
    itemType: string,
    [@optional]
    k: string,
    [@optional]
    k1: string,
    [@optional]
    k2: string,
    [@optional]
    k3: string,
    [@optional]
    k4: string,
    [@optional]
    kernelMatrix: string,
    [@optional]
    kernelUnitLength: string,
    [@optional]
    kerning: string,
    [@optional]
    key: string,
    [@optional]
    keyPoints: string,
    [@optional]
    keySplines: string,
    [@optional]
    keyTimes: string,
    [@optional]
    keyType: string,
    [@optional]
    kind: string,
    [@optional]
    label: string,
    [@optional]
    lang: string,
    [@optional]
    lengthAdjust: string,
    [@optional]
    letterSpacing: string,
    [@optional]
    lightingColor: string,
    [@optional]
    limitingConeAngle: string,
    [@optional]
    list: string,
    [@optional]
    local: string,
    [@optional]
    loop: bool,
    [@optional]
    low: int,
    [@optional]
    manifest: string,
    [@optional]
    markerEnd: string,
    [@optional]
    markerHeight: string,
    [@optional]
    markerMid: string,
    [@optional]
    markerStart: string,
    [@optional]
    markerUnits: string,
    [@optional]
    markerWidth: string,
    [@optional]
    mask: string,
    [@optional]
    maskContentUnits: string,
    [@optional]
    maskUnits: string,
    [@optional]
    mathematical: string,
    [@optional]
    max: string,
    [@optional]
    maxLength: int,
    [@optional]
    media: string,
    [@optional]
    mediaGroup: string,
    [@optional]
    min: int,
    [@optional]
    minLength: int,
    [@optional]
    mode: string,
    [@optional]
    multiple: bool,
    [@optional]
    muted: bool,
    [@optional]
    name: string,
    [@optional]
    nonce: string,
    [@optional]
    noValidate: bool,
    [@optional]
    numOctaves: string,
    [@optional]
    offset: string,
    [@optional]
    opacity: string,
    [@optional]
    open_: bool,
    [@optional]
    operator: string,
    [@optional]
    optimum: int,
    [@optional]
    order: string,
    [@optional]
    orient: string,
    [@optional]
    orientation: string,
    [@optional]
    origin: string,
    [@optional]
    overflow: string,
    [@optional]
    overflowX: string,
    [@optional]
    overflowY: string,
    [@optional]
    overlinePosition: string,
    [@optional]
    overlineThickness: string,
    [@optional]
    paintOrder: string,
    [@optional]
    panose1: string,
    [@optional]
    pathLength: string,
    [@optional]
    pattern: string,
    [@optional]
    patternContentUnits: string,
    [@optional]
    patternTransform: string,
    [@optional]
    patternUnits: string,
    [@optional]
    placeholder: string,
    [@optional]
    pointerEvents: string,
    [@optional]
    points: string,
    [@optional]
    pointsAtX: string,
    [@optional]
    pointsAtY: string,
    [@optional]
    pointsAtZ: string,
    [@optional]
    poster: string,
    [@optional]
    prefix: string,
    [@optional]
    preload: string,
    [@optional]
    preserveAlpha: string,
    [@optional]
    preserveAspectRatio: string,
    [@optional]
    primitiveUnits: string,
    [@optional]
    property: string,
    [@optional]
    r: string,
    [@optional]
    radioGroup: string,
    [@optional]
    radius: string,
    [@optional]
    readOnly: bool,
    [@optional]
    refX: string,
    [@optional]
    refY: string,
    [@optional]
    rel: string,
    [@optional]
    renderingIntent: string,
    [@optional]
    repeatCount: string,
    [@optional]
    repeatDur: string,
    [@optional]
    required: bool,
    [@optional]
    requiredExtensions: string,
    [@optional]
    requiredFeatures: string,
    [@optional]
    resource: string,
    [@optional]
    restart: string,
    [@optional]
    result: string,
    [@optional]
    reversed: bool,
    [@optional]
    role: string,
    [@optional]
    rotate: string,
    [@optional]
    rows: int,
    [@optional]
    rowSpan: int,
    [@optional]
    rx: string,
    [@optional]
    ry: string,
    [@optional]
    sandbox: string,
    [@optional]
    scale: string,
    [@optional]
    scope: string,
    [@optional]
    scoped: bool,
    [@optional]
    scrolling: string,
    [@optional]
    seed: string,
    [@optional]
    selected: bool,
    [@optional]
    shape: string,
    [@optional]
    shapeRendering: string,
    [@optional]
    size: int,
    [@optional]
    sizes: string,
    [@optional]
    slope: string,
    [@optional]
    spacing: string,
    [@optional]
    span: int,
    [@optional]
    specularConstant: string,
    [@optional]
    specularExponent: string,
    [@optional]
    speed: string,
    [@optional]
    spellCheck: bool,
    [@optional]
    spreadMethod: string,
    [@optional]
    src: string,
    [@optional]
    srcDoc: string,
    [@optional]
    srcLang: string,
    [@optional]
    srcSet: string,
    [@optional]
    start: int,
    [@optional]
    startOffset: string,
    [@optional]
    stdDeviation: string,
    [@optional]
    stemh: string,
    [@optional]
    stemv: string,
    [@optional]
    step: float,
    [@optional]
    stitchTiles: string,
    [@optional]
    stopColor: string,
    [@optional]
    stopOpacity: string,
    [@optional]
    strikethroughPosition: string,
    [@optional]
    strikethroughThickness: string,
    [@optional]
    stroke: string,
    [@optional]
    strokeDasharray: string,
    [@optional]
    strokeDashoffset: string,
    [@optional]
    strokeLinecap: string,
    [@optional]
    strokeLinejoin: string,
    [@optional]
    strokeMiterlimit: string,
    [@optional]
    strokeOpacity: string,
    [@optional]
    strokeWidth: string,
    [@optional]
    style: ReactDOM.Style.t,
    [@optional]
    summary: string,
    [@optional]
    suppressContentEditableWarning: bool,
    [@optional]
    surfaceScale: string,
    [@optional]
    systemLanguage: string,
    [@optional]
    tabIndex: int,
    [@optional]
    tableValues: string,
    [@optional]
    target: string,
    [@optional]
    targetX: string,
    [@optional]
    targetY: string,
    [@optional]
    textAnchor: string,
    [@optional]
    textDecoration: string,
    [@optional]
    textLength: string,
    [@optional]
    textRendering: string,
    [@optional]
    title: string,
    [@optional]
    to_: string,
    [@optional]
    transform: string,
    [@optional] [@bs.as "type"]
    type_: string,
    [@optional]
    typeof: string,
    [@optional]
    u1: string,
    [@optional]
    u2: string,
    [@optional]
    underlinePosition: string,
    [@optional]
    underlineThickness: string,
    [@optional]
    unicode: string,
    [@optional]
    unicodeBidi: string,
    [@optional]
    unicodeRange: string,
    [@optional]
    unitsPerEm: string,
    [@optional]
    useMap: string,
    [@optional]
    vAlphabetic: string,
    [@optional]
    value: string,
    [@optional]
    values: string,
    [@optional]
    vectorEffect: string,
    [@optional]
    version: string,
    [@optional]
    vertAdvX: string,
    [@optional]
    vertAdvY: string,
    [@optional]
    vertOriginX: string,
    [@optional]
    vertOriginY: string,
    [@optional]
    vHanging: string,
    [@optional]
    vIdeographic: string,
    [@optional]
    viewBox: string,
    [@optional]
    viewTarget: string,
    [@optional]
    visibility: string,
    [@optional]
    vMathematical: string,
    [@optional]
    vocab: string,
    [@optional]
    width: string,
    [@optional]
    widths: string,
    [@optional]
    wordSpacing: string,
    [@optional]
    wrap: string,
    [@optional]
    writingMode: string,
    [@optional]
    x: string,
    [@optional]
    x1: string,
    [@optional]
    x2: string,
    [@optional]
    xChannelSelector: string,
    [@optional]
    xHeight: string,
    [@optional]
    xlinkActuate: string,
    [@optional]
    xlinkArcrole: string,
    [@optional]
    xlinkHref: string,
    [@optional]
    xlinkRole: string,
    [@optional]
    xlinkShow: string,
    [@optional]
    xlinkTitle: string,
    [@optional]
    xlinkType: string,
    [@optional]
    xmlBase: string,
    [@optional]
    xmlLang: string,
    [@optional]
    xmlns: string,
    [@optional]
    xmlnsXlink: string,
    [@optional]
    xmlSpace: string,
    [@optional]
    y: string,
    [@optional]
    y1: string,
    [@optional]
    y2: string,
    [@optional]
    yChannelSelector: string,
    [@optional]
    z: string,
    [@optional]
    zoomAndPan: string,
    [@optional]
    onAbort: ReactEvent.Media.t => unit,
    [@optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@optional]
    onChange: ReactEvent.Form.t => unit,
    [@optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@optional]
    onEnded: ReactEvent.Media.t => unit,
    [@optional]
    onError: ReactEvent.Media.t => unit,
    [@optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@optional]
    onInput: ReactEvent.Form.t => unit,
    [@optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@optional]
    onPause: ReactEvent.Media.t => unit,
    [@optional]
    onPlay: ReactEvent.Media.t => unit,
    [@optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@optional]
    onProgress: ReactEvent.Media.t => unit,
    [@optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@optional]
    onScroll: ReactEvent.UI.t => unit,
    [@optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@optional]
    onStalled: ReactEvent.Media.t => unit,
    [@optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@optional]
    onWheel: ReactEvent.Wheel.t => unit,
    a: 'a,
  };
  [@bs.val] [@bs.module "react"]
  external createVariadicElement: (string, Js.t({..})) => React.element =
    "createElement";
  let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
  [@bs.val]
  external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
    "Object.assign";
  let getOrEmpty = str => {
    switch (str) {
    | Some(str) => " " ++ str
    | None => ""
    };
  };
  let styles = (~a as _, _) => CssJs.style(. cssRule);
  let make = (props: props('a)) => {
    let className = styles(~a=props.a, ()) ++ getOrEmpty(props.className);
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "a"));
    createVariadicElement("div", newProps);
  };
};
