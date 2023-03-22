module DynamicComponent = {
  type props('var) = {
    [@res.optional]
    ref: ReactDOM.domRef,
    [@res.optional]
    children: React.element,
    [@res.optional]
    about: option(string),
    [@res.optional]
    accentHeight: option(string),
    [@res.optional]
    accept: option(string),
    [@res.optional]
    acceptCharset: option(string),
    [@res.optional]
    accessKey: option(string),
    [@res.optional]
    accumulate: option(string),
    [@res.optional]
    action: option(string),
    [@res.optional]
    additive: option(string),
    [@res.optional]
    alignmentBaseline: option(string),
    [@res.optional]
    allowFullScreen: option(bool),
    [@res.optional]
    allowReorder: option(string),
    [@res.optional]
    alphabetic: option(string),
    [@res.optional]
    alt: option(string),
    [@res.optional]
    amplitude: option(string),
    [@res.optional]
    arabicForm: option(string),
    [@res.optional] [@bs.as "aria-activedescendant"]
    ariaActivedescendant: option(string),
    [@res.optional] [@bs.as "aria-atomic"]
    ariaAtomic: option(bool),
    [@res.optional] [@bs.as "aria-busy"]
    ariaBusy: option(bool),
    [@res.optional] [@bs.as "aria-colcount"]
    ariaColcount: option(int),
    [@res.optional] [@bs.as "aria-colindex"]
    ariaColindex: option(int),
    [@res.optional] [@bs.as "aria-colspan"]
    ariaColspan: option(int),
    [@res.optional] [@bs.as "aria-controls"]
    ariaControls: option(string),
    [@res.optional] [@bs.as "aria-describedby"]
    ariaDescribedby: option(string),
    [@res.optional] [@bs.as "aria-details"]
    ariaDetails: option(string),
    [@res.optional] [@bs.as "aria-disabled"]
    ariaDisabled: option(bool),
    [@res.optional] [@bs.as "aria-errormessage"]
    ariaErrormessage: option(string),
    [@res.optional] [@bs.as "aria-expanded"]
    ariaExpanded: option(bool),
    [@res.optional] [@bs.as "aria-flowto"]
    ariaFlowto: option(string),
    [@res.optional] [@bs.as "aria-grabbed"]
    ariaGrabbed: option(bool),
    [@res.optional] [@bs.as "aria-hidden"]
    ariaHidden: option(bool),
    [@res.optional] [@bs.as "aria-keyshortcuts"]
    ariaKeyshortcuts: option(string),
    [@res.optional] [@bs.as "aria-label"]
    ariaLabel: option(string),
    [@res.optional] [@bs.as "aria-labelledby"]
    ariaLabelledby: option(string),
    [@res.optional] [@bs.as "aria-level"]
    ariaLevel: option(int),
    [@res.optional] [@bs.as "aria-modal"]
    ariaModal: option(bool),
    [@res.optional] [@bs.as "aria-multiline"]
    ariaMultiline: option(bool),
    [@res.optional] [@bs.as "aria-multiselectable"]
    ariaMultiselectable: option(bool),
    [@res.optional] [@bs.as "aria-owns"]
    ariaOwns: option(string),
    [@res.optional] [@bs.as "aria-placeholder"]
    ariaPlaceholder: option(string),
    [@res.optional] [@bs.as "aria-posinset"]
    ariaPosinset: option(int),
    [@res.optional] [@bs.as "aria-readonly"]
    ariaReadonly: option(bool),
    [@res.optional] [@bs.as "aria-relevant"]
    ariaRelevant: option(string),
    [@res.optional] [@bs.as "aria-required"]
    ariaRequired: option(bool),
    [@res.optional] [@bs.as "aria-roledescription"]
    ariaRoledescription: option(string),
    [@res.optional] [@bs.as "aria-rowcount"]
    ariaRowcount: option(int),
    [@res.optional] [@bs.as "aria-rowindex"]
    ariaRowindex: option(int),
    [@res.optional] [@bs.as "aria-rowspan"]
    ariaRowspan: option(int),
    [@res.optional] [@bs.as "aria-selected"]
    ariaSelected: option(bool),
    [@res.optional] [@bs.as "aria-setsize"]
    ariaSetsize: option(int),
    [@res.optional] [@bs.as "aria-sort"]
    ariaSort: option(string),
    [@res.optional] [@bs.as "aria-valuemax"]
    ariaValuemax: option(float),
    [@res.optional] [@bs.as "aria-valuemin"]
    ariaValuemin: option(float),
    [@res.optional] [@bs.as "aria-valuenow"]
    ariaValuenow: option(float),
    [@res.optional] [@bs.as "aria-valuetext"]
    ariaValuetext: option(string),
    [@res.optional]
    ascent: option(string),
    [@res.optional]
    async: option(bool),
    [@res.optional]
    attributeName: option(string),
    [@res.optional]
    attributeType: option(string),
    [@res.optional]
    autoComplete: option(string),
    [@res.optional]
    autoFocus: option(bool),
    [@res.optional]
    autoPlay: option(bool),
    [@res.optional]
    autoReverse: option(string),
    [@res.optional]
    azimuth: option(string),
    [@res.optional]
    baseFrequency: option(string),
    [@res.optional]
    baselineShift: option(string),
    [@res.optional]
    baseProfile: option(string),
    [@res.optional]
    bbox: option(string),
    [@res.optional]
    begin_: option(string),
    [@res.optional]
    bias: option(string),
    [@res.optional]
    by: option(string),
    [@res.optional]
    calcMode: option(string),
    [@res.optional]
    capHeight: option(string),
    [@res.optional]
    challenge: option(string),
    [@res.optional]
    charSet: option(string),
    [@res.optional]
    checked: option(bool),
    [@res.optional]
    cite: option(string),
    [@res.optional]
    className: option(string),
    [@res.optional]
    clip: option(string),
    [@res.optional]
    clipPath: option(string),
    [@res.optional]
    clipPathUnits: option(string),
    [@res.optional]
    clipRule: option(string),
    [@res.optional]
    colorInterpolation: option(string),
    [@res.optional]
    colorInterpolationFilters: option(string),
    [@res.optional]
    colorProfile: option(string),
    [@res.optional]
    colorRendering: option(string),
    [@res.optional]
    cols: option(int),
    [@res.optional]
    colSpan: option(int),
    [@res.optional]
    content: option(string),
    [@res.optional]
    contentEditable: option(bool),
    [@res.optional]
    contentScriptType: option(string),
    [@res.optional]
    contentStyleType: option(string),
    [@res.optional]
    contextMenu: option(string),
    [@res.optional]
    controls: option(bool),
    [@res.optional]
    coords: option(string),
    [@res.optional]
    crossorigin: option(bool),
    [@res.optional]
    cursor: option(string),
    [@res.optional]
    cx: option(string),
    [@res.optional]
    cy: option(string),
    [@res.optional]
    d: option(string),
    [@res.optional]
    data: option(string),
    [@res.optional]
    datatype: option(string),
    [@res.optional]
    dateTime: option(string),
    [@res.optional]
    decelerate: option(string),
    [@res.optional]
    default: option(bool),
    [@res.optional]
    defaultChecked: option(bool),
    [@res.optional]
    defaultValue: option(string),
    [@res.optional]
    defer: option(bool),
    [@res.optional]
    descent: option(string),
    [@res.optional]
    diffuseConstant: option(string),
    [@res.optional]
    dir: option(string),
    [@res.optional]
    direction: option(string),
    [@res.optional]
    disabled: option(bool),
    [@res.optional]
    display: option(string),
    [@res.optional]
    divisor: option(string),
    [@res.optional]
    dominantBaseline: option(string),
    [@res.optional]
    download: option(string),
    [@res.optional]
    draggable: option(bool),
    [@res.optional]
    dur: option(string),
    [@res.optional]
    dx: option(string),
    [@res.optional]
    dy: option(string),
    [@res.optional]
    edgeMode: option(string),
    [@res.optional]
    elevation: option(string),
    [@res.optional]
    enableBackground: option(string),
    [@res.optional]
    encType: option(string),
    [@res.optional]
    end_: option(string),
    [@res.optional]
    exponent: option(string),
    [@res.optional]
    externalResourcesRequired: option(string),
    [@res.optional]
    fill: option(string),
    [@res.optional]
    fillOpacity: option(string),
    [@res.optional]
    fillRule: option(string),
    [@res.optional]
    filter: option(string),
    [@res.optional]
    filterRes: option(string),
    [@res.optional]
    filterUnits: option(string),
    [@res.optional]
    floodColor: option(string),
    [@res.optional]
    floodOpacity: option(string),
    [@res.optional]
    focusable: option(string),
    [@res.optional]
    fomat: option(string),
    [@res.optional]
    fontFamily: option(string),
    [@res.optional]
    fontSize: option(string),
    [@res.optional]
    fontSizeAdjust: option(string),
    [@res.optional]
    fontStretch: option(string),
    [@res.optional]
    fontStyle: option(string),
    [@res.optional]
    fontVariant: option(string),
    [@res.optional]
    fontWeight: option(string),
    [@res.optional]
    form: option(string),
    [@res.optional]
    formAction: option(string),
    [@res.optional]
    formMethod: option(string),
    [@res.optional]
    formTarget: option(string),
    [@res.optional]
    from: option(string),
    [@res.optional]
    fx: option(string),
    [@res.optional]
    fy: option(string),
    [@res.optional]
    g1: option(string),
    [@res.optional]
    g2: option(string),
    [@res.optional]
    glyphName: option(string),
    [@res.optional]
    glyphOrientationHorizontal: option(string),
    [@res.optional]
    glyphOrientationVertical: option(string),
    [@res.optional]
    glyphRef: option(string),
    [@res.optional]
    gradientTransform: option(string),
    [@res.optional]
    gradientUnits: option(string),
    [@res.optional]
    hanging: option(string),
    [@res.optional]
    headers: option(string),
    [@res.optional]
    height: option(string),
    [@res.optional]
    hidden: option(bool),
    [@res.optional]
    high: option(int),
    [@res.optional]
    horizAdvX: option(string),
    [@res.optional]
    horizOriginX: option(string),
    [@res.optional]
    href: option(string),
    [@res.optional]
    hrefLang: option(string),
    [@res.optional]
    htmlFor: option(string),
    [@res.optional]
    httpEquiv: option(string),
    [@res.optional]
    icon: option(string),
    [@res.optional]
    id: option(string),
    [@res.optional]
    ideographic: option(string),
    [@res.optional]
    imageRendering: option(string),
    [@res.optional]
    in_: option(string),
    [@res.optional]
    in2: option(string),
    [@res.optional]
    inlist: option(string),
    [@res.optional]
    inputMode: option(string),
    [@res.optional]
    integrity: option(string),
    [@res.optional]
    intercept: option(string),
    [@res.optional]
    itemID: option(string),
    [@res.optional]
    itemProp: option(string),
    [@res.optional]
    itemRef: option(string),
    [@res.optional]
    itemScope: option(bool),
    [@res.optional]
    itemType: option(string),
    [@res.optional]
    k: option(string),
    [@res.optional]
    k1: option(string),
    [@res.optional]
    k2: option(string),
    [@res.optional]
    k3: option(string),
    [@res.optional]
    k4: option(string),
    [@res.optional]
    kernelMatrix: option(string),
    [@res.optional]
    kernelUnitLength: option(string),
    [@res.optional]
    kerning: option(string),
    [@res.optional]
    key: option(string),
    [@res.optional]
    keyPoints: option(string),
    [@res.optional]
    keySplines: option(string),
    [@res.optional]
    keyTimes: option(string),
    [@res.optional]
    keyType: option(string),
    [@res.optional]
    kind: option(string),
    [@res.optional]
    label: option(string),
    [@res.optional]
    lang: option(string),
    [@res.optional]
    lengthAdjust: option(string),
    [@res.optional]
    letterSpacing: option(string),
    [@res.optional]
    lightingColor: option(string),
    [@res.optional]
    limitingConeAngle: option(string),
    [@res.optional]
    list: option(string),
    [@res.optional]
    local: option(string),
    [@res.optional]
    loop: option(bool),
    [@res.optional]
    low: option(int),
    [@res.optional]
    manifest: option(string),
    [@res.optional]
    markerEnd: option(string),
    [@res.optional]
    markerHeight: option(string),
    [@res.optional]
    markerMid: option(string),
    [@res.optional]
    markerStart: option(string),
    [@res.optional]
    markerUnits: option(string),
    [@res.optional]
    markerWidth: option(string),
    [@res.optional]
    mask: option(string),
    [@res.optional]
    maskContentUnits: option(string),
    [@res.optional]
    maskUnits: option(string),
    [@res.optional]
    mathematical: option(string),
    [@res.optional]
    max: option(string),
    [@res.optional]
    maxLength: option(int),
    [@res.optional]
    media: option(string),
    [@res.optional]
    mediaGroup: option(string),
    [@res.optional]
    min: option(int),
    [@res.optional]
    minLength: option(int),
    [@res.optional]
    mode: option(string),
    [@res.optional]
    multiple: option(bool),
    [@res.optional]
    muted: option(bool),
    [@res.optional]
    name: option(string),
    [@res.optional]
    nonce: option(string),
    [@res.optional]
    noValidate: option(bool),
    [@res.optional]
    numOctaves: option(string),
    [@res.optional]
    offset: option(string),
    [@res.optional]
    opacity: option(string),
    [@res.optional]
    open_: option(bool),
    [@res.optional]
    operator: option(string),
    [@res.optional]
    optimum: option(int),
    [@res.optional]
    order: option(string),
    [@res.optional]
    orient: option(string),
    [@res.optional]
    orientation: option(string),
    [@res.optional]
    origin: option(string),
    [@res.optional]
    overflow: option(string),
    [@res.optional]
    overflowX: option(string),
    [@res.optional]
    overflowY: option(string),
    [@res.optional]
    overlinePosition: option(string),
    [@res.optional]
    overlineThickness: option(string),
    [@res.optional]
    paintOrder: option(string),
    [@res.optional]
    panose1: option(string),
    [@res.optional]
    pathLength: option(string),
    [@res.optional]
    pattern: option(string),
    [@res.optional]
    patternContentUnits: option(string),
    [@res.optional]
    patternTransform: option(string),
    [@res.optional]
    patternUnits: option(string),
    [@res.optional]
    placeholder: option(string),
    [@res.optional]
    pointerEvents: option(string),
    [@res.optional]
    points: option(string),
    [@res.optional]
    pointsAtX: option(string),
    [@res.optional]
    pointsAtY: option(string),
    [@res.optional]
    pointsAtZ: option(string),
    [@res.optional]
    poster: option(string),
    [@res.optional]
    prefix: option(string),
    [@res.optional]
    preload: option(string),
    [@res.optional]
    preserveAlpha: option(string),
    [@res.optional]
    preserveAspectRatio: option(string),
    [@res.optional]
    primitiveUnits: option(string),
    [@res.optional]
    property: option(string),
    [@res.optional]
    r: option(string),
    [@res.optional]
    radioGroup: option(string),
    [@res.optional]
    radius: option(string),
    [@res.optional]
    readOnly: option(bool),
    [@res.optional]
    refX: option(string),
    [@res.optional]
    refY: option(string),
    [@res.optional]
    rel: option(string),
    [@res.optional]
    renderingIntent: option(string),
    [@res.optional]
    repeatCount: option(string),
    [@res.optional]
    repeatDur: option(string),
    [@res.optional]
    required: option(bool),
    [@res.optional]
    requiredExtensions: option(string),
    [@res.optional]
    requiredFeatures: option(string),
    [@res.optional]
    resource: option(string),
    [@res.optional]
    restart: option(string),
    [@res.optional]
    result: option(string),
    [@res.optional]
    reversed: option(bool),
    [@res.optional]
    role: option(string),
    [@res.optional]
    rotate: option(string),
    [@res.optional]
    rows: option(int),
    [@res.optional]
    rowSpan: option(int),
    [@res.optional]
    rx: option(string),
    [@res.optional]
    ry: option(string),
    [@res.optional]
    sandbox: option(string),
    [@res.optional]
    scale: option(string),
    [@res.optional]
    scope: option(string),
    [@res.optional]
    scoped: option(bool),
    [@res.optional]
    scrolling: option(string),
    [@res.optional]
    seed: option(string),
    [@res.optional]
    selected: option(bool),
    [@res.optional]
    shape: option(string),
    [@res.optional]
    shapeRendering: option(string),
    [@res.optional]
    size: option(int),
    [@res.optional]
    sizes: option(string),
    [@res.optional]
    slope: option(string),
    [@res.optional]
    spacing: option(string),
    [@res.optional]
    span: option(int),
    [@res.optional]
    specularConstant: option(string),
    [@res.optional]
    specularExponent: option(string),
    [@res.optional]
    speed: option(string),
    [@res.optional]
    spellCheck: option(bool),
    [@res.optional]
    spreadMethod: option(string),
    [@res.optional]
    src: option(string),
    [@res.optional]
    srcDoc: option(string),
    [@res.optional]
    srcLang: option(string),
    [@res.optional]
    srcSet: option(string),
    [@res.optional]
    start: option(int),
    [@res.optional]
    startOffset: option(string),
    [@res.optional]
    stdDeviation: option(string),
    [@res.optional]
    stemh: option(string),
    [@res.optional]
    stemv: option(string),
    [@res.optional]
    step: option(float),
    [@res.optional]
    stitchTiles: option(string),
    [@res.optional]
    stopColor: option(string),
    [@res.optional]
    stopOpacity: option(string),
    [@res.optional]
    strikethroughPosition: option(string),
    [@res.optional]
    strikethroughThickness: option(string),
    [@res.optional]
    stroke: option(string),
    [@res.optional]
    strokeDasharray: option(string),
    [@res.optional]
    strokeDashoffset: option(string),
    [@res.optional]
    strokeLinecap: option(string),
    [@res.optional]
    strokeLinejoin: option(string),
    [@res.optional]
    strokeMiterlimit: option(string),
    [@res.optional]
    strokeOpacity: option(string),
    [@res.optional]
    strokeWidth: option(string),
    [@res.optional]
    style: option(ReactDOM.Style.t),
    [@res.optional]
    summary: option(string),
    [@res.optional]
    suppressContentEditableWarning: option(bool),
    [@res.optional]
    surfaceScale: option(string),
    [@res.optional]
    systemLanguage: option(string),
    [@res.optional]
    tabIndex: option(int),
    [@res.optional]
    tableValues: option(string),
    [@res.optional]
    target: option(string),
    [@res.optional]
    targetX: option(string),
    [@res.optional]
    targetY: option(string),
    [@res.optional]
    textAnchor: option(string),
    [@res.optional]
    textDecoration: option(string),
    [@res.optional]
    textLength: option(string),
    [@res.optional]
    textRendering: option(string),
    [@res.optional]
    title: option(string),
    [@res.optional]
    to_: option(string),
    [@res.optional]
    transform: option(string),
    [@res.optional] [@bs.as "type"]
    type_: option(string),
    [@res.optional]
    typeof: option(string),
    [@res.optional]
    u1: option(string),
    [@res.optional]
    u2: option(string),
    [@res.optional]
    underlinePosition: option(string),
    [@res.optional]
    underlineThickness: option(string),
    [@res.optional]
    unicode: option(string),
    [@res.optional]
    unicodeBidi: option(string),
    [@res.optional]
    unicodeRange: option(string),
    [@res.optional]
    unitsPerEm: option(string),
    [@res.optional]
    useMap: option(string),
    [@res.optional]
    vAlphabetic: option(string),
    [@res.optional]
    value: option(string),
    [@res.optional]
    values: option(string),
    [@res.optional]
    vectorEffect: option(string),
    [@res.optional]
    version: option(string),
    [@res.optional]
    vertAdvX: option(string),
    [@res.optional]
    vertAdvY: option(string),
    [@res.optional]
    vertOriginX: option(string),
    [@res.optional]
    vertOriginY: option(string),
    [@res.optional]
    vHanging: option(string),
    [@res.optional]
    vIdeographic: option(string),
    [@res.optional]
    viewBox: option(string),
    [@res.optional]
    viewTarget: option(string),
    [@res.optional]
    visibility: option(string),
    [@res.optional]
    vMathematical: option(string),
    [@res.optional]
    vocab: option(string),
    [@res.optional]
    width: option(string),
    [@res.optional]
    widths: option(string),
    [@res.optional]
    wordSpacing: option(string),
    [@res.optional]
    wrap: option(string),
    [@res.optional]
    writingMode: option(string),
    [@res.optional]
    x: option(string),
    [@res.optional]
    x1: option(string),
    [@res.optional]
    x2: option(string),
    [@res.optional]
    xChannelSelector: option(string),
    [@res.optional]
    xHeight: option(string),
    [@res.optional]
    xlinkActuate: option(string),
    [@res.optional]
    xlinkArcrole: option(string),
    [@res.optional]
    xlinkHref: option(string),
    [@res.optional]
    xlinkRole: option(string),
    [@res.optional]
    xlinkShow: option(string),
    [@res.optional]
    xlinkTitle: option(string),
    [@res.optional]
    xlinkType: option(string),
    [@res.optional]
    xmlBase: option(string),
    [@res.optional]
    xmlLang: option(string),
    [@res.optional]
    xmlns: option(string),
    [@res.optional]
    xmlnsXlink: option(string),
    [@res.optional]
    xmlSpace: option(string),
    [@res.optional]
    y: option(string),
    [@res.optional]
    y1: option(string),
    [@res.optional]
    y2: option(string),
    [@res.optional]
    yChannelSelector: option(string),
    [@res.optional]
    z: option(string),
    [@res.optional]
    zoomAndPan: option(string),
    [@res.optional]
    onAbort: ReactEvent.Media.t => unit,
    [@res.optional]
    onAnimationEnd: ReactEvent.Animation.t => unit,
    [@res.optional]
    onAnimationIteration: ReactEvent.Animation.t => unit,
    [@res.optional]
    onAnimationStart: ReactEvent.Animation.t => unit,
    [@res.optional]
    onBlur: ReactEvent.Focus.t => unit,
    [@res.optional]
    onCanPlay: ReactEvent.Media.t => unit,
    [@res.optional]
    onCanPlayThrough: ReactEvent.Media.t => unit,
    [@res.optional]
    onChange: ReactEvent.Form.t => unit,
    [@res.optional]
    onClick: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onCompositionEnd: ReactEvent.Composition.t => unit,
    [@res.optional]
    onCompositionStart: ReactEvent.Composition.t => unit,
    [@res.optional]
    onCompositionUpdate: ReactEvent.Composition.t => unit,
    [@res.optional]
    onContextMenu: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onCopy: ReactEvent.Clipboard.t => unit,
    [@res.optional]
    onCut: ReactEvent.Clipboard.t => unit,
    [@res.optional]
    onDoubleClick: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onDrag: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onDragEnd: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onDragEnter: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onDragExit: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onDragLeave: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onDragOver: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onDragStart: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onDrop: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onDurationChange: ReactEvent.Media.t => unit,
    [@res.optional]
    onEmptied: ReactEvent.Media.t => unit,
    [@res.optional]
    onEncrypetd: ReactEvent.Media.t => unit,
    [@res.optional]
    onEnded: ReactEvent.Media.t => unit,
    [@res.optional]
    onError: ReactEvent.Media.t => unit,
    [@res.optional]
    onFocus: ReactEvent.Focus.t => unit,
    [@res.optional]
    onInput: ReactEvent.Form.t => unit,
    [@res.optional]
    onKeyDown: ReactEvent.Keyboard.t => unit,
    [@res.optional]
    onKeyPress: ReactEvent.Keyboard.t => unit,
    [@res.optional]
    onKeyUp: ReactEvent.Keyboard.t => unit,
    [@res.optional]
    onLoadedData: ReactEvent.Media.t => unit,
    [@res.optional]
    onLoadedMetadata: ReactEvent.Media.t => unit,
    [@res.optional]
    onLoadStart: ReactEvent.Media.t => unit,
    [@res.optional]
    onMouseDown: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onMouseEnter: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onMouseLeave: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onMouseMove: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onMouseOut: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onMouseOver: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onMouseUp: ReactEvent.Mouse.t => unit,
    [@res.optional]
    onPaste: ReactEvent.Clipboard.t => unit,
    [@res.optional]
    onPause: ReactEvent.Media.t => unit,
    [@res.optional]
    onPlay: ReactEvent.Media.t => unit,
    [@res.optional]
    onPlaying: ReactEvent.Media.t => unit,
    [@res.optional]
    onProgress: ReactEvent.Media.t => unit,
    [@res.optional]
    onRateChange: ReactEvent.Media.t => unit,
    [@res.optional]
    onScroll: ReactEvent.UI.t => unit,
    [@res.optional]
    onSeeked: ReactEvent.Media.t => unit,
    [@res.optional]
    onSeeking: ReactEvent.Media.t => unit,
    [@res.optional]
    onSelect: ReactEvent.Selection.t => unit,
    [@res.optional]
    onStalled: ReactEvent.Media.t => unit,
    [@res.optional]
    onSubmit: ReactEvent.Form.t => unit,
    [@res.optional]
    onSuspend: ReactEvent.Media.t => unit,
    [@res.optional]
    onTimeUpdate: ReactEvent.Media.t => unit,
    [@res.optional]
    onTouchCancel: ReactEvent.Touch.t => unit,
    [@res.optional]
    onTouchEnd: ReactEvent.Touch.t => unit,
    [@res.optional]
    onTouchMove: ReactEvent.Touch.t => unit,
    [@res.optional]
    onTouchStart: ReactEvent.Touch.t => unit,
    [@res.optional]
    onTransitionEnd: ReactEvent.Transition.t => unit,
    [@res.optional]
    onVolumeChange: ReactEvent.Media.t => unit,
    [@res.optional]
    onWaiting: ReactEvent.Media.t => unit,
    [@res.optional]
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
    let className = styles(~var=props.var, ());
    let stylesObject = {"className": className, "ref": props.ref};
    let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
    ignore(deleteProp(newProps, "var"));
    createVariadicElement("div", newProps);
  };
};
