  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --native --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module MultiLineStrings = {
    let getOrEmpty = str =>
      switch (str) {
      | Some(str) => " " ++ str
      | None => ""
      };
    let styles =
      CSS.style([|
        CSS.label("MultiLineStrings"),
        CSS.display(`flex),
        CSS.justifyContent(`center),
      |]);
    include {
              let make =
                  (
                    ~onWheel: option(React.Event.Wheel.t => unit)=?,
                    ~onWaiting: option(React.Event.Media.t => unit)=?,
                    ~onVolumeChange: option(React.Event.Media.t => unit)=?,
                    ~onTransitionEnd: option(React.Event.Transition.t => unit)=?,
                    ~onTouchStart: option(React.Event.Touch.t => unit)=?,
                    ~onTouchMove: option(React.Event.Touch.t => unit)=?,
                    ~onTouchEnd: option(React.Event.Touch.t => unit)=?,
                    ~onTouchCancel: option(React.Event.Touch.t => unit)=?,
                    ~onTimeUpdate: option(React.Event.Media.t => unit)=?,
                    ~onSuspend: option(React.Event.Media.t => unit)=?,
                    ~onSubmit: option(React.Event.Form.t => unit)=?,
                    ~onStalled: option(React.Event.Media.t => unit)=?,
                    ~onSelect: option(React.Event.Selection.t => unit)=?,
                    ~onSeeking: option(React.Event.Media.t => unit)=?,
                    ~onSeeked: option(React.Event.Media.t => unit)=?,
                    ~onScroll: option(React.Event.UI.t => unit)=?,
                    ~onRateChange: option(React.Event.Media.t => unit)=?,
                    ~onProgress: option(React.Event.Media.t => unit)=?,
                    ~onPlaying: option(React.Event.Media.t => unit)=?,
                    ~onPlay: option(React.Event.Media.t => unit)=?,
                    ~onPause: option(React.Event.Media.t => unit)=?,
                    ~onPaste: option(React.Event.Clipboard.t => unit)=?,
                    ~onMouseUp: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseOver: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseOut: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseMove: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseLeave: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseEnter: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseDown: option(React.Event.Mouse.t => unit)=?,
                    ~onLoadStart: option(React.Event.Media.t => unit)=?,
                    ~onLoadedMetadata: option(React.Event.Media.t => unit)=?,
                    ~onLoadedData: option(React.Event.Media.t => unit)=?,
                    ~onKeyUp: option(React.Event.Keyboard.t => unit)=?,
                    ~onKeyPress: option(React.Event.Keyboard.t => unit)=?,
                    ~onKeyDown: option(React.Event.Keyboard.t => unit)=?,
                    ~onInput: option(React.Event.Form.t => unit)=?,
                    ~onFocus: option(React.Event.Focus.t => unit)=?,
                    ~onError: option(React.Event.Media.t => unit)=?,
                    ~onEnded: option(React.Event.Media.t => unit)=?,
                    ~onEncrypetd: option(React.Event.Media.t => unit)=?,
                    ~onEmptied: option(React.Event.Media.t => unit)=?,
                    ~onDurationChange: option(React.Event.Media.t => unit)=?,
                    ~onDrop: option(React.Event.Mouse.t => unit)=?,
                    ~onDragStart: option(React.Event.Mouse.t => unit)=?,
                    ~onDragOver: option(React.Event.Mouse.t => unit)=?,
                    ~onDragLeave: option(React.Event.Mouse.t => unit)=?,
                    ~onDragExit: option(React.Event.Mouse.t => unit)=?,
                    ~onDragEnter: option(React.Event.Mouse.t => unit)=?,
                    ~onDragEnd: option(React.Event.Mouse.t => unit)=?,
                    ~onDrag: option(React.Event.Mouse.t => unit)=?,
                    ~onDoubleClick: option(React.Event.Mouse.t => unit)=?,
                    ~onCut: option(React.Event.Clipboard.t => unit)=?,
                    ~onCopy: option(React.Event.Clipboard.t => unit)=?,
                    ~onContextMenu: option(React.Event.Mouse.t => unit)=?,
                    ~onCompositionUpdate:
                       option(React.Event.Composition.t => unit)=?,
                    ~onCompositionStart:
                       option(React.Event.Composition.t => unit)=?,
                    ~onCompositionEnd: option(React.Event.Composition.t => unit)=?,
                    ~onClick: option(React.Event.Mouse.t => unit)=?,
                    ~onChange: option(React.Event.Form.t => unit)=?,
                    ~onCanPlayThrough: option(React.Event.Media.t => unit)=?,
                    ~onCanPlay: option(React.Event.Media.t => unit)=?,
                    ~onBlur: option(React.Event.Focus.t => unit)=?,
                    ~onAnimationStart: option(React.Event.Animation.t => unit)=?,
                    ~onAnimationIteration:
                       option(React.Event.Animation.t => unit)=?,
                    ~onAnimationEnd: option(React.Event.Animation.t => unit)=?,
                    ~onAbort: option(React.Event.Media.t => unit)=?,
                    ~zoomAndPan: option(string)=?,
                    ~z: option(string)=?,
                    ~yChannelSelector: option(string)=?,
                    ~y2: option(string)=?,
                    ~y1: option(string)=?,
                    ~y: option(string)=?,
                    ~xmlSpace: option(string)=?,
                    ~xmlnsXlink: option(string)=?,
                    ~xmlns: option(string)=?,
                    ~xmlLang: option(string)=?,
                    ~xmlBase: option(string)=?,
                    ~xlinkType: option(string)=?,
                    ~xlinkTitle: option(string)=?,
                    ~xlinkShow: option(string)=?,
                    ~xlinkRole: option(string)=?,
                    ~xlinkHref: option(string)=?,
                    ~xlinkArcrole: option(string)=?,
                    ~xlinkActuate: option(string)=?,
                    ~xHeight: option(string)=?,
                    ~xChannelSelector: option(string)=?,
                    ~x2: option(string)=?,
                    ~x1: option(string)=?,
                    ~x: option(string)=?,
                    ~writingMode: option(string)=?,
                    ~wrap: option(string)=?,
                    ~wordSpacing: option(string)=?,
                    ~widths: option(string)=?,
                    ~width: option(string)=?,
                    ~vocab: option(string)=?,
                    ~vMathematical: option(string)=?,
                    ~visibility: option(string)=?,
                    ~viewTarget: option(string)=?,
                    ~viewBox: option(string)=?,
                    ~vIdeographic: option(string)=?,
                    ~vHanging: option(string)=?,
                    ~vertOriginY: option(string)=?,
                    ~vertOriginX: option(string)=?,
                    ~vertAdvY: option(string)=?,
                    ~vertAdvX: option(string)=?,
                    ~version: option(string)=?,
                    ~vectorEffect: option(string)=?,
                    ~values: option(string)=?,
                    ~value: option(string)=?,
                    ~vAlphabetic: option(string)=?,
                    ~useMap: option(string)=?,
                    ~unitsPerEm: option(string)=?,
                    ~unicodeRange: option(string)=?,
                    ~unicodeBidi: option(string)=?,
                    ~unicode: option(string)=?,
                    ~underlineThickness: option(string)=?,
                    ~underlinePosition: option(string)=?,
                    ~u2: option(string)=?,
                    ~u1: option(string)=?,
                    ~typeof: option(string)=?,
                    ~type_: option(string)=?,
                    ~transform: option(string)=?,
                    ~to_: option(string)=?,
                    ~title: option(string)=?,
                    ~textRendering: option(string)=?,
                    ~textLength: option(string)=?,
                    ~textDecoration: option(string)=?,
                    ~textAnchor: option(string)=?,
                    ~targetY: option(string)=?,
                    ~targetX: option(string)=?,
                    ~target: option(string)=?,
                    ~tableValues: option(string)=?,
                    ~tabIndex: option(int)=?,
                    ~systemLanguage: option(string)=?,
                    ~surfaceScale: option(string)=?,
                    ~suppressContentEditableWarning: option(bool)=?,
                    ~summary: option(string)=?,
                    ~style: option(ReactDOM.Style.t)=?,
                    ~strokeWidth: option(string)=?,
                    ~strokeOpacity: option(string)=?,
                    ~strokeMiterlimit: option(string)=?,
                    ~strokeLinejoin: option(string)=?,
                    ~strokeLinecap: option(string)=?,
                    ~strokeDashoffset: option(string)=?,
                    ~strokeDasharray: option(string)=?,
                    ~stroke: option(string)=?,
                    ~strikethroughThickness: option(string)=?,
                    ~strikethroughPosition: option(string)=?,
                    ~stopOpacity: option(string)=?,
                    ~stopColor: option(string)=?,
                    ~stitchTiles: option(string)=?,
                    ~step: option(float)=?,
                    ~stemv: option(string)=?,
                    ~stemh: option(string)=?,
                    ~stdDeviation: option(string)=?,
                    ~startOffset: option(string)=?,
                    ~start: option(int)=?,
                    ~srcSet: option(string)=?,
                    ~srcLang: option(string)=?,
                    ~srcDoc: option(string)=?,
                    ~src: option(string)=?,
                    ~spreadMethod: option(string)=?,
                    ~spellCheck: option(bool)=?,
                    ~speed: option(string)=?,
                    ~specularExponent: option(string)=?,
                    ~specularConstant: option(string)=?,
                    ~span: option(int)=?,
                    ~spacing: option(string)=?,
                    ~slope: option(string)=?,
                    ~sizes: option(string)=?,
                    ~size: option(int)=?,
                    ~shapeRendering: option(string)=?,
                    ~shape: option(string)=?,
                    ~selected: option(bool)=?,
                    ~seed: option(string)=?,
                    ~scrolling: option(string)=?,
                    ~scoped: option(bool)=?,
                    ~scope: option(string)=?,
                    ~scale: option(string)=?,
                    ~sandbox: option(string)=?,
                    ~ry: option(string)=?,
                    ~rx: option(string)=?,
                    ~rowSpan: option(int)=?,
                    ~rows: option(int)=?,
                    ~rotate: option(string)=?,
                    ~role: option(string)=?,
                    ~reversed: option(bool)=?,
                    ~result: option(string)=?,
                    ~restart: option(string)=?,
                    ~resource: option(string)=?,
                    ~requiredFeatures: option(string)=?,
                    ~requiredExtensions: option(string)=?,
                    ~required: option(bool)=?,
                    ~repeatDur: option(string)=?,
                    ~repeatCount: option(string)=?,
                    ~renderingIntent: option(string)=?,
                    ~rel: option(string)=?,
                    ~refY: option(string)=?,
                    ~refX: option(string)=?,
                    ~readOnly: option(bool)=?,
                    ~radius: option(string)=?,
                    ~radioGroup: option(string)=?,
                    ~r: option(string)=?,
                    ~property: option(string)=?,
                    ~primitiveUnits: option(string)=?,
                    ~preserveAspectRatio: option(string)=?,
                    ~preserveAlpha: option(string)=?,
                    ~preload: option(string)=?,
                    ~prefix: option(string)=?,
                    ~poster: option(string)=?,
                    ~pointsAtZ: option(string)=?,
                    ~pointsAtY: option(string)=?,
                    ~pointsAtX: option(string)=?,
                    ~points: option(string)=?,
                    ~pointerEvents: option(string)=?,
                    ~placeholder: option(string)=?,
                    ~patternUnits: option(string)=?,
                    ~patternTransform: option(string)=?,
                    ~patternContentUnits: option(string)=?,
                    ~pattern: option(string)=?,
                    ~pathLength: option(string)=?,
                    ~panose1: option(string)=?,
                    ~paintOrder: option(string)=?,
                    ~overlineThickness: option(string)=?,
                    ~overlinePosition: option(string)=?,
                    ~overflowY: option(string)=?,
                    ~overflowX: option(string)=?,
                    ~overflow: option(string)=?,
                    ~origin: option(string)=?,
                    ~orientation: option(string)=?,
                    ~orient: option(string)=?,
                    ~order: option(string)=?,
                    ~optimum: option(int)=?,
                    ~operator: option(string)=?,
                    ~open_: option(bool)=?,
                    ~opacity: option(string)=?,
                    ~offset: option(string)=?,
                    ~numOctaves: option(string)=?,
                    ~noValidate: option(bool)=?,
                    ~nonce: option(string)=?,
                    ~name: option(string)=?,
                    ~muted: option(bool)=?,
                    ~multiple: option(bool)=?,
                    ~mode: option(string)=?,
                    ~minLength: option(int)=?,
                    ~min: option(string)=?,
                    ~mediaGroup: option(string)=?,
                    ~media: option(string)=?,
                    ~maxLength: option(int)=?,
                    ~max: option(string)=?,
                    ~mathematical: option(string)=?,
                    ~maskUnits: option(string)=?,
                    ~maskContentUnits: option(string)=?,
                    ~mask: option(string)=?,
                    ~markerWidth: option(string)=?,
                    ~markerUnits: option(string)=?,
                    ~markerStart: option(string)=?,
                    ~markerMid: option(string)=?,
                    ~markerHeight: option(string)=?,
                    ~markerEnd: option(string)=?,
                    ~manifest: option(string)=?,
                    ~low: option(int)=?,
                    ~loop: option(bool)=?,
                    ~local: option(string)=?,
                    ~list: option(string)=?,
                    ~limitingConeAngle: option(string)=?,
                    ~lightingColor: option(string)=?,
                    ~letterSpacing: option(string)=?,
                    ~lengthAdjust: option(string)=?,
                    ~lang: option(string)=?,
                    ~label: option(string)=?,
                    ~kind: option(string)=?,
                    ~keyType: option(string)=?,
                    ~keyTimes: option(string)=?,
                    ~keySplines: option(string)=?,
                    ~keyPoints: option(string)=?,
                    ~kerning: option(string)=?,
                    ~kernelUnitLength: option(string)=?,
                    ~kernelMatrix: option(string)=?,
                    ~k4: option(string)=?,
                    ~k3: option(string)=?,
                    ~k2: option(string)=?,
                    ~k1: option(string)=?,
                    ~k: option(string)=?,
                    ~itemType: option(string)=?,
                    ~itemScope: option(bool)=?,
                    ~itemRef: option(string)=?,
                    ~itemProp: option(string)=?,
                    ~itemID: option(string)=?,
                    ~intercept: option(string)=?,
                    ~integrity: option(string)=?,
                    ~inputMode: option(string)=?,
                    ~inlist: option(string)=?,
                    ~in2: option(string)=?,
                    ~in_: option(string)=?,
                    ~imageRendering: option(string)=?,
                    ~ideographic: option(string)=?,
                    ~id: option(string)=?,
                    ~icon: option(string)=?,
                    ~httpEquiv: option(string)=?,
                    ~htmlFor: option(string)=?,
                    ~hrefLang: option(string)=?,
                    ~href: option(string)=?,
                    ~horizOriginX: option(string)=?,
                    ~horizAdvX: option(string)=?,
                    ~high: option(int)=?,
                    ~hidden: option(bool)=?,
                    ~height: option(string)=?,
                    ~headers: option(string)=?,
                    ~hanging: option(string)=?,
                    ~gradientUnits: option(string)=?,
                    ~gradientTransform: option(string)=?,
                    ~glyphRef: option(string)=?,
                    ~glyphOrientationVertical: option(string)=?,
                    ~glyphOrientationHorizontal: option(string)=?,
                    ~glyphName: option(string)=?,
                    ~g2: option(string)=?,
                    ~g1: option(string)=?,
                    ~fy: option(string)=?,
                    ~fx: option(string)=?,
                    ~from: option(string)=?,
                    ~formTarget: option(string)=?,
                    ~formMethod: option(string)=?,
                    ~formAction: option(string)=?,
                    ~form: option(string)=?,
                    ~fontWeight: option(string)=?,
                    ~fontVariant: option(string)=?,
                    ~fontStyle: option(string)=?,
                    ~fontStretch: option(string)=?,
                    ~fontSizeAdjust: option(string)=?,
                    ~fontSize: option(string)=?,
                    ~fontFamily: option(string)=?,
                    ~fomat: option(string)=?,
                    ~focusable: option(string)=?,
                    ~floodOpacity: option(string)=?,
                    ~floodColor: option(string)=?,
                    ~filterUnits: option(string)=?,
                    ~filterRes: option(string)=?,
                    ~filter: option(string)=?,
                    ~fillRule: option(string)=?,
                    ~fillOpacity: option(string)=?,
                    ~fill: option(string)=?,
                    ~externalResourcesRequired: option(string)=?,
                    ~exponent: option(string)=?,
                    ~end_: option(string)=?,
                    ~encType: option(string)=?,
                    ~enableBackground: option(string)=?,
                    ~elevation: option(string)=?,
                    ~edgeMode: option(string)=?,
                    ~dy: option(string)=?,
                    ~dx: option(string)=?,
                    ~dur: option(string)=?,
                    ~draggable: option(bool)=?,
                    ~download: option(string)=?,
                    ~dominantBaseline: option(string)=?,
                    ~divisor: option(string)=?,
                    ~display: option(string)=?,
                    ~disabled: option(bool)=?,
                    ~direction: option(string)=?,
                    ~dir: option(string)=?,
                    ~diffuseConstant: option(string)=?,
                    ~descent: option(string)=?,
                    ~defer: option(bool)=?,
                    ~defaultValue: option(string)=?,
                    ~defaultChecked: option(bool)=?,
                    ~default: option(bool)=?,
                    ~decelerate: option(string)=?,
                    ~dateTime: option(string)=?,
                    ~datatype: option(string)=?,
                    ~data: option(string)=?,
                    ~d: option(string)=?,
                    ~cy: option(string)=?,
                    ~cx: option(string)=?,
                    ~cursor: option(string)=?,
                    ~crossOrigin: option(string)=?,
                    ~coords: option(string)=?,
                    ~controls: option(bool)=?,
                    ~contextMenu: option(string)=?,
                    ~contentStyleType: option(string)=?,
                    ~contentScriptType: option(string)=?,
                    ~contentEditable: option(bool)=?,
                    ~content: option(string)=?,
                    ~colSpan: option(int)=?,
                    ~cols: option(int)=?,
                    ~colorRendering: option(string)=?,
                    ~colorProfile: option(string)=?,
                    ~colorInterpolationFilters: option(string)=?,
                    ~colorInterpolation: option(string)=?,
                    ~clipRule: option(string)=?,
                    ~clipPathUnits: option(string)=?,
                    ~clipPath: option(string)=?,
                    ~clip: option(string)=?,
                    ~className: option(string)=?,
                    ~cite: option(string)=?,
                    ~checked: option(bool)=?,
                    ~charSet: option(string)=?,
                    ~challenge: option(string)=?,
                    ~capHeight: option(string)=?,
                    ~calcMode: option(string)=?,
                    ~by: option(string)=?,
                    ~bias: option(string)=?,
                    ~begin_: option(string)=?,
                    ~bbox: option(string)=?,
                    ~baseProfile: option(string)=?,
                    ~baselineShift: option(string)=?,
                    ~baseFrequency: option(string)=?,
                    ~azimuth: option(string)=?,
                    ~autoReverse: option(string)=?,
                    ~autoPlay: option(bool)=?,
                    ~autoFocus: option(bool)=?,
                    ~autoComplete: option(string)=?,
                    ~attributeType: option(string)=?,
                    ~attributeName: option(string)=?,
                    ~async: option(bool)=?,
                    ~ascent: option(string)=?,
                    ~ariaValuetext: option(string)=?,
                    ~ariaValuenow: option(float)=?,
                    ~ariaValuemin: option(float)=?,
                    ~ariaValuemax: option(float)=?,
                    ~ariaSort: option(string)=?,
                    ~ariaSetsize: option(int)=?,
                    ~ariaSelected: option(bool)=?,
                    ~ariaRowspan: option(int)=?,
                    ~ariaRowindex: option(int)=?,
                    ~ariaRowcount: option(int)=?,
                    ~ariaRoledescription: option(string)=?,
                    ~ariaRequired: option(bool)=?,
                    ~ariaRelevant: option(string)=?,
                    ~ariaReadonly: option(bool)=?,
                    ~ariaPosinset: option(int)=?,
                    ~ariaPlaceholder: option(string)=?,
                    ~ariaOwns: option(string)=?,
                    ~ariaMultiselectable: option(bool)=?,
                    ~ariaMultiline: option(bool)=?,
                    ~ariaModal: option(bool)=?,
                    ~ariaLevel: option(int)=?,
                    ~ariaLabelledby: option(string)=?,
                    ~ariaLabel: option(string)=?,
                    ~ariaKeyshortcuts: option(string)=?,
                    ~ariaHidden: option(bool)=?,
                    ~ariaGrabbed: option(bool)=?,
                    ~ariaFlowto: option(string)=?,
                    ~ariaExpanded: option(bool)=?,
                    ~ariaErrormessage: option(string)=?,
                    ~ariaDisabled: option(bool)=?,
                    ~ariaDetails: option(string)=?,
                    ~ariaDescribedby: option(string)=?,
                    ~ariaControls: option(string)=?,
                    ~ariaColspan: option(int)=?,
                    ~ariaColindex: option(int)=?,
                    ~ariaColcount: option(int)=?,
                    ~ariaBusy: option(bool)=?,
                    ~ariaAtomic: option(bool)=?,
                    ~ariaActivedescendant: option(string)=?,
                    ~arabicForm: option(string)=?,
                    ~amplitude: option(string)=?,
                    ~alt: option(string)=?,
                    ~alphabetic: option(string)=?,
                    ~allowReorder: option(string)=?,
                    ~allowFullScreen: option(bool)=?,
                    ~alignmentBaseline: option(string)=?,
                    ~additive: option(string)=?,
                    ~action: option(string)=?,
                    ~accumulate: option(string)=?,
                    ~accessKey: option(string)=?,
                    ~acceptCharset: option(string)=?,
                    ~accept: option(string)=?,
                    ~accentHeight: option(string)=?,
                    ~about: option(string)=?,
                    ~children=React.null,
                    ~as_=?,
                    ~innerRef=?,
                    ~key as _: option(string)=?,
                    _,
                  ) => {
                let className = styles ++ getOrEmpty(className);
                React.createElement(
                  switch (as_) {
                  | Some(v) => v
  
                  | None => "section"
                  },
                  ReactDOM.domProps(
                    ~className,
                    ~ref=?innerRef,
                    ~about?,
                    ~accentHeight?,
                    ~accept?,
                    ~acceptCharset?,
                    ~accessKey?,
                    ~accumulate?,
                    ~action?,
                    ~additive?,
                    ~alignmentBaseline?,
                    ~allowFullScreen?,
                    ~allowReorder?,
                    ~alphabetic?,
                    ~alt?,
                    ~amplitude?,
                    ~arabicForm?,
                    ~ariaActivedescendant?,
                    ~ariaAtomic?,
                    ~ariaBusy?,
                    ~ariaColcount?,
                    ~ariaColindex?,
                    ~ariaColspan?,
                    ~ariaControls?,
                    ~ariaDescribedby?,
                    ~ariaDetails?,
                    ~ariaDisabled?,
                    ~ariaErrormessage?,
                    ~ariaExpanded?,
                    ~ariaFlowto?,
                    ~ariaGrabbed?,
                    ~ariaHidden?,
                    ~ariaKeyshortcuts?,
                    ~ariaLabel?,
                    ~ariaLabelledby?,
                    ~ariaLevel?,
                    ~ariaModal?,
                    ~ariaMultiline?,
                    ~ariaMultiselectable?,
                    ~ariaOwns?,
                    ~ariaPlaceholder?,
                    ~ariaPosinset?,
                    ~ariaReadonly?,
                    ~ariaRelevant?,
                    ~ariaRequired?,
                    ~ariaRoledescription?,
                    ~ariaRowcount?,
                    ~ariaRowindex?,
                    ~ariaRowspan?,
                    ~ariaSelected?,
                    ~ariaSetsize?,
                    ~ariaSort?,
                    ~ariaValuemax?,
                    ~ariaValuemin?,
                    ~ariaValuenow?,
                    ~ariaValuetext?,
                    ~ascent?,
                    ~async?,
                    ~attributeName?,
                    ~attributeType?,
                    ~autoComplete?,
                    ~autoFocus?,
                    ~autoPlay?,
                    ~autoReverse?,
                    ~azimuth?,
                    ~baseFrequency?,
                    ~baselineShift?,
                    ~baseProfile?,
                    ~bbox?,
                    ~begin_?,
                    ~bias?,
                    ~by?,
                    ~calcMode?,
                    ~capHeight?,
                    ~challenge?,
                    ~charSet?,
                    ~checked?,
                    ~cite?,
                    ~clip?,
                    ~clipPath?,
                    ~clipPathUnits?,
                    ~clipRule?,
                    ~colorInterpolation?,
                    ~colorInterpolationFilters?,
                    ~colorProfile?,
                    ~colorRendering?,
                    ~cols?,
                    ~colSpan?,
                    ~content?,
                    ~contentEditable?,
                    ~contentScriptType?,
                    ~contentStyleType?,
                    ~contextMenu?,
                    ~controls?,
                    ~coords?,
                    ~crossOrigin?,
                    ~cursor?,
                    ~cx?,
                    ~cy?,
                    ~d?,
                    ~data?,
                    ~datatype?,
                    ~dateTime?,
                    ~decelerate?,
                    ~default?,
                    ~defaultChecked?,
                    ~defaultValue?,
                    ~defer?,
                    ~descent?,
                    ~diffuseConstant?,
                    ~dir?,
                    ~direction?,
                    ~disabled?,
                    ~display?,
                    ~divisor?,
                    ~dominantBaseline?,
                    ~download?,
                    ~draggable?,
                    ~dur?,
                    ~dx?,
                    ~dy?,
                    ~edgeMode?,
                    ~elevation?,
                    ~enableBackground?,
                    ~encType?,
                    ~end_?,
                    ~exponent?,
                    ~externalResourcesRequired?,
                    ~fill?,
                    ~fillOpacity?,
                    ~fillRule?,
                    ~filter?,
                    ~filterRes?,
                    ~filterUnits?,
                    ~floodColor?,
                    ~floodOpacity?,
                    ~focusable?,
                    ~fomat?,
                    ~fontFamily?,
                    ~fontSize?,
                    ~fontSizeAdjust?,
                    ~fontStretch?,
                    ~fontStyle?,
                    ~fontVariant?,
                    ~fontWeight?,
                    ~form?,
                    ~formAction?,
                    ~formMethod?,
                    ~formTarget?,
                    ~from?,
                    ~fx?,
                    ~fy?,
                    ~g1?,
                    ~g2?,
                    ~glyphName?,
                    ~glyphOrientationHorizontal?,
                    ~glyphOrientationVertical?,
                    ~glyphRef?,
                    ~gradientTransform?,
                    ~gradientUnits?,
                    ~hanging?,
                    ~headers?,
                    ~height?,
                    ~hidden?,
                    ~high?,
                    ~horizAdvX?,
                    ~horizOriginX?,
                    ~href?,
                    ~hrefLang?,
                    ~htmlFor?,
                    ~httpEquiv?,
                    ~icon?,
                    ~id?,
                    ~ideographic?,
                    ~imageRendering?,
                    ~in_?,
                    ~in2?,
                    ~inlist?,
                    ~inputMode?,
                    ~integrity?,
                    ~intercept?,
                    ~itemID?,
                    ~itemProp?,
                    ~itemRef?,
                    ~itemScope?,
                    ~itemType?,
                    ~k?,
                    ~k1?,
                    ~k2?,
                    ~k3?,
                    ~k4?,
                    ~kernelMatrix?,
                    ~kernelUnitLength?,
                    ~kerning?,
                    ~keyPoints?,
                    ~keySplines?,
                    ~keyTimes?,
                    ~keyType?,
                    ~kind?,
                    ~label?,
                    ~lang?,
                    ~lengthAdjust?,
                    ~letterSpacing?,
                    ~lightingColor?,
                    ~limitingConeAngle?,
                    ~list?,
                    ~local?,
                    ~loop?,
                    ~low?,
                    ~manifest?,
                    ~markerEnd?,
                    ~markerHeight?,
                    ~markerMid?,
                    ~markerStart?,
                    ~markerUnits?,
                    ~markerWidth?,
                    ~mask?,
                    ~maskContentUnits?,
                    ~maskUnits?,
                    ~mathematical?,
                    ~max?,
                    ~maxLength?,
                    ~media?,
                    ~mediaGroup?,
                    ~min?,
                    ~minLength?,
                    ~mode?,
                    ~multiple?,
                    ~muted?,
                    ~name?,
                    ~nonce?,
                    ~noValidate?,
                    ~numOctaves?,
                    ~offset?,
                    ~opacity?,
                    ~open_?,
                    ~operator?,
                    ~optimum?,
                    ~order?,
                    ~orient?,
                    ~orientation?,
                    ~origin?,
                    ~overflow?,
                    ~overflowX?,
                    ~overflowY?,
                    ~overlinePosition?,
                    ~overlineThickness?,
                    ~paintOrder?,
                    ~panose1?,
                    ~pathLength?,
                    ~pattern?,
                    ~patternContentUnits?,
                    ~patternTransform?,
                    ~patternUnits?,
                    ~placeholder?,
                    ~pointerEvents?,
                    ~points?,
                    ~pointsAtX?,
                    ~pointsAtY?,
                    ~pointsAtZ?,
                    ~poster?,
                    ~prefix?,
                    ~preload?,
                    ~preserveAlpha?,
                    ~preserveAspectRatio?,
                    ~primitiveUnits?,
                    ~property?,
                    ~r?,
                    ~radioGroup?,
                    ~radius?,
                    ~readOnly?,
                    ~refX?,
                    ~refY?,
                    ~rel?,
                    ~renderingIntent?,
                    ~repeatCount?,
                    ~repeatDur?,
                    ~required?,
                    ~requiredExtensions?,
                    ~requiredFeatures?,
                    ~resource?,
                    ~restart?,
                    ~result?,
                    ~reversed?,
                    ~role?,
                    ~rotate?,
                    ~rows?,
                    ~rowSpan?,
                    ~rx?,
                    ~ry?,
                    ~sandbox?,
                    ~scale?,
                    ~scope?,
                    ~scoped?,
                    ~scrolling?,
                    ~seed?,
                    ~selected?,
                    ~shape?,
                    ~shapeRendering?,
                    ~size?,
                    ~sizes?,
                    ~slope?,
                    ~spacing?,
                    ~span?,
                    ~specularConstant?,
                    ~specularExponent?,
                    ~speed?,
                    ~spellCheck?,
                    ~spreadMethod?,
                    ~src?,
                    ~srcDoc?,
                    ~srcLang?,
                    ~srcSet?,
                    ~start?,
                    ~startOffset?,
                    ~stdDeviation?,
                    ~stemh?,
                    ~stemv?,
                    ~step?,
                    ~stitchTiles?,
                    ~stopColor?,
                    ~stopOpacity?,
                    ~strikethroughPosition?,
                    ~strikethroughThickness?,
                    ~stroke?,
                    ~strokeDasharray?,
                    ~strokeDashoffset?,
                    ~strokeLinecap?,
                    ~strokeLinejoin?,
                    ~strokeMiterlimit?,
                    ~strokeOpacity?,
                    ~strokeWidth?,
                    ~style?,
                    ~summary?,
                    ~suppressContentEditableWarning?,
                    ~surfaceScale?,
                    ~systemLanguage?,
                    ~tabIndex?,
                    ~tableValues?,
                    ~target?,
                    ~targetX?,
                    ~targetY?,
                    ~textAnchor?,
                    ~textDecoration?,
                    ~textLength?,
                    ~textRendering?,
                    ~title?,
                    ~to_?,
                    ~transform?,
                    ~type_?,
                    ~typeof?,
                    ~u1?,
                    ~u2?,
                    ~underlinePosition?,
                    ~underlineThickness?,
                    ~unicode?,
                    ~unicodeBidi?,
                    ~unicodeRange?,
                    ~unitsPerEm?,
                    ~useMap?,
                    ~vAlphabetic?,
                    ~value?,
                    ~values?,
                    ~vectorEffect?,
                    ~version?,
                    ~vertAdvX?,
                    ~vertAdvY?,
                    ~vertOriginX?,
                    ~vertOriginY?,
                    ~vHanging?,
                    ~vIdeographic?,
                    ~viewBox?,
                    ~viewTarget?,
                    ~visibility?,
                    ~vMathematical?,
                    ~vocab?,
                    ~width?,
                    ~widths?,
                    ~wordSpacing?,
                    ~wrap?,
                    ~writingMode?,
                    ~x?,
                    ~x1?,
                    ~x2?,
                    ~xChannelSelector?,
                    ~xHeight?,
                    ~xlinkActuate?,
                    ~xlinkArcrole?,
                    ~xlinkHref?,
                    ~xlinkRole?,
                    ~xlinkShow?,
                    ~xlinkTitle?,
                    ~xlinkType?,
                    ~xmlBase?,
                    ~xmlLang?,
                    ~xmlns?,
                    ~xmlnsXlink?,
                    ~xmlSpace?,
                    ~y?,
                    ~y1?,
                    ~y2?,
                    ~yChannelSelector?,
                    ~z?,
                    ~zoomAndPan?,
                    ~onAbort?,
                    ~onAnimationEnd?,
                    ~onAnimationIteration?,
                    ~onAnimationStart?,
                    ~onBlur?,
                    ~onCanPlay?,
                    ~onCanPlayThrough?,
                    ~onChange?,
                    ~onClick?,
                    ~onCompositionEnd?,
                    ~onCompositionStart?,
                    ~onCompositionUpdate?,
                    ~onContextMenu?,
                    ~onCopy?,
                    ~onCut?,
                    ~onDoubleClick?,
                    ~onDrag?,
                    ~onDragEnd?,
                    ~onDragEnter?,
                    ~onDragExit?,
                    ~onDragLeave?,
                    ~onDragOver?,
                    ~onDragStart?,
                    ~onDrop?,
                    ~onDurationChange?,
                    ~onEmptied?,
                    ~onEncrypetd?,
                    ~onEnded?,
                    ~onError?,
                    ~onFocus?,
                    ~onInput?,
                    ~onKeyDown?,
                    ~onKeyPress?,
                    ~onKeyUp?,
                    ~onLoadedData?,
                    ~onLoadedMetadata?,
                    ~onLoadStart?,
                    ~onMouseDown?,
                    ~onMouseEnter?,
                    ~onMouseLeave?,
                    ~onMouseMove?,
                    ~onMouseOut?,
                    ~onMouseOver?,
                    ~onMouseUp?,
                    ~onPaste?,
                    ~onPause?,
                    ~onPlay?,
                    ~onPlaying?,
                    ~onProgress?,
                    ~onRateChange?,
                    ~onScroll?,
                    ~onSeeked?,
                    ~onSeeking?,
                    ~onSelect?,
                    ~onStalled?,
                    ~onSubmit?,
                    ~onSuspend?,
                    ~onTimeUpdate?,
                    ~onTouchCancel?,
                    ~onTouchEnd?,
                    ~onTouchMove?,
                    ~onTouchStart?,
                    ~onTransitionEnd?,
                    ~onVolumeChange?,
                    ~onWaiting?,
                    ~onWheel?,
                    (),
                  ),
                  [children],
                );
              };
              let makeProps =
                  (
                    ~onWheel: option(React.Event.Wheel.t => unit)=?,
                    ~onWaiting: option(React.Event.Media.t => unit)=?,
                    ~onVolumeChange: option(React.Event.Media.t => unit)=?,
                    ~onTransitionEnd: option(React.Event.Transition.t => unit)=?,
                    ~onTouchStart: option(React.Event.Touch.t => unit)=?,
                    ~onTouchMove: option(React.Event.Touch.t => unit)=?,
                    ~onTouchEnd: option(React.Event.Touch.t => unit)=?,
                    ~onTouchCancel: option(React.Event.Touch.t => unit)=?,
                    ~onTimeUpdate: option(React.Event.Media.t => unit)=?,
                    ~onSuspend: option(React.Event.Media.t => unit)=?,
                    ~onSubmit: option(React.Event.Form.t => unit)=?,
                    ~onStalled: option(React.Event.Media.t => unit)=?,
                    ~onSelect: option(React.Event.Selection.t => unit)=?,
                    ~onSeeking: option(React.Event.Media.t => unit)=?,
                    ~onSeeked: option(React.Event.Media.t => unit)=?,
                    ~onScroll: option(React.Event.UI.t => unit)=?,
                    ~onRateChange: option(React.Event.Media.t => unit)=?,
                    ~onProgress: option(React.Event.Media.t => unit)=?,
                    ~onPlaying: option(React.Event.Media.t => unit)=?,
                    ~onPlay: option(React.Event.Media.t => unit)=?,
                    ~onPause: option(React.Event.Media.t => unit)=?,
                    ~onPaste: option(React.Event.Clipboard.t => unit)=?,
                    ~onMouseUp: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseOver: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseOut: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseMove: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseLeave: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseEnter: option(React.Event.Mouse.t => unit)=?,
                    ~onMouseDown: option(React.Event.Mouse.t => unit)=?,
                    ~onLoadStart: option(React.Event.Media.t => unit)=?,
                    ~onLoadedMetadata: option(React.Event.Media.t => unit)=?,
                    ~onLoadedData: option(React.Event.Media.t => unit)=?,
                    ~onKeyUp: option(React.Event.Keyboard.t => unit)=?,
                    ~onKeyPress: option(React.Event.Keyboard.t => unit)=?,
                    ~onKeyDown: option(React.Event.Keyboard.t => unit)=?,
                    ~onInput: option(React.Event.Form.t => unit)=?,
                    ~onFocus: option(React.Event.Focus.t => unit)=?,
                    ~onError: option(React.Event.Media.t => unit)=?,
                    ~onEnded: option(React.Event.Media.t => unit)=?,
                    ~onEncrypetd: option(React.Event.Media.t => unit)=?,
                    ~onEmptied: option(React.Event.Media.t => unit)=?,
                    ~onDurationChange: option(React.Event.Media.t => unit)=?,
                    ~onDrop: option(React.Event.Mouse.t => unit)=?,
                    ~onDragStart: option(React.Event.Mouse.t => unit)=?,
                    ~onDragOver: option(React.Event.Mouse.t => unit)=?,
                    ~onDragLeave: option(React.Event.Mouse.t => unit)=?,
                    ~onDragExit: option(React.Event.Mouse.t => unit)=?,
                    ~onDragEnter: option(React.Event.Mouse.t => unit)=?,
                    ~onDragEnd: option(React.Event.Mouse.t => unit)=?,
                    ~onDrag: option(React.Event.Mouse.t => unit)=?,
                    ~onDoubleClick: option(React.Event.Mouse.t => unit)=?,
                    ~onCut: option(React.Event.Clipboard.t => unit)=?,
                    ~onCopy: option(React.Event.Clipboard.t => unit)=?,
                    ~onContextMenu: option(React.Event.Mouse.t => unit)=?,
                    ~onCompositionUpdate:
                       option(React.Event.Composition.t => unit)=?,
                    ~onCompositionStart:
                       option(React.Event.Composition.t => unit)=?,
                    ~onCompositionEnd: option(React.Event.Composition.t => unit)=?,
                    ~onClick: option(React.Event.Mouse.t => unit)=?,
                    ~onChange: option(React.Event.Form.t => unit)=?,
                    ~onCanPlayThrough: option(React.Event.Media.t => unit)=?,
                    ~onCanPlay: option(React.Event.Media.t => unit)=?,
                    ~onBlur: option(React.Event.Focus.t => unit)=?,
                    ~onAnimationStart: option(React.Event.Animation.t => unit)=?,
                    ~onAnimationIteration:
                       option(React.Event.Animation.t => unit)=?,
                    ~onAnimationEnd: option(React.Event.Animation.t => unit)=?,
                    ~onAbort: option(React.Event.Media.t => unit)=?,
                    ~zoomAndPan: option(string)=?,
                    ~z: option(string)=?,
                    ~yChannelSelector: option(string)=?,
                    ~y2: option(string)=?,
                    ~y1: option(string)=?,
                    ~y: option(string)=?,
                    ~xmlSpace: option(string)=?,
                    ~xmlnsXlink: option(string)=?,
                    ~xmlns: option(string)=?,
                    ~xmlLang: option(string)=?,
                    ~xmlBase: option(string)=?,
                    ~xlinkType: option(string)=?,
                    ~xlinkTitle: option(string)=?,
                    ~xlinkShow: option(string)=?,
                    ~xlinkRole: option(string)=?,
                    ~xlinkHref: option(string)=?,
                    ~xlinkArcrole: option(string)=?,
                    ~xlinkActuate: option(string)=?,
                    ~xHeight: option(string)=?,
                    ~xChannelSelector: option(string)=?,
                    ~x2: option(string)=?,
                    ~x1: option(string)=?,
                    ~x: option(string)=?,
                    ~writingMode: option(string)=?,
                    ~wrap: option(string)=?,
                    ~wordSpacing: option(string)=?,
                    ~widths: option(string)=?,
                    ~width: option(string)=?,
                    ~vocab: option(string)=?,
                    ~vMathematical: option(string)=?,
                    ~visibility: option(string)=?,
                    ~viewTarget: option(string)=?,
                    ~viewBox: option(string)=?,
                    ~vIdeographic: option(string)=?,
                    ~vHanging: option(string)=?,
                    ~vertOriginY: option(string)=?,
                    ~vertOriginX: option(string)=?,
                    ~vertAdvY: option(string)=?,
                    ~vertAdvX: option(string)=?,
                    ~version: option(string)=?,
                    ~vectorEffect: option(string)=?,
                    ~values: option(string)=?,
                    ~value: option(string)=?,
                    ~vAlphabetic: option(string)=?,
                    ~useMap: option(string)=?,
                    ~unitsPerEm: option(string)=?,
                    ~unicodeRange: option(string)=?,
                    ~unicodeBidi: option(string)=?,
                    ~unicode: option(string)=?,
                    ~underlineThickness: option(string)=?,
                    ~underlinePosition: option(string)=?,
                    ~u2: option(string)=?,
                    ~u1: option(string)=?,
                    ~typeof: option(string)=?,
                    ~type_: option(string)=?,
                    ~transform: option(string)=?,
                    ~to_: option(string)=?,
                    ~title: option(string)=?,
                    ~textRendering: option(string)=?,
                    ~textLength: option(string)=?,
                    ~textDecoration: option(string)=?,
                    ~textAnchor: option(string)=?,
                    ~targetY: option(string)=?,
                    ~targetX: option(string)=?,
                    ~target: option(string)=?,
                    ~tableValues: option(string)=?,
                    ~tabIndex: option(int)=?,
                    ~systemLanguage: option(string)=?,
                    ~surfaceScale: option(string)=?,
                    ~suppressContentEditableWarning: option(bool)=?,
                    ~summary: option(string)=?,
                    ~style: option(ReactDOM.Style.t)=?,
                    ~strokeWidth: option(string)=?,
                    ~strokeOpacity: option(string)=?,
                    ~strokeMiterlimit: option(string)=?,
                    ~strokeLinejoin: option(string)=?,
                    ~strokeLinecap: option(string)=?,
                    ~strokeDashoffset: option(string)=?,
                    ~strokeDasharray: option(string)=?,
                    ~stroke: option(string)=?,
                    ~strikethroughThickness: option(string)=?,
                    ~strikethroughPosition: option(string)=?,
                    ~stopOpacity: option(string)=?,
                    ~stopColor: option(string)=?,
                    ~stitchTiles: option(string)=?,
                    ~step: option(float)=?,
                    ~stemv: option(string)=?,
                    ~stemh: option(string)=?,
                    ~stdDeviation: option(string)=?,
                    ~startOffset: option(string)=?,
                    ~start: option(int)=?,
                    ~srcSet: option(string)=?,
                    ~srcLang: option(string)=?,
                    ~srcDoc: option(string)=?,
                    ~src: option(string)=?,
                    ~spreadMethod: option(string)=?,
                    ~spellCheck: option(bool)=?,
                    ~speed: option(string)=?,
                    ~specularExponent: option(string)=?,
                    ~specularConstant: option(string)=?,
                    ~span: option(int)=?,
                    ~spacing: option(string)=?,
                    ~slope: option(string)=?,
                    ~sizes: option(string)=?,
                    ~size: option(int)=?,
                    ~shapeRendering: option(string)=?,
                    ~shape: option(string)=?,
                    ~selected: option(bool)=?,
                    ~seed: option(string)=?,
                    ~scrolling: option(string)=?,
                    ~scoped: option(bool)=?,
                    ~scope: option(string)=?,
                    ~scale: option(string)=?,
                    ~sandbox: option(string)=?,
                    ~ry: option(string)=?,
                    ~rx: option(string)=?,
                    ~rowSpan: option(int)=?,
                    ~rows: option(int)=?,
                    ~rotate: option(string)=?,
                    ~role: option(string)=?,
                    ~reversed: option(bool)=?,
                    ~result: option(string)=?,
                    ~restart: option(string)=?,
                    ~resource: option(string)=?,
                    ~requiredFeatures: option(string)=?,
                    ~requiredExtensions: option(string)=?,
                    ~required: option(bool)=?,
                    ~repeatDur: option(string)=?,
                    ~repeatCount: option(string)=?,
                    ~renderingIntent: option(string)=?,
                    ~rel: option(string)=?,
                    ~refY: option(string)=?,
                    ~refX: option(string)=?,
                    ~readOnly: option(bool)=?,
                    ~radius: option(string)=?,
                    ~radioGroup: option(string)=?,
                    ~r: option(string)=?,
                    ~property: option(string)=?,
                    ~primitiveUnits: option(string)=?,
                    ~preserveAspectRatio: option(string)=?,
                    ~preserveAlpha: option(string)=?,
                    ~preload: option(string)=?,
                    ~prefix: option(string)=?,
                    ~poster: option(string)=?,
                    ~pointsAtZ: option(string)=?,
                    ~pointsAtY: option(string)=?,
                    ~pointsAtX: option(string)=?,
                    ~points: option(string)=?,
                    ~pointerEvents: option(string)=?,
                    ~placeholder: option(string)=?,
                    ~patternUnits: option(string)=?,
                    ~patternTransform: option(string)=?,
                    ~patternContentUnits: option(string)=?,
                    ~pattern: option(string)=?,
                    ~pathLength: option(string)=?,
                    ~panose1: option(string)=?,
                    ~paintOrder: option(string)=?,
                    ~overlineThickness: option(string)=?,
                    ~overlinePosition: option(string)=?,
                    ~overflowY: option(string)=?,
                    ~overflowX: option(string)=?,
                    ~overflow: option(string)=?,
                    ~origin: option(string)=?,
                    ~orientation: option(string)=?,
                    ~orient: option(string)=?,
                    ~order: option(string)=?,
                    ~optimum: option(int)=?,
                    ~operator: option(string)=?,
                    ~open_: option(bool)=?,
                    ~opacity: option(string)=?,
                    ~offset: option(string)=?,
                    ~numOctaves: option(string)=?,
                    ~noValidate: option(bool)=?,
                    ~nonce: option(string)=?,
                    ~name: option(string)=?,
                    ~muted: option(bool)=?,
                    ~multiple: option(bool)=?,
                    ~mode: option(string)=?,
                    ~minLength: option(int)=?,
                    ~min: option(string)=?,
                    ~mediaGroup: option(string)=?,
                    ~media: option(string)=?,
                    ~maxLength: option(int)=?,
                    ~max: option(string)=?,
                    ~mathematical: option(string)=?,
                    ~maskUnits: option(string)=?,
                    ~maskContentUnits: option(string)=?,
                    ~mask: option(string)=?,
                    ~markerWidth: option(string)=?,
                    ~markerUnits: option(string)=?,
                    ~markerStart: option(string)=?,
                    ~markerMid: option(string)=?,
                    ~markerHeight: option(string)=?,
                    ~markerEnd: option(string)=?,
                    ~manifest: option(string)=?,
                    ~low: option(int)=?,
                    ~loop: option(bool)=?,
                    ~local: option(string)=?,
                    ~list: option(string)=?,
                    ~limitingConeAngle: option(string)=?,
                    ~lightingColor: option(string)=?,
                    ~letterSpacing: option(string)=?,
                    ~lengthAdjust: option(string)=?,
                    ~lang: option(string)=?,
                    ~label: option(string)=?,
                    ~kind: option(string)=?,
                    ~keyType: option(string)=?,
                    ~keyTimes: option(string)=?,
                    ~keySplines: option(string)=?,
                    ~keyPoints: option(string)=?,
                    ~kerning: option(string)=?,
                    ~kernelUnitLength: option(string)=?,
                    ~kernelMatrix: option(string)=?,
                    ~k4: option(string)=?,
                    ~k3: option(string)=?,
                    ~k2: option(string)=?,
                    ~k1: option(string)=?,
                    ~k: option(string)=?,
                    ~itemType: option(string)=?,
                    ~itemScope: option(bool)=?,
                    ~itemRef: option(string)=?,
                    ~itemProp: option(string)=?,
                    ~itemID: option(string)=?,
                    ~intercept: option(string)=?,
                    ~integrity: option(string)=?,
                    ~inputMode: option(string)=?,
                    ~inlist: option(string)=?,
                    ~in2: option(string)=?,
                    ~in_: option(string)=?,
                    ~imageRendering: option(string)=?,
                    ~ideographic: option(string)=?,
                    ~id: option(string)=?,
                    ~icon: option(string)=?,
                    ~httpEquiv: option(string)=?,
                    ~htmlFor: option(string)=?,
                    ~hrefLang: option(string)=?,
                    ~href: option(string)=?,
                    ~horizOriginX: option(string)=?,
                    ~horizAdvX: option(string)=?,
                    ~high: option(int)=?,
                    ~hidden: option(bool)=?,
                    ~height: option(string)=?,
                    ~headers: option(string)=?,
                    ~hanging: option(string)=?,
                    ~gradientUnits: option(string)=?,
                    ~gradientTransform: option(string)=?,
                    ~glyphRef: option(string)=?,
                    ~glyphOrientationVertical: option(string)=?,
                    ~glyphOrientationHorizontal: option(string)=?,
                    ~glyphName: option(string)=?,
                    ~g2: option(string)=?,
                    ~g1: option(string)=?,
                    ~fy: option(string)=?,
                    ~fx: option(string)=?,
                    ~from: option(string)=?,
                    ~formTarget: option(string)=?,
                    ~formMethod: option(string)=?,
                    ~formAction: option(string)=?,
                    ~form: option(string)=?,
                    ~fontWeight: option(string)=?,
                    ~fontVariant: option(string)=?,
                    ~fontStyle: option(string)=?,
                    ~fontStretch: option(string)=?,
                    ~fontSizeAdjust: option(string)=?,
                    ~fontSize: option(string)=?,
                    ~fontFamily: option(string)=?,
                    ~fomat: option(string)=?,
                    ~focusable: option(string)=?,
                    ~floodOpacity: option(string)=?,
                    ~floodColor: option(string)=?,
                    ~filterUnits: option(string)=?,
                    ~filterRes: option(string)=?,
                    ~filter: option(string)=?,
                    ~fillRule: option(string)=?,
                    ~fillOpacity: option(string)=?,
                    ~fill: option(string)=?,
                    ~externalResourcesRequired: option(string)=?,
                    ~exponent: option(string)=?,
                    ~end_: option(string)=?,
                    ~encType: option(string)=?,
                    ~enableBackground: option(string)=?,
                    ~elevation: option(string)=?,
                    ~edgeMode: option(string)=?,
                    ~dy: option(string)=?,
                    ~dx: option(string)=?,
                    ~dur: option(string)=?,
                    ~draggable: option(bool)=?,
                    ~download: option(string)=?,
                    ~dominantBaseline: option(string)=?,
                    ~divisor: option(string)=?,
                    ~display: option(string)=?,
                    ~disabled: option(bool)=?,
                    ~direction: option(string)=?,
                    ~dir: option(string)=?,
                    ~diffuseConstant: option(string)=?,
                    ~descent: option(string)=?,
                    ~defer: option(bool)=?,
                    ~defaultValue: option(string)=?,
                    ~defaultChecked: option(bool)=?,
                    ~default: option(bool)=?,
                    ~decelerate: option(string)=?,
                    ~dateTime: option(string)=?,
                    ~datatype: option(string)=?,
                    ~data: option(string)=?,
                    ~d: option(string)=?,
                    ~cy: option(string)=?,
                    ~cx: option(string)=?,
                    ~cursor: option(string)=?,
                    ~crossOrigin: option(string)=?,
                    ~coords: option(string)=?,
                    ~controls: option(bool)=?,
                    ~contextMenu: option(string)=?,
                    ~contentStyleType: option(string)=?,
                    ~contentScriptType: option(string)=?,
                    ~contentEditable: option(bool)=?,
                    ~content: option(string)=?,
                    ~colSpan: option(int)=?,
                    ~cols: option(int)=?,
                    ~colorRendering: option(string)=?,
                    ~colorProfile: option(string)=?,
                    ~colorInterpolationFilters: option(string)=?,
                    ~colorInterpolation: option(string)=?,
                    ~clipRule: option(string)=?,
                    ~clipPathUnits: option(string)=?,
                    ~clipPath: option(string)=?,
                    ~clip: option(string)=?,
                    ~className: option(string)=?,
                    ~cite: option(string)=?,
                    ~checked: option(bool)=?,
                    ~charSet: option(string)=?,
                    ~challenge: option(string)=?,
                    ~capHeight: option(string)=?,
                    ~calcMode: option(string)=?,
                    ~by: option(string)=?,
                    ~bias: option(string)=?,
                    ~begin_: option(string)=?,
                    ~bbox: option(string)=?,
                    ~baseProfile: option(string)=?,
                    ~baselineShift: option(string)=?,
                    ~baseFrequency: option(string)=?,
                    ~azimuth: option(string)=?,
                    ~autoReverse: option(string)=?,
                    ~autoPlay: option(bool)=?,
                    ~autoFocus: option(bool)=?,
                    ~autoComplete: option(string)=?,
                    ~attributeType: option(string)=?,
                    ~attributeName: option(string)=?,
                    ~async: option(bool)=?,
                    ~ascent: option(string)=?,
                    ~ariaValuetext: option(string)=?,
                    ~ariaValuenow: option(float)=?,
                    ~ariaValuemin: option(float)=?,
                    ~ariaValuemax: option(float)=?,
                    ~ariaSort: option(string)=?,
                    ~ariaSetsize: option(int)=?,
                    ~ariaSelected: option(bool)=?,
                    ~ariaRowspan: option(int)=?,
                    ~ariaRowindex: option(int)=?,
                    ~ariaRowcount: option(int)=?,
                    ~ariaRoledescription: option(string)=?,
                    ~ariaRequired: option(bool)=?,
                    ~ariaRelevant: option(string)=?,
                    ~ariaReadonly: option(bool)=?,
                    ~ariaPosinset: option(int)=?,
                    ~ariaPlaceholder: option(string)=?,
                    ~ariaOwns: option(string)=?,
                    ~ariaMultiselectable: option(bool)=?,
                    ~ariaMultiline: option(bool)=?,
                    ~ariaModal: option(bool)=?,
                    ~ariaLevel: option(int)=?,
                    ~ariaLabelledby: option(string)=?,
                    ~ariaLabel: option(string)=?,
                    ~ariaKeyshortcuts: option(string)=?,
                    ~ariaHidden: option(bool)=?,
                    ~ariaGrabbed: option(bool)=?,
                    ~ariaFlowto: option(string)=?,
                    ~ariaExpanded: option(bool)=?,
                    ~ariaErrormessage: option(string)=?,
                    ~ariaDisabled: option(bool)=?,
                    ~ariaDetails: option(string)=?,
                    ~ariaDescribedby: option(string)=?,
                    ~ariaControls: option(string)=?,
                    ~ariaColspan: option(int)=?,
                    ~ariaColindex: option(int)=?,
                    ~ariaColcount: option(int)=?,
                    ~ariaBusy: option(bool)=?,
                    ~ariaAtomic: option(bool)=?,
                    ~ariaActivedescendant: option(string)=?,
                    ~arabicForm: option(string)=?,
                    ~amplitude: option(string)=?,
                    ~alt: option(string)=?,
                    ~alphabetic: option(string)=?,
                    ~allowReorder: option(string)=?,
                    ~allowFullScreen: option(bool)=?,
                    ~alignmentBaseline: option(string)=?,
                    ~additive: option(string)=?,
                    ~action: option(string)=?,
                    ~accumulate: option(string)=?,
                    ~accessKey: option(string)=?,
                    ~acceptCharset: option(string)=?,
                    ~accept: option(string)=?,
                    ~accentHeight: option(string)=?,
                    ~about: option(string)=?,
                    ~children=React.null,
                    ~as_=?,
                    ~innerRef=?,
                    (),
                  ) => {
                as _;
                pub innerRef = innerRef;
                pub as_ = as_;
                pub children = children;
                pub about = about;
                pub accentHeight = accentHeight;
                pub accept = accept;
                pub acceptCharset = acceptCharset;
                pub accessKey = accessKey;
                pub accumulate = accumulate;
                pub action = action;
                pub additive = additive;
                pub alignmentBaseline = alignmentBaseline;
                pub allowFullScreen = allowFullScreen;
                pub allowReorder = allowReorder;
                pub alphabetic = alphabetic;
                pub alt = alt;
                pub amplitude = amplitude;
                pub arabicForm = arabicForm;
                pub ariaActivedescendant = ariaActivedescendant;
                pub ariaAtomic = ariaAtomic;
                pub ariaBusy = ariaBusy;
                pub ariaColcount = ariaColcount;
                pub ariaColindex = ariaColindex;
                pub ariaColspan = ariaColspan;
                pub ariaControls = ariaControls;
                pub ariaDescribedby = ariaDescribedby;
                pub ariaDetails = ariaDetails;
                pub ariaDisabled = ariaDisabled;
                pub ariaErrormessage = ariaErrormessage;
                pub ariaExpanded = ariaExpanded;
                pub ariaFlowto = ariaFlowto;
                pub ariaGrabbed = ariaGrabbed;
                pub ariaHidden = ariaHidden;
                pub ariaKeyshortcuts = ariaKeyshortcuts;
                pub ariaLabel = ariaLabel;
                pub ariaLabelledby = ariaLabelledby;
                pub ariaLevel = ariaLevel;
                pub ariaModal = ariaModal;
                pub ariaMultiline = ariaMultiline;
                pub ariaMultiselectable = ariaMultiselectable;
                pub ariaOwns = ariaOwns;
                pub ariaPlaceholder = ariaPlaceholder;
                pub ariaPosinset = ariaPosinset;
                pub ariaReadonly = ariaReadonly;
                pub ariaRelevant = ariaRelevant;
                pub ariaRequired = ariaRequired;
                pub ariaRoledescription = ariaRoledescription;
                pub ariaRowcount = ariaRowcount;
                pub ariaRowindex = ariaRowindex;
                pub ariaRowspan = ariaRowspan;
                pub ariaSelected = ariaSelected;
                pub ariaSetsize = ariaSetsize;
                pub ariaSort = ariaSort;
                pub ariaValuemax = ariaValuemax;
                pub ariaValuemin = ariaValuemin;
                pub ariaValuenow = ariaValuenow;
                pub ariaValuetext = ariaValuetext;
                pub ascent = ascent;
                pub async = async;
                pub attributeName = attributeName;
                pub attributeType = attributeType;
                pub autoComplete = autoComplete;
                pub autoFocus = autoFocus;
                pub autoPlay = autoPlay;
                pub autoReverse = autoReverse;
                pub azimuth = azimuth;
                pub baseFrequency = baseFrequency;
                pub baselineShift = baselineShift;
                pub baseProfile = baseProfile;
                pub bbox = bbox;
                pub begin_ = begin_;
                pub bias = bias;
                pub by = by;
                pub calcMode = calcMode;
                pub capHeight = capHeight;
                pub challenge = challenge;
                pub charSet = charSet;
                pub checked = checked;
                pub cite = cite;
                pub className = className;
                pub clip = clip;
                pub clipPath = clipPath;
                pub clipPathUnits = clipPathUnits;
                pub clipRule = clipRule;
                pub colorInterpolation = colorInterpolation;
                pub colorInterpolationFilters = colorInterpolationFilters;
                pub colorProfile = colorProfile;
                pub colorRendering = colorRendering;
                pub cols = cols;
                pub colSpan = colSpan;
                pub content = content;
                pub contentEditable = contentEditable;
                pub contentScriptType = contentScriptType;
                pub contentStyleType = contentStyleType;
                pub contextMenu = contextMenu;
                pub controls = controls;
                pub coords = coords;
                pub crossOrigin = crossOrigin;
                pub cursor = cursor;
                pub cx = cx;
                pub cy = cy;
                pub d = d;
                pub data = data;
                pub datatype = datatype;
                pub dateTime = dateTime;
                pub decelerate = decelerate;
                pub default = default;
                pub defaultChecked = defaultChecked;
                pub defaultValue = defaultValue;
                pub defer = defer;
                pub descent = descent;
                pub diffuseConstant = diffuseConstant;
                pub dir = dir;
                pub direction = direction;
                pub disabled = disabled;
                pub display = display;
                pub divisor = divisor;
                pub dominantBaseline = dominantBaseline;
                pub download = download;
                pub draggable = draggable;
                pub dur = dur;
                pub dx = dx;
                pub dy = dy;
                pub edgeMode = edgeMode;
                pub elevation = elevation;
                pub enableBackground = enableBackground;
                pub encType = encType;
                pub end_ = end_;
                pub exponent = exponent;
                pub externalResourcesRequired = externalResourcesRequired;
                pub fill = fill;
                pub fillOpacity = fillOpacity;
                pub fillRule = fillRule;
                pub filter = filter;
                pub filterRes = filterRes;
                pub filterUnits = filterUnits;
                pub floodColor = floodColor;
                pub floodOpacity = floodOpacity;
                pub focusable = focusable;
                pub fomat = fomat;
                pub fontFamily = fontFamily;
                pub fontSize = fontSize;
                pub fontSizeAdjust = fontSizeAdjust;
                pub fontStretch = fontStretch;
                pub fontStyle = fontStyle;
                pub fontVariant = fontVariant;
                pub fontWeight = fontWeight;
                pub form = form;
                pub formAction = formAction;
                pub formMethod = formMethod;
                pub formTarget = formTarget;
                pub from = from;
                pub fx = fx;
                pub fy = fy;
                pub g1 = g1;
                pub g2 = g2;
                pub glyphName = glyphName;
                pub glyphOrientationHorizontal = glyphOrientationHorizontal;
                pub glyphOrientationVertical = glyphOrientationVertical;
                pub glyphRef = glyphRef;
                pub gradientTransform = gradientTransform;
                pub gradientUnits = gradientUnits;
                pub hanging = hanging;
                pub headers = headers;
                pub height = height;
                pub hidden = hidden;
                pub high = high;
                pub horizAdvX = horizAdvX;
                pub horizOriginX = horizOriginX;
                pub href = href;
                pub hrefLang = hrefLang;
                pub htmlFor = htmlFor;
                pub httpEquiv = httpEquiv;
                pub icon = icon;
                pub id = id;
                pub ideographic = ideographic;
                pub imageRendering = imageRendering;
                pub in_ = in_;
                pub in2 = in2;
                pub inlist = inlist;
                pub inputMode = inputMode;
                pub integrity = integrity;
                pub intercept = intercept;
                pub itemID = itemID;
                pub itemProp = itemProp;
                pub itemRef = itemRef;
                pub itemScope = itemScope;
                pub itemType = itemType;
                pub k = k;
                pub k1 = k1;
                pub k2 = k2;
                pub k3 = k3;
                pub k4 = k4;
                pub kernelMatrix = kernelMatrix;
                pub kernelUnitLength = kernelUnitLength;
                pub kerning = kerning;
                pub keyPoints = keyPoints;
                pub keySplines = keySplines;
                pub keyTimes = keyTimes;
                pub keyType = keyType;
                pub kind = kind;
                pub label = label;
                pub lang = lang;
                pub lengthAdjust = lengthAdjust;
                pub letterSpacing = letterSpacing;
                pub lightingColor = lightingColor;
                pub limitingConeAngle = limitingConeAngle;
                pub list = list;
                pub local = local;
                pub loop = loop;
                pub low = low;
                pub manifest = manifest;
                pub markerEnd = markerEnd;
                pub markerHeight = markerHeight;
                pub markerMid = markerMid;
                pub markerStart = markerStart;
                pub markerUnits = markerUnits;
                pub markerWidth = markerWidth;
                pub mask = mask;
                pub maskContentUnits = maskContentUnits;
                pub maskUnits = maskUnits;
                pub mathematical = mathematical;
                pub max = max;
                pub maxLength = maxLength;
                pub media = media;
                pub mediaGroup = mediaGroup;
                pub min = min;
                pub minLength = minLength;
                pub mode = mode;
                pub multiple = multiple;
                pub muted = muted;
                pub name = name;
                pub nonce = nonce;
                pub noValidate = noValidate;
                pub numOctaves = numOctaves;
                pub offset = offset;
                pub opacity = opacity;
                pub open_ = open_;
                pub operator = operator;
                pub optimum = optimum;
                pub order = order;
                pub orient = orient;
                pub orientation = orientation;
                pub origin = origin;
                pub overflow = overflow;
                pub overflowX = overflowX;
                pub overflowY = overflowY;
                pub overlinePosition = overlinePosition;
                pub overlineThickness = overlineThickness;
                pub paintOrder = paintOrder;
                pub panose1 = panose1;
                pub pathLength = pathLength;
                pub pattern = pattern;
                pub patternContentUnits = patternContentUnits;
                pub patternTransform = patternTransform;
                pub patternUnits = patternUnits;
                pub placeholder = placeholder;
                pub pointerEvents = pointerEvents;
                pub points = points;
                pub pointsAtX = pointsAtX;
                pub pointsAtY = pointsAtY;
                pub pointsAtZ = pointsAtZ;
                pub poster = poster;
                pub prefix = prefix;
                pub preload = preload;
                pub preserveAlpha = preserveAlpha;
                pub preserveAspectRatio = preserveAspectRatio;
                pub primitiveUnits = primitiveUnits;
                pub property = property;
                pub r = r;
                pub radioGroup = radioGroup;
                pub radius = radius;
                pub readOnly = readOnly;
                pub refX = refX;
                pub refY = refY;
                pub rel = rel;
                pub renderingIntent = renderingIntent;
                pub repeatCount = repeatCount;
                pub repeatDur = repeatDur;
                pub required = required;
                pub requiredExtensions = requiredExtensions;
                pub requiredFeatures = requiredFeatures;
                pub resource = resource;
                pub restart = restart;
                pub result = result;
                pub reversed = reversed;
                pub role = role;
                pub rotate = rotate;
                pub rows = rows;
                pub rowSpan = rowSpan;
                pub rx = rx;
                pub ry = ry;
                pub sandbox = sandbox;
                pub scale = scale;
                pub scope = scope;
                pub scoped = scoped;
                pub scrolling = scrolling;
                pub seed = seed;
                pub selected = selected;
                pub shape = shape;
                pub shapeRendering = shapeRendering;
                pub size = size;
                pub sizes = sizes;
                pub slope = slope;
                pub spacing = spacing;
                pub span = span;
                pub specularConstant = specularConstant;
                pub specularExponent = specularExponent;
                pub speed = speed;
                pub spellCheck = spellCheck;
                pub spreadMethod = spreadMethod;
                pub src = src;
                pub srcDoc = srcDoc;
                pub srcLang = srcLang;
                pub srcSet = srcSet;
                pub start = start;
                pub startOffset = startOffset;
                pub stdDeviation = stdDeviation;
                pub stemh = stemh;
                pub stemv = stemv;
                pub step = step;
                pub stitchTiles = stitchTiles;
                pub stopColor = stopColor;
                pub stopOpacity = stopOpacity;
                pub strikethroughPosition = strikethroughPosition;
                pub strikethroughThickness = strikethroughThickness;
                pub stroke = stroke;
                pub strokeDasharray = strokeDasharray;
                pub strokeDashoffset = strokeDashoffset;
                pub strokeLinecap = strokeLinecap;
                pub strokeLinejoin = strokeLinejoin;
                pub strokeMiterlimit = strokeMiterlimit;
                pub strokeOpacity = strokeOpacity;
                pub strokeWidth = strokeWidth;
                pub style = style;
                pub summary = summary;
                pub suppressContentEditableWarning = suppressContentEditableWarning;
                pub surfaceScale = surfaceScale;
                pub systemLanguage = systemLanguage;
                pub tabIndex = tabIndex;
                pub tableValues = tableValues;
                pub target = target;
                pub targetX = targetX;
                pub targetY = targetY;
                pub textAnchor = textAnchor;
                pub textDecoration = textDecoration;
                pub textLength = textLength;
                pub textRendering = textRendering;
                pub title = title;
                pub to_ = to_;
                pub transform = transform;
                pub type_ = type_;
                pub typeof = typeof;
                pub u1 = u1;
                pub u2 = u2;
                pub underlinePosition = underlinePosition;
                pub underlineThickness = underlineThickness;
                pub unicode = unicode;
                pub unicodeBidi = unicodeBidi;
                pub unicodeRange = unicodeRange;
                pub unitsPerEm = unitsPerEm;
                pub useMap = useMap;
                pub vAlphabetic = vAlphabetic;
                pub value = value;
                pub values = values;
                pub vectorEffect = vectorEffect;
                pub version = version;
                pub vertAdvX = vertAdvX;
                pub vertAdvY = vertAdvY;
                pub vertOriginX = vertOriginX;
                pub vertOriginY = vertOriginY;
                pub vHanging = vHanging;
                pub vIdeographic = vIdeographic;
                pub viewBox = viewBox;
                pub viewTarget = viewTarget;
                pub visibility = visibility;
                pub vMathematical = vMathematical;
                pub vocab = vocab;
                pub width = width;
                pub widths = widths;
                pub wordSpacing = wordSpacing;
                pub wrap = wrap;
                pub writingMode = writingMode;
                pub x = x;
                pub x1 = x1;
                pub x2 = x2;
                pub xChannelSelector = xChannelSelector;
                pub xHeight = xHeight;
                pub xlinkActuate = xlinkActuate;
                pub xlinkArcrole = xlinkArcrole;
                pub xlinkHref = xlinkHref;
                pub xlinkRole = xlinkRole;
                pub xlinkShow = xlinkShow;
                pub xlinkTitle = xlinkTitle;
                pub xlinkType = xlinkType;
                pub xmlBase = xmlBase;
                pub xmlLang = xmlLang;
                pub xmlns = xmlns;
                pub xmlnsXlink = xmlnsXlink;
                pub xmlSpace = xmlSpace;
                pub y = y;
                pub y1 = y1;
                pub y2 = y2;
                pub yChannelSelector = yChannelSelector;
                pub z = z;
                pub zoomAndPan = zoomAndPan;
                pub onAbort = onAbort;
                pub onAnimationEnd = onAnimationEnd;
                pub onAnimationIteration = onAnimationIteration;
                pub onAnimationStart = onAnimationStart;
                pub onBlur = onBlur;
                pub onCanPlay = onCanPlay;
                pub onCanPlayThrough = onCanPlayThrough;
                pub onChange = onChange;
                pub onClick = onClick;
                pub onCompositionEnd = onCompositionEnd;
                pub onCompositionStart = onCompositionStart;
                pub onCompositionUpdate = onCompositionUpdate;
                pub onContextMenu = onContextMenu;
                pub onCopy = onCopy;
                pub onCut = onCut;
                pub onDoubleClick = onDoubleClick;
                pub onDrag = onDrag;
                pub onDragEnd = onDragEnd;
                pub onDragEnter = onDragEnter;
                pub onDragExit = onDragExit;
                pub onDragLeave = onDragLeave;
                pub onDragOver = onDragOver;
                pub onDragStart = onDragStart;
                pub onDrop = onDrop;
                pub onDurationChange = onDurationChange;
                pub onEmptied = onEmptied;
                pub onEncrypetd = onEncrypetd;
                pub onEnded = onEnded;
                pub onError = onError;
                pub onFocus = onFocus;
                pub onInput = onInput;
                pub onKeyDown = onKeyDown;
                pub onKeyPress = onKeyPress;
                pub onKeyUp = onKeyUp;
                pub onLoadedData = onLoadedData;
                pub onLoadedMetadata = onLoadedMetadata;
                pub onLoadStart = onLoadStart;
                pub onMouseDown = onMouseDown;
                pub onMouseEnter = onMouseEnter;
                pub onMouseLeave = onMouseLeave;
                pub onMouseMove = onMouseMove;
                pub onMouseOut = onMouseOut;
                pub onMouseOver = onMouseOver;
                pub onMouseUp = onMouseUp;
                pub onPaste = onPaste;
                pub onPause = onPause;
                pub onPlay = onPlay;
                pub onPlaying = onPlaying;
                pub onProgress = onProgress;
                pub onRateChange = onRateChange;
                pub onScroll = onScroll;
                pub onSeeked = onSeeked;
                pub onSeeking = onSeeking;
                pub onSelect = onSelect;
                pub onStalled = onStalled;
                pub onSubmit = onSubmit;
                pub onSuspend = onSuspend;
                pub onTimeUpdate = onTimeUpdate;
                pub onTouchCancel = onTouchCancel;
                pub onTouchEnd = onTouchEnd;
                pub onTouchMove = onTouchMove;
                pub onTouchStart = onTouchStart;
                pub onTransitionEnd = onTransitionEnd;
                pub onVolumeChange = onVolumeChange;
                pub onWaiting = onWaiting;
                pub onWheel = onWheel
              };
              let make = (~key=?, props) =>
                make(
                  (),
                  ~key?,
                  ~innerRef=?props#innerRef,
                  ~as_=?props#as_,
                  ~children=props#children,
                  ~about=?props#about,
                  ~accentHeight=?props#accentHeight,
                  ~accept=?props#accept,
                  ~acceptCharset=?props#acceptCharset,
                  ~accessKey=?props#accessKey,
                  ~accumulate=?props#accumulate,
                  ~action=?props#action,
                  ~additive=?props#additive,
                  ~alignmentBaseline=?props#alignmentBaseline,
                  ~allowFullScreen=?props#allowFullScreen,
                  ~allowReorder=?props#allowReorder,
                  ~alphabetic=?props#alphabetic,
                  ~alt=?props#alt,
                  ~amplitude=?props#amplitude,
                  ~arabicForm=?props#arabicForm,
                  ~ariaActivedescendant=?props#ariaActivedescendant,
                  ~ariaAtomic=?props#ariaAtomic,
                  ~ariaBusy=?props#ariaBusy,
                  ~ariaColcount=?props#ariaColcount,
                  ~ariaColindex=?props#ariaColindex,
                  ~ariaColspan=?props#ariaColspan,
                  ~ariaControls=?props#ariaControls,
                  ~ariaDescribedby=?props#ariaDescribedby,
                  ~ariaDetails=?props#ariaDetails,
                  ~ariaDisabled=?props#ariaDisabled,
                  ~ariaErrormessage=?props#ariaErrormessage,
                  ~ariaExpanded=?props#ariaExpanded,
                  ~ariaFlowto=?props#ariaFlowto,
                  ~ariaGrabbed=?props#ariaGrabbed,
                  ~ariaHidden=?props#ariaHidden,
                  ~ariaKeyshortcuts=?props#ariaKeyshortcuts,
                  ~ariaLabel=?props#ariaLabel,
                  ~ariaLabelledby=?props#ariaLabelledby,
                  ~ariaLevel=?props#ariaLevel,
                  ~ariaModal=?props#ariaModal,
                  ~ariaMultiline=?props#ariaMultiline,
                  ~ariaMultiselectable=?props#ariaMultiselectable,
                  ~ariaOwns=?props#ariaOwns,
                  ~ariaPlaceholder=?props#ariaPlaceholder,
                  ~ariaPosinset=?props#ariaPosinset,
                  ~ariaReadonly=?props#ariaReadonly,
                  ~ariaRelevant=?props#ariaRelevant,
                  ~ariaRequired=?props#ariaRequired,
                  ~ariaRoledescription=?props#ariaRoledescription,
                  ~ariaRowcount=?props#ariaRowcount,
                  ~ariaRowindex=?props#ariaRowindex,
                  ~ariaRowspan=?props#ariaRowspan,
                  ~ariaSelected=?props#ariaSelected,
                  ~ariaSetsize=?props#ariaSetsize,
                  ~ariaSort=?props#ariaSort,
                  ~ariaValuemax=?props#ariaValuemax,
                  ~ariaValuemin=?props#ariaValuemin,
                  ~ariaValuenow=?props#ariaValuenow,
                  ~ariaValuetext=?props#ariaValuetext,
                  ~ascent=?props#ascent,
                  ~async=?props#async,
                  ~attributeName=?props#attributeName,
                  ~attributeType=?props#attributeType,
                  ~autoComplete=?props#autoComplete,
                  ~autoFocus=?props#autoFocus,
                  ~autoPlay=?props#autoPlay,
                  ~autoReverse=?props#autoReverse,
                  ~azimuth=?props#azimuth,
                  ~baseFrequency=?props#baseFrequency,
                  ~baselineShift=?props#baselineShift,
                  ~baseProfile=?props#baseProfile,
                  ~bbox=?props#bbox,
                  ~begin_=?props#begin_,
                  ~bias=?props#bias,
                  ~by=?props#by,
                  ~calcMode=?props#calcMode,
                  ~capHeight=?props#capHeight,
                  ~challenge=?props#challenge,
                  ~charSet=?props#charSet,
                  ~checked=?props#checked,
                  ~cite=?props#cite,
                  ~className=?props#className,
                  ~clip=?props#clip,
                  ~clipPath=?props#clipPath,
                  ~clipPathUnits=?props#clipPathUnits,
                  ~clipRule=?props#clipRule,
                  ~colorInterpolation=?props#colorInterpolation,
                  ~colorInterpolationFilters=?props#colorInterpolationFilters,
                  ~colorProfile=?props#colorProfile,
                  ~colorRendering=?props#colorRendering,
                  ~cols=?props#cols,
                  ~colSpan=?props#colSpan,
                  ~content=?props#content,
                  ~contentEditable=?props#contentEditable,
                  ~contentScriptType=?props#contentScriptType,
                  ~contentStyleType=?props#contentStyleType,
                  ~contextMenu=?props#contextMenu,
                  ~controls=?props#controls,
                  ~coords=?props#coords,
                  ~crossOrigin=?props#crossOrigin,
                  ~cursor=?props#cursor,
                  ~cx=?props#cx,
                  ~cy=?props#cy,
                  ~d=?props#d,
                  ~data=?props#data,
                  ~datatype=?props#datatype,
                  ~dateTime=?props#dateTime,
                  ~decelerate=?props#decelerate,
                  ~default=?props#default,
                  ~defaultChecked=?props#defaultChecked,
                  ~defaultValue=?props#defaultValue,
                  ~defer=?props#defer,
                  ~descent=?props#descent,
                  ~diffuseConstant=?props#diffuseConstant,
                  ~dir=?props#dir,
                  ~direction=?props#direction,
                  ~disabled=?props#disabled,
                  ~display=?props#display,
                  ~divisor=?props#divisor,
                  ~dominantBaseline=?props#dominantBaseline,
                  ~download=?props#download,
                  ~draggable=?props#draggable,
                  ~dur=?props#dur,
                  ~dx=?props#dx,
                  ~dy=?props#dy,
                  ~edgeMode=?props#edgeMode,
                  ~elevation=?props#elevation,
                  ~enableBackground=?props#enableBackground,
                  ~encType=?props#encType,
                  ~end_=?props#end_,
                  ~exponent=?props#exponent,
                  ~externalResourcesRequired=?props#externalResourcesRequired,
                  ~fill=?props#fill,
                  ~fillOpacity=?props#fillOpacity,
                  ~fillRule=?props#fillRule,
                  ~filter=?props#filter,
                  ~filterRes=?props#filterRes,
                  ~filterUnits=?props#filterUnits,
                  ~floodColor=?props#floodColor,
                  ~floodOpacity=?props#floodOpacity,
                  ~focusable=?props#focusable,
                  ~fomat=?props#fomat,
                  ~fontFamily=?props#fontFamily,
                  ~fontSize=?props#fontSize,
                  ~fontSizeAdjust=?props#fontSizeAdjust,
                  ~fontStretch=?props#fontStretch,
                  ~fontStyle=?props#fontStyle,
                  ~fontVariant=?props#fontVariant,
                  ~fontWeight=?props#fontWeight,
                  ~form=?props#form,
                  ~formAction=?props#formAction,
                  ~formMethod=?props#formMethod,
                  ~formTarget=?props#formTarget,
                  ~from=?props#from,
                  ~fx=?props#fx,
                  ~fy=?props#fy,
                  ~g1=?props#g1,
                  ~g2=?props#g2,
                  ~glyphName=?props#glyphName,
                  ~glyphOrientationHorizontal=?props#glyphOrientationHorizontal,
                  ~glyphOrientationVertical=?props#glyphOrientationVertical,
                  ~glyphRef=?props#glyphRef,
                  ~gradientTransform=?props#gradientTransform,
                  ~gradientUnits=?props#gradientUnits,
                  ~hanging=?props#hanging,
                  ~headers=?props#headers,
                  ~height=?props#height,
                  ~hidden=?props#hidden,
                  ~high=?props#high,
                  ~horizAdvX=?props#horizAdvX,
                  ~horizOriginX=?props#horizOriginX,
                  ~href=?props#href,
                  ~hrefLang=?props#hrefLang,
                  ~htmlFor=?props#htmlFor,
                  ~httpEquiv=?props#httpEquiv,
                  ~icon=?props#icon,
                  ~id=?props#id,
                  ~ideographic=?props#ideographic,
                  ~imageRendering=?props#imageRendering,
                  ~in_=?props#in_,
                  ~in2=?props#in2,
                  ~inlist=?props#inlist,
                  ~inputMode=?props#inputMode,
                  ~integrity=?props#integrity,
                  ~intercept=?props#intercept,
                  ~itemID=?props#itemID,
                  ~itemProp=?props#itemProp,
                  ~itemRef=?props#itemRef,
                  ~itemScope=?props#itemScope,
                  ~itemType=?props#itemType,
                  ~k=?props#k,
                  ~k1=?props#k1,
                  ~k2=?props#k2,
                  ~k3=?props#k3,
                  ~k4=?props#k4,
                  ~kernelMatrix=?props#kernelMatrix,
                  ~kernelUnitLength=?props#kernelUnitLength,
                  ~kerning=?props#kerning,
                  ~keyPoints=?props#keyPoints,
                  ~keySplines=?props#keySplines,
                  ~keyTimes=?props#keyTimes,
                  ~keyType=?props#keyType,
                  ~kind=?props#kind,
                  ~label=?props#label,
                  ~lang=?props#lang,
                  ~lengthAdjust=?props#lengthAdjust,
                  ~letterSpacing=?props#letterSpacing,
                  ~lightingColor=?props#lightingColor,
                  ~limitingConeAngle=?props#limitingConeAngle,
                  ~list=?props#list,
                  ~local=?props#local,
                  ~loop=?props#loop,
                  ~low=?props#low,
                  ~manifest=?props#manifest,
                  ~markerEnd=?props#markerEnd,
                  ~markerHeight=?props#markerHeight,
                  ~markerMid=?props#markerMid,
                  ~markerStart=?props#markerStart,
                  ~markerUnits=?props#markerUnits,
                  ~markerWidth=?props#markerWidth,
                  ~mask=?props#mask,
                  ~maskContentUnits=?props#maskContentUnits,
                  ~maskUnits=?props#maskUnits,
                  ~mathematical=?props#mathematical,
                  ~max=?props#max,
                  ~maxLength=?props#maxLength,
                  ~media=?props#media,
                  ~mediaGroup=?props#mediaGroup,
                  ~min=?props#min,
                  ~minLength=?props#minLength,
                  ~mode=?props#mode,
                  ~multiple=?props#multiple,
                  ~muted=?props#muted,
                  ~name=?props#name,
                  ~nonce=?props#nonce,
                  ~noValidate=?props#noValidate,
                  ~numOctaves=?props#numOctaves,
                  ~offset=?props#offset,
                  ~opacity=?props#opacity,
                  ~open_=?props#open_,
                  ~operator=?props#operator,
                  ~optimum=?props#optimum,
                  ~order=?props#order,
                  ~orient=?props#orient,
                  ~orientation=?props#orientation,
                  ~origin=?props#origin,
                  ~overflow=?props#overflow,
                  ~overflowX=?props#overflowX,
                  ~overflowY=?props#overflowY,
                  ~overlinePosition=?props#overlinePosition,
                  ~overlineThickness=?props#overlineThickness,
                  ~paintOrder=?props#paintOrder,
                  ~panose1=?props#panose1,
                  ~pathLength=?props#pathLength,
                  ~pattern=?props#pattern,
                  ~patternContentUnits=?props#patternContentUnits,
                  ~patternTransform=?props#patternTransform,
                  ~patternUnits=?props#patternUnits,
                  ~placeholder=?props#placeholder,
                  ~pointerEvents=?props#pointerEvents,
                  ~points=?props#points,
                  ~pointsAtX=?props#pointsAtX,
                  ~pointsAtY=?props#pointsAtY,
                  ~pointsAtZ=?props#pointsAtZ,
                  ~poster=?props#poster,
                  ~prefix=?props#prefix,
                  ~preload=?props#preload,
                  ~preserveAlpha=?props#preserveAlpha,
                  ~preserveAspectRatio=?props#preserveAspectRatio,
                  ~primitiveUnits=?props#primitiveUnits,
                  ~property=?props#property,
                  ~r=?props#r,
                  ~radioGroup=?props#radioGroup,
                  ~radius=?props#radius,
                  ~readOnly=?props#readOnly,
                  ~refX=?props#refX,
                  ~refY=?props#refY,
                  ~rel=?props#rel,
                  ~renderingIntent=?props#renderingIntent,
                  ~repeatCount=?props#repeatCount,
                  ~repeatDur=?props#repeatDur,
                  ~required=?props#required,
                  ~requiredExtensions=?props#requiredExtensions,
                  ~requiredFeatures=?props#requiredFeatures,
                  ~resource=?props#resource,
                  ~restart=?props#restart,
                  ~result=?props#result,
                  ~reversed=?props#reversed,
                  ~role=?props#role,
                  ~rotate=?props#rotate,
                  ~rows=?props#rows,
                  ~rowSpan=?props#rowSpan,
                  ~rx=?props#rx,
                  ~ry=?props#ry,
                  ~sandbox=?props#sandbox,
                  ~scale=?props#scale,
                  ~scope=?props#scope,
                  ~scoped=?props#scoped,
                  ~scrolling=?props#scrolling,
                  ~seed=?props#seed,
                  ~selected=?props#selected,
                  ~shape=?props#shape,
                  ~shapeRendering=?props#shapeRendering,
                  ~size=?props#size,
                  ~sizes=?props#sizes,
                  ~slope=?props#slope,
                  ~spacing=?props#spacing,
                  ~span=?props#span,
                  ~specularConstant=?props#specularConstant,
                  ~specularExponent=?props#specularExponent,
                  ~speed=?props#speed,
                  ~spellCheck=?props#spellCheck,
                  ~spreadMethod=?props#spreadMethod,
                  ~src=?props#src,
                  ~srcDoc=?props#srcDoc,
                  ~srcLang=?props#srcLang,
                  ~srcSet=?props#srcSet,
                  ~start=?props#start,
                  ~startOffset=?props#startOffset,
                  ~stdDeviation=?props#stdDeviation,
                  ~stemh=?props#stemh,
                  ~stemv=?props#stemv,
                  ~step=?props#step,
                  ~stitchTiles=?props#stitchTiles,
                  ~stopColor=?props#stopColor,
                  ~stopOpacity=?props#stopOpacity,
                  ~strikethroughPosition=?props#strikethroughPosition,
                  ~strikethroughThickness=?props#strikethroughThickness,
                  ~stroke=?props#stroke,
                  ~strokeDasharray=?props#strokeDasharray,
                  ~strokeDashoffset=?props#strokeDashoffset,
                  ~strokeLinecap=?props#strokeLinecap,
                  ~strokeLinejoin=?props#strokeLinejoin,
                  ~strokeMiterlimit=?props#strokeMiterlimit,
                  ~strokeOpacity=?props#strokeOpacity,
                  ~strokeWidth=?props#strokeWidth,
                  ~style=?props#style,
                  ~summary=?props#summary,
                  ~suppressContentEditableWarning=?
                    props#suppressContentEditableWarning,
                  ~surfaceScale=?props#surfaceScale,
                  ~systemLanguage=?props#systemLanguage,
                  ~tabIndex=?props#tabIndex,
                  ~tableValues=?props#tableValues,
                  ~target=?props#target,
                  ~targetX=?props#targetX,
                  ~targetY=?props#targetY,
                  ~textAnchor=?props#textAnchor,
                  ~textDecoration=?props#textDecoration,
                  ~textLength=?props#textLength,
                  ~textRendering=?props#textRendering,
                  ~title=?props#title,
                  ~to_=?props#to_,
                  ~transform=?props#transform,
                  ~type_=?props#type_,
                  ~typeof=?props#typeof,
                  ~u1=?props#u1,
                  ~u2=?props#u2,
                  ~underlinePosition=?props#underlinePosition,
                  ~underlineThickness=?props#underlineThickness,
                  ~unicode=?props#unicode,
                  ~unicodeBidi=?props#unicodeBidi,
                  ~unicodeRange=?props#unicodeRange,
                  ~unitsPerEm=?props#unitsPerEm,
                  ~useMap=?props#useMap,
                  ~vAlphabetic=?props#vAlphabetic,
                  ~value=?props#value,
                  ~values=?props#values,
                  ~vectorEffect=?props#vectorEffect,
                  ~version=?props#version,
                  ~vertAdvX=?props#vertAdvX,
                  ~vertAdvY=?props#vertAdvY,
                  ~vertOriginX=?props#vertOriginX,
                  ~vertOriginY=?props#vertOriginY,
                  ~vHanging=?props#vHanging,
                  ~vIdeographic=?props#vIdeographic,
                  ~viewBox=?props#viewBox,
                  ~viewTarget=?props#viewTarget,
                  ~visibility=?props#visibility,
                  ~vMathematical=?props#vMathematical,
                  ~vocab=?props#vocab,
                  ~width=?props#width,
                  ~widths=?props#widths,
                  ~wordSpacing=?props#wordSpacing,
                  ~wrap=?props#wrap,
                  ~writingMode=?props#writingMode,
                  ~x=?props#x,
                  ~x1=?props#x1,
                  ~x2=?props#x2,
                  ~xChannelSelector=?props#xChannelSelector,
                  ~xHeight=?props#xHeight,
                  ~xlinkActuate=?props#xlinkActuate,
                  ~xlinkArcrole=?props#xlinkArcrole,
                  ~xlinkHref=?props#xlinkHref,
                  ~xlinkRole=?props#xlinkRole,
                  ~xlinkShow=?props#xlinkShow,
                  ~xlinkTitle=?props#xlinkTitle,
                  ~xlinkType=?props#xlinkType,
                  ~xmlBase=?props#xmlBase,
                  ~xmlLang=?props#xmlLang,
                  ~xmlns=?props#xmlns,
                  ~xmlnsXlink=?props#xmlnsXlink,
                  ~xmlSpace=?props#xmlSpace,
                  ~y=?props#y,
                  ~y1=?props#y1,
                  ~y2=?props#y2,
                  ~yChannelSelector=?props#yChannelSelector,
                  ~z=?props#z,
                  ~zoomAndPan=?props#zoomAndPan,
                  ~onAbort=?props#onAbort,
                  ~onAnimationEnd=?props#onAnimationEnd,
                  ~onAnimationIteration=?props#onAnimationIteration,
                  ~onAnimationStart=?props#onAnimationStart,
                  ~onBlur=?props#onBlur,
                  ~onCanPlay=?props#onCanPlay,
                  ~onCanPlayThrough=?props#onCanPlayThrough,
                  ~onChange=?props#onChange,
                  ~onClick=?props#onClick,
                  ~onCompositionEnd=?props#onCompositionEnd,
                  ~onCompositionStart=?props#onCompositionStart,
                  ~onCompositionUpdate=?props#onCompositionUpdate,
                  ~onContextMenu=?props#onContextMenu,
                  ~onCopy=?props#onCopy,
                  ~onCut=?props#onCut,
                  ~onDoubleClick=?props#onDoubleClick,
                  ~onDrag=?props#onDrag,
                  ~onDragEnd=?props#onDragEnd,
                  ~onDragEnter=?props#onDragEnter,
                  ~onDragExit=?props#onDragExit,
                  ~onDragLeave=?props#onDragLeave,
                  ~onDragOver=?props#onDragOver,
                  ~onDragStart=?props#onDragStart,
                  ~onDrop=?props#onDrop,
                  ~onDurationChange=?props#onDurationChange,
                  ~onEmptied=?props#onEmptied,
                  ~onEncrypetd=?props#onEncrypetd,
                  ~onEnded=?props#onEnded,
                  ~onError=?props#onError,
                  ~onFocus=?props#onFocus,
                  ~onInput=?props#onInput,
                  ~onKeyDown=?props#onKeyDown,
                  ~onKeyPress=?props#onKeyPress,
                  ~onKeyUp=?props#onKeyUp,
                  ~onLoadedData=?props#onLoadedData,
                  ~onLoadedMetadata=?props#onLoadedMetadata,
                  ~onLoadStart=?props#onLoadStart,
                  ~onMouseDown=?props#onMouseDown,
                  ~onMouseEnter=?props#onMouseEnter,
                  ~onMouseLeave=?props#onMouseLeave,
                  ~onMouseMove=?props#onMouseMove,
                  ~onMouseOut=?props#onMouseOut,
                  ~onMouseOver=?props#onMouseOver,
                  ~onMouseUp=?props#onMouseUp,
                  ~onPaste=?props#onPaste,
                  ~onPause=?props#onPause,
                  ~onPlay=?props#onPlay,
                  ~onPlaying=?props#onPlaying,
                  ~onProgress=?props#onProgress,
                  ~onRateChange=?props#onRateChange,
                  ~onScroll=?props#onScroll,
                  ~onSeeked=?props#onSeeked,
                  ~onSeeking=?props#onSeeking,
                  ~onSelect=?props#onSelect,
                  ~onStalled=?props#onStalled,
                  ~onSubmit=?props#onSubmit,
                  ~onSuspend=?props#onSuspend,
                  ~onTimeUpdate=?props#onTimeUpdate,
                  ~onTouchCancel=?props#onTouchCancel,
                  ~onTouchEnd=?props#onTouchEnd,
                  ~onTouchMove=?props#onTouchMove,
                  ~onTouchStart=?props#onTouchStart,
                  ~onTransitionEnd=?props#onTransitionEnd,
                  ~onVolumeChange=?props#onVolumeChange,
                  ~onWaiting=?props#onWaiting,
                  ~onWheel=?props#onWheel,
                );
            };
  };
