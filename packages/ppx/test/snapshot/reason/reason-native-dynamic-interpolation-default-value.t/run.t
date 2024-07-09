  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --native --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module DynamicComponentWithDefaultValue = {
    let getOrEmpty = str =>
      switch (str) {
      | Some(str) => " " ++ str
      | None => ""
      };
    let styles = (~var=CSS.hex("333"), _) =>
      CSS.style([|
        CSS.label("DynamicComponentWithDefaultValue"),
        CSS.display(`block),
        (CSS.color(var): CSS.rule),
      |]);
    let make =
        (
          ~var=?,
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
          ~onCompositionUpdate: option(React.Event.Composition.t => unit)=?,
          ~onCompositionStart: option(React.Event.Composition.t => unit)=?,
          ~onCompositionEnd: option(React.Event.Composition.t => unit)=?,
          ~onClick: option(React.Event.Mouse.t => unit)=?,
          ~onChange: option(React.Event.Form.t => unit)=?,
          ~onCanPlayThrough: option(React.Event.Media.t => unit)=?,
          ~onCanPlay: option(React.Event.Media.t => unit)=?,
          ~onBlur: option(React.Event.Focus.t => unit)=?,
          ~onAnimationStart: option(React.Event.Animation.t => unit)=?,
          ~onAnimationIteration: option(React.Event.Animation.t => unit)=?,
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
      let className = styles(~var?, ()) ++ getOrEmpty(className);
      React.createElement(
        switch (as_) {
        | Some(v) => v
        | None => "div"
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
  };
