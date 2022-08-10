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
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWheel: ReactEvent.Wheel.t => unit,
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
  let styles =
    CssJs.style(. [|
      CssJs.label("OneSingleProperty"),
      CssJs.display(`block),
    |]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module SingleQuoteStrings = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWheel: ReactEvent.Wheel.t => unit,
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
  let styles =
    CssJs.style(. [|
      CssJs.label("SingleQuoteStrings"),
      CssJs.display(`flex),
      CssJs.unsafe({js|justifyContent|js}, {js|center|js}),
    |]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("section", newProps);
  };
};
module MultiLineStrings = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWheel: ReactEvent.Wheel.t => unit,
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
  let styles =
    CssJs.style(. [|
      CssJs.label("MultiLineStrings"),
      CssJs.display(`flex),
      CssJs.unsafe({js|justifyContent|js}, {js|center|js}),
    |]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("section", newProps);
  };
};
module SelfClosingElement = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWheel: ReactEvent.Wheel.t => unit,
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
  let styles = CssJs.style(. [|CssJs.label("SelfClosingElement")|]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("input", newProps);
  };
};
module ArrayStatic = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWheel: ReactEvent.Wheel.t => unit,
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
  let styles =
    CssJs.style(. [|
      CssJs.label("ArrayStatic"),
      CssJs.display(`flex),
      CssJs.unsafe({js|justifyContent|js}, {js|center|js}),
    |]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
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
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWheel: ReactEvent.Wheel.t => unit,
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
  let styles =
    CssJs.style(. [|
      CssJs.label("StringInterpolation"),
      (CssJs.color(Theme.var): CssJs.rule),
      (CssJs.backgroundColor(black): CssJs.rule),
      (CssJs.borderColor(Theme.Border.black): CssJs.rule),
      CssJs.display(`block),
    |]);
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
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
  [@bs.deriving abstract]
  type makeProps('var) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
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
  let make = (props: makeProps('var)) => {
    let className =
      styles(~var=varGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "var"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module SelectorsMediaQueries = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWheel: ReactEvent.Wheel.t => unit,
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
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
let keyframe =
  CssJs.keyframes(. [|
    (0, [|CssJs.opacity(0.)|]),
    (100, [|CssJs.opacity(1.)|]),
  |]);
module ArrayDynamicComponent = {
  [@bs.deriving abstract]
  type makeProps('var) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
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
  let make = (props: makeProps('var)) => {
    let className =
      styles(~var=varGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "var"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module SequenceDynamicComponent = {
  [@bs.deriving abstract]
  type makeProps('size) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
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
  let make = (props: makeProps('size)) => {
    let className =
      styles(~size=sizeGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "size"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module DynamicComponentWithDefaultValue = {
  [@bs.deriving abstract]
  type makeProps('var) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWheel: ReactEvent.Wheel.t => unit,
    [@bs.optional]
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
  let make = (props: makeProps('var)) => {
    let className =
      styles(~var=?varGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "var"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
let width = "120px";
let orientation = "landscape";
module SelectorWithInterpolation = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWheel: ReactEvent.Wheel.t => unit,
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
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module MediaQueryCalc = {
  [@bs.deriving abstract]
  type makeProps = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWheel: ReactEvent.Wheel.t => unit,
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
  let make = (props: makeProps) => {
    let className = styles ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module DynamicComponentWithSequence = {
  [@bs.deriving abstract]
  type makeProps('variant) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
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
  let make = (props: makeProps('variant)) => {
    let className =
      styles(~variant=variantGet(props), ())
      ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "variant"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("button", newProps);
  };
};
module DynamicComponentWithArray = {
  [@bs.deriving abstract]
  type makeProps('color, 'size) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
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
  let make = (props: makeProps('color, 'size)) => {
    let className =
      styles(~color=colorGet(props), ~size=sizeGet(props), ())
      ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "color"));
    ignore(deleteProp(newProps, "size"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("button", newProps);
  };
};
let sharedStylesBetweenDynamicComponents = (color): CssJs.rule =>
  CssJs.color(color);
module DynamicCompnentWithLetIn = {
  [@bs.deriving abstract]
  type makeProps('color) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
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
  let make = (props: makeProps('color)) => {
    let className =
      styles(~color=colorGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "color"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
module DynamicCompnentWithIdent = {
  [@bs.deriving abstract]
  type makeProps('a) = {
    [@bs.optional]
    innerRef: ReactDOM.domRef,
    [@bs.optional]
    children: React.element,
    [@bs.optional]
    about: string,
    [@bs.optional]
    accentHeight: string,
    [@bs.optional]
    accept: string,
    [@bs.optional]
    acceptCharset: string,
    [@bs.optional]
    accessKey: string,
    [@bs.optional]
    accumulate: string,
    [@bs.optional]
    action: string,
    [@bs.optional]
    additive: string,
    [@bs.optional]
    alignmentBaseline: string,
    [@bs.optional]
    allowFullScreen: bool,
    [@bs.optional]
    allowReorder: string,
    [@bs.optional]
    alphabetic: string,
    [@bs.optional]
    alt: string,
    [@bs.optional]
    amplitude: string,
    [@bs.optional]
    arabicForm: string,
    [@bs.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: string,
    [@bs.optional] [@bs.as "aria-atomic"]
    ariaAtomic: bool,
    [@bs.optional] [@bs.as "aria-busy"]
    ariaBusy: bool,
    [@bs.optional] [@bs.as "aria-colcount"]
    ariaColcount: int,
    [@bs.optional] [@bs.as "aria-colindex"]
    ariaColindex: int,
    [@bs.optional] [@bs.as "aria-colspan"]
    ariaColspan: int,
    [@bs.optional] [@bs.as "aria-controls"]
    ariaControls: string,
    [@bs.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: string,
    [@bs.optional] [@bs.as "aria-details"]
    ariaDetails: string,
    [@bs.optional] [@bs.as "aria-disabled"]
    ariaDisabled: bool,
    [@bs.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: string,
    [@bs.optional] [@bs.as "aria-expanded"]
    ariaExpanded: bool,
    [@bs.optional] [@bs.as "aria-flowto"]
    ariaFlowto: string,
    [@bs.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: bool,
    [@bs.optional] [@bs.as "aria-hidden"]
    ariaHidden: bool,
    [@bs.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: string,
    [@bs.optional] [@bs.as "aria-label"]
    ariaLabel: string,
    [@bs.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: string,
    [@bs.optional] [@bs.as "aria-level"]
    ariaLevel: int,
    [@bs.optional] [@bs.as "aria-modal"]
    ariaModal: bool,
    [@bs.optional] [@bs.as "aria-multiline"]
    ariaMultiline: bool,
    [@bs.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: bool,
    [@bs.optional] [@bs.as "aria-owns"]
    ariaOwns: string,
    [@bs.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: string,
    [@bs.optional] [@bs.as "aria-posinset"]
    ariaPosinset: int,
    [@bs.optional] [@bs.as "aria-readonly"]
    ariaReadonly: bool,
    [@bs.optional] [@bs.as "aria-relevant"]
    ariaRelevant: string,
    [@bs.optional] [@bs.as "aria-required"]
    ariaRequired: bool,
    [@bs.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: string,
    [@bs.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: int,
    [@bs.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: int,
    [@bs.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: int,
    [@bs.optional] [@bs.as "aria-selected"]
    ariaSelected: bool,
    [@bs.optional] [@bs.as "aria-setsize"]
    ariaSetsize: int,
    [@bs.optional] [@bs.as "aria-sort"]
    ariaSort: string,
    [@bs.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: float,
    [@bs.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: float,
    [@bs.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: float,
    [@bs.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: string,
    [@bs.optional]
    ascent: string,
    [@bs.optional]
    async: bool,
    [@bs.optional]
    attributeName: string,
    [@bs.optional]
    attributeType: string,
    [@bs.optional]
    autoComplete: string,
    [@bs.optional]
    autoFocus: bool,
    [@bs.optional]
    autoPlay: bool,
    [@bs.optional]
    autoReverse: string,
    [@bs.optional]
    azimuth: string,
    [@bs.optional]
    baseFrequency: string,
    [@bs.optional]
    baselineShift: string,
    [@bs.optional]
    baseProfile: string,
    [@bs.optional]
    bbox: string,
    [@bs.optional]
    begin_: string,
    [@bs.optional]
    bias: string,
    [@bs.optional]
    by: string,
    [@bs.optional]
    calcMode: string,
    [@bs.optional]
    capHeight: string,
    [@bs.optional]
    challenge: string,
    [@bs.optional]
    charSet: string,
    [@bs.optional]
    checked: bool,
    [@bs.optional]
    cite: string,
    [@bs.optional]
    className: string,
    [@bs.optional]
    clip: string,
    [@bs.optional]
    clipPath: string,
    [@bs.optional]
    clipPathUnits: string,
    [@bs.optional]
    clipRule: string,
    [@bs.optional]
    colorInterpolation: string,
    [@bs.optional]
    colorInterpolationFilters: string,
    [@bs.optional]
    colorProfile: string,
    [@bs.optional]
    colorRendering: string,
    [@bs.optional]
    cols: int,
    [@bs.optional]
    colSpan: int,
    [@bs.optional]
    content: string,
    [@bs.optional]
    contentEditable: bool,
    [@bs.optional]
    contentScriptType: string,
    [@bs.optional]
    contentStyleType: string,
    [@bs.optional]
    contextMenu: string,
    [@bs.optional]
    controls: bool,
    [@bs.optional]
    coords: string,
    [@bs.optional]
    crossorigin: bool,
    [@bs.optional]
    cursor: string,
    [@bs.optional]
    cx: string,
    [@bs.optional]
    cy: string,
    [@bs.optional]
    d: string,
    [@bs.optional]
    data: string,
    [@bs.optional]
    datatype: string,
    [@bs.optional]
    dateTime: string,
    [@bs.optional]
    decelerate: string,
    [@bs.optional]
    default: bool,
    [@bs.optional]
    defaultChecked: bool,
    [@bs.optional]
    defaultValue: string,
    [@bs.optional]
    defer: bool,
    [@bs.optional]
    descent: string,
    [@bs.optional]
    diffuseConstant: string,
    [@bs.optional]
    dir: string,
    [@bs.optional]
    direction: string,
    [@bs.optional]
    disabled: bool,
    [@bs.optional]
    display: string,
    [@bs.optional]
    divisor: string,
    [@bs.optional]
    dominantBaseline: string,
    [@bs.optional]
    download: string,
    [@bs.optional]
    draggable: bool,
    [@bs.optional]
    dur: string,
    [@bs.optional]
    dx: string,
    [@bs.optional]
    dy: string,
    [@bs.optional]
    edgeMode: string,
    [@bs.optional]
    elevation: string,
    [@bs.optional]
    enableBackground: string,
    [@bs.optional]
    encType: string,
    [@bs.optional]
    end_: string,
    [@bs.optional]
    exponent: string,
    [@bs.optional]
    externalResourcesRequired: string,
    [@bs.optional]
    fill: string,
    [@bs.optional]
    fillOpacity: string,
    [@bs.optional]
    fillRule: string,
    [@bs.optional]
    filter: string,
    [@bs.optional]
    filterRes: string,
    [@bs.optional]
    filterUnits: string,
    [@bs.optional]
    floodColor: string,
    [@bs.optional]
    floodOpacity: string,
    [@bs.optional]
    focusable: string,
    [@bs.optional]
    fomat: string,
    [@bs.optional]
    fontFamily: string,
    [@bs.optional]
    fontSize: string,
    [@bs.optional]
    fontSizeAdjust: string,
    [@bs.optional]
    fontStretch: string,
    [@bs.optional]
    fontStyle: string,
    [@bs.optional]
    fontVariant: string,
    [@bs.optional]
    fontWeight: string,
    [@bs.optional]
    form: string,
    [@bs.optional]
    formAction: string,
    [@bs.optional]
    formMethod: string,
    [@bs.optional]
    formTarget: string,
    [@bs.optional]
    from: string,
    [@bs.optional]
    fx: string,
    [@bs.optional]
    fy: string,
    [@bs.optional]
    g1: string,
    [@bs.optional]
    g2: string,
    [@bs.optional]
    glyphName: string,
    [@bs.optional]
    glyphOrientationHorizontal: string,
    [@bs.optional]
    glyphOrientationVertical: string,
    [@bs.optional]
    glyphRef: string,
    [@bs.optional]
    gradientTransform: string,
    [@bs.optional]
    gradientUnits: string,
    [@bs.optional]
    hanging: string,
    [@bs.optional]
    headers: string,
    [@bs.optional]
    height: string,
    [@bs.optional]
    hidden: bool,
    [@bs.optional]
    high: int,
    [@bs.optional]
    horizAdvX: string,
    [@bs.optional]
    horizOriginX: string,
    [@bs.optional]
    href: string,
    [@bs.optional]
    hrefLang: string,
    [@bs.optional]
    htmlFor: string,
    [@bs.optional]
    httpEquiv: string,
    [@bs.optional]
    icon: string,
    [@bs.optional]
    id: string,
    [@bs.optional]
    ideographic: string,
    [@bs.optional]
    imageRendering: string,
    [@bs.optional]
    in_: string,
    [@bs.optional]
    in2: string,
    [@bs.optional]
    inlist: string,
    [@bs.optional]
    inputMode: string,
    [@bs.optional]
    integrity: string,
    [@bs.optional]
    intercept: string,
    [@bs.optional]
    itemID: string,
    [@bs.optional]
    itemProp: string,
    [@bs.optional]
    itemRef: string,
    [@bs.optional]
    itemScope: bool,
    [@bs.optional]
    itemType: string,
    [@bs.optional]
    k: string,
    [@bs.optional]
    k1: string,
    [@bs.optional]
    k2: string,
    [@bs.optional]
    k3: string,
    [@bs.optional]
    k4: string,
    [@bs.optional]
    kernelMatrix: string,
    [@bs.optional]
    kernelUnitLength: string,
    [@bs.optional]
    kerning: string,
    [@bs.optional]
    key: string,
    [@bs.optional]
    keyPoints: string,
    [@bs.optional]
    keySplines: string,
    [@bs.optional]
    keyTimes: string,
    [@bs.optional]
    keyType: string,
    [@bs.optional]
    kind: string,
    [@bs.optional]
    label: string,
    [@bs.optional]
    lang: string,
    [@bs.optional]
    lengthAdjust: string,
    [@bs.optional]
    letterSpacing: string,
    [@bs.optional]
    lightingColor: string,
    [@bs.optional]
    limitingConeAngle: string,
    [@bs.optional]
    list: string,
    [@bs.optional]
    local: string,
    [@bs.optional]
    loop: bool,
    [@bs.optional]
    low: int,
    [@bs.optional]
    manifest: string,
    [@bs.optional]
    markerEnd: string,
    [@bs.optional]
    markerHeight: string,
    [@bs.optional]
    markerMid: string,
    [@bs.optional]
    markerStart: string,
    [@bs.optional]
    markerUnits: string,
    [@bs.optional]
    markerWidth: string,
    [@bs.optional]
    mask: string,
    [@bs.optional]
    maskContentUnits: string,
    [@bs.optional]
    maskUnits: string,
    [@bs.optional]
    mathematical: string,
    [@bs.optional]
    max: string,
    [@bs.optional]
    maxLength: int,
    [@bs.optional]
    media: string,
    [@bs.optional]
    mediaGroup: string,
    [@bs.optional]
    min: int,
    [@bs.optional]
    minLength: int,
    [@bs.optional]
    mode: string,
    [@bs.optional]
    multiple: bool,
    [@bs.optional]
    muted: bool,
    [@bs.optional]
    name: string,
    [@bs.optional]
    nonce: string,
    [@bs.optional]
    noValidate: bool,
    [@bs.optional]
    numOctaves: string,
    [@bs.optional]
    offset: string,
    [@bs.optional]
    opacity: string,
    [@bs.optional]
    open_: bool,
    [@bs.optional]
    operator: string,
    [@bs.optional]
    optimum: int,
    [@bs.optional]
    order: string,
    [@bs.optional]
    orient: string,
    [@bs.optional]
    orientation: string,
    [@bs.optional]
    origin: string,
    [@bs.optional]
    overflow: string,
    [@bs.optional]
    overflowX: string,
    [@bs.optional]
    overflowY: string,
    [@bs.optional]
    overlinePosition: string,
    [@bs.optional]
    overlineThickness: string,
    [@bs.optional]
    paintOrder: string,
    [@bs.optional]
    panose1: string,
    [@bs.optional]
    pathLength: string,
    [@bs.optional]
    pattern: string,
    [@bs.optional]
    patternContentUnits: string,
    [@bs.optional]
    patternTransform: string,
    [@bs.optional]
    patternUnits: string,
    [@bs.optional]
    placeholder: string,
    [@bs.optional]
    pointerEvents: string,
    [@bs.optional]
    points: string,
    [@bs.optional]
    pointsAtX: string,
    [@bs.optional]
    pointsAtY: string,
    [@bs.optional]
    pointsAtZ: string,
    [@bs.optional]
    poster: string,
    [@bs.optional]
    prefix: string,
    [@bs.optional]
    preload: string,
    [@bs.optional]
    preserveAlpha: string,
    [@bs.optional]
    preserveAspectRatio: string,
    [@bs.optional]
    primitiveUnits: string,
    [@bs.optional]
    property: string,
    [@bs.optional]
    r: string,
    [@bs.optional]
    radioGroup: string,
    [@bs.optional]
    radius: string,
    [@bs.optional]
    readOnly: bool,
    [@bs.optional]
    refX: string,
    [@bs.optional]
    refY: string,
    [@bs.optional]
    rel: string,
    [@bs.optional]
    renderingIntent: string,
    [@bs.optional]
    repeatCount: string,
    [@bs.optional]
    repeatDur: string,
    [@bs.optional]
    required: bool,
    [@bs.optional]
    requiredExtensions: string,
    [@bs.optional]
    requiredFeatures: string,
    [@bs.optional]
    resource: string,
    [@bs.optional]
    restart: string,
    [@bs.optional]
    result: string,
    [@bs.optional]
    reversed: bool,
    [@bs.optional]
    role: string,
    [@bs.optional]
    rotate: string,
    [@bs.optional]
    rows: int,
    [@bs.optional]
    rowSpan: int,
    [@bs.optional]
    rx: string,
    [@bs.optional]
    ry: string,
    [@bs.optional]
    sandbox: string,
    [@bs.optional]
    scale: string,
    [@bs.optional]
    scope: string,
    [@bs.optional]
    scoped: bool,
    [@bs.optional]
    scrolling: string,
    [@bs.optional]
    seed: string,
    [@bs.optional]
    selected: bool,
    [@bs.optional]
    shape: string,
    [@bs.optional]
    shapeRendering: string,
    [@bs.optional]
    size: int,
    [@bs.optional]
    sizes: string,
    [@bs.optional]
    slope: string,
    [@bs.optional]
    spacing: string,
    [@bs.optional]
    span: int,
    [@bs.optional]
    specularConstant: string,
    [@bs.optional]
    specularExponent: string,
    [@bs.optional]
    speed: string,
    [@bs.optional]
    spellCheck: bool,
    [@bs.optional]
    spreadMethod: string,
    [@bs.optional]
    src: string,
    [@bs.optional]
    srcDoc: string,
    [@bs.optional]
    srcLang: string,
    [@bs.optional]
    srcSet: string,
    [@bs.optional]
    start: int,
    [@bs.optional]
    startOffset: string,
    [@bs.optional]
    stdDeviation: string,
    [@bs.optional]
    stemh: string,
    [@bs.optional]
    stemv: string,
    [@bs.optional]
    step: float,
    [@bs.optional]
    stitchTiles: string,
    [@bs.optional]
    stopColor: string,
    [@bs.optional]
    stopOpacity: string,
    [@bs.optional]
    strikethroughPosition: string,
    [@bs.optional]
    strikethroughThickness: string,
    [@bs.optional]
    stroke: string,
    [@bs.optional]
    strokeDasharray: string,
    [@bs.optional]
    strokeDashoffset: string,
    [@bs.optional]
    strokeLinecap: string,
    [@bs.optional]
    strokeLinejoin: string,
    [@bs.optional]
    strokeMiterlimit: string,
    [@bs.optional]
    strokeOpacity: string,
    [@bs.optional]
    strokeWidth: string,
    [@bs.optional]
    style: ReactDOM.Style.t,
    [@bs.optional]
    summary: string,
    [@bs.optional]
    suppressContentEditableWarning: bool,
    [@bs.optional]
    surfaceScale: string,
    [@bs.optional]
    systemLanguage: string,
    [@bs.optional]
    tabIndex: int,
    [@bs.optional]
    tableValues: string,
    [@bs.optional]
    target: string,
    [@bs.optional]
    targetX: string,
    [@bs.optional]
    targetY: string,
    [@bs.optional]
    textAnchor: string,
    [@bs.optional]
    textDecoration: string,
    [@bs.optional]
    textLength: string,
    [@bs.optional]
    textRendering: string,
    [@bs.optional]
    title: string,
    [@bs.optional]
    to_: string,
    [@bs.optional]
    transform: string,
    [@bs.optional] [@bs.as "type"]
    type_: string,
    [@bs.optional]
    typeof: string,
    [@bs.optional]
    u1: string,
    [@bs.optional]
    u2: string,
    [@bs.optional]
    underlinePosition: string,
    [@bs.optional]
    underlineThickness: string,
    [@bs.optional]
    unicode: string,
    [@bs.optional]
    unicodeBidi: string,
    [@bs.optional]
    unicodeRange: string,
    [@bs.optional]
    unitsPerEm: string,
    [@bs.optional]
    useMap: string,
    [@bs.optional]
    vAlphabetic: string,
    [@bs.optional]
    value: string,
    [@bs.optional]
    values: string,
    [@bs.optional]
    vectorEffect: string,
    [@bs.optional]
    version: string,
    [@bs.optional]
    vertAdvX: string,
    [@bs.optional]
    vertAdvY: string,
    [@bs.optional]
    vertOriginX: string,
    [@bs.optional]
    vertOriginY: string,
    [@bs.optional]
    vHanging: string,
    [@bs.optional]
    vIdeographic: string,
    [@bs.optional]
    viewBox: string,
    [@bs.optional]
    viewTarget: string,
    [@bs.optional]
    visibility: string,
    [@bs.optional]
    vMathematical: string,
    [@bs.optional]
    vocab: string,
    [@bs.optional]
    width: string,
    [@bs.optional]
    widths: string,
    [@bs.optional]
    wordSpacing: string,
    [@bs.optional]
    wrap: string,
    [@bs.optional]
    writingMode: string,
    [@bs.optional]
    x: string,
    [@bs.optional]
    x1: string,
    [@bs.optional]
    x2: string,
    [@bs.optional]
    xChannelSelector: string,
    [@bs.optional]
    xHeight: string,
    [@bs.optional]
    xlinkActuate: string,
    [@bs.optional]
    xlinkArcrole: string,
    [@bs.optional]
    xlinkHref: string,
    [@bs.optional]
    xlinkRole: string,
    [@bs.optional]
    xlinkShow: string,
    [@bs.optional]
    xlinkTitle: string,
    [@bs.optional]
    xlinkType: string,
    [@bs.optional]
    xmlBase: string,
    [@bs.optional]
    xmlLang: string,
    [@bs.optional]
    xmlns: string,
    [@bs.optional]
    xmlnsXlink: string,
    [@bs.optional]
    xmlSpace: string,
    [@bs.optional]
    y: string,
    [@bs.optional]
    y1: string,
    [@bs.optional]
    y2: string,
    [@bs.optional]
    yChannelSelector: string,
    [@bs.optional]
    z: string,
    [@bs.optional]
    zoomAndPan: string,
    [@bs.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@bs.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@bs.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@bs.optional]
    onChange: ReactEvent.Form.t => unit,
    [@bs.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@bs.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@bs.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@bs.optional]
    onError: ReactEvent.Media.t => unit,
    [@bs.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@bs.optional]
    onInput: ReactEvent.Form.t => unit,
    [@bs.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@bs.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@bs.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@bs.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@bs.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@bs.optional]
    onPause: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@bs.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@bs.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@bs.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@bs.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@bs.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@bs.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@bs.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@bs.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@bs.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@bs.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@bs.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@bs.optional]
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
  let make = (props: makeProps('a)) => {
    let className =
      styles(~a=aGet(props), ()) ++ getOrEmpty(classNameGet(props));
    let stylesObject = {"className": className, "ref": innerRefGet(props)};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "a"));
    ignore(deleteProp(newProps, "innerRef"));
    createVariadicElement("div", newProps);
  };
};
