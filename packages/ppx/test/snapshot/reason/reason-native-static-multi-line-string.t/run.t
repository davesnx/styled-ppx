  $ refmt --parse re --print ml input.re > output.ml
  $ ../../../standalone.exe --native --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  [@css ".css-k008qs-MultiLineStrings{display:flex;}"];
  [@css ".css-1tyndxa-MultiLineStrings{justify-content:center;}"];
  [@css.bindings
    [
      (
        "Output.MultiLineStrings",
        "css-k008qs-MultiLineStrings css-1tyndxa-MultiLineStrings",
      ),
    ]
  ];
  module MultiLineStrings: {
    type makeProps;
    let make: makeProps => React.element;
  } = {
    [@deriving abstract]
    [@warning "-69"]
    type makeProps = {
      [@optional]
      innerRef: option(ReactDOM.domRef),
      [@optional]
      children: option(React.element),
      [@optional] [@mel.as "as"]
      as_: option(string),
      [@optional]
      about: option(string),
      [@optional]
      accentHeight: option(string),
      [@optional]
      accept: option(string),
      [@optional]
      acceptCharset: option(string),
      [@optional]
      accessKey: option(string),
      [@optional]
      accumulate: option(string),
      [@optional]
      action: option(string),
      [@optional]
      additive: option(string),
      [@optional]
      alignmentBaseline: option(string),
      [@optional]
      allowFullScreen: option(bool),
      [@optional]
      allowReorder: option(string),
      [@optional]
      alphabetic: option(string),
      [@optional]
      alt: option(string),
      [@optional]
      amplitude: option(string),
      [@optional]
      arabicForm: option(string),
      [@optional] [@mel.as "aria-activedescendant"]
      ariaActivedescendant: option(string),
      [@optional] [@mel.as "aria-atomic"]
      ariaAtomic: option(bool),
      [@optional] [@mel.as "aria-busy"]
      ariaBusy: option(bool),
      [@optional] [@mel.as "aria-colcount"]
      ariaColcount: option(int),
      [@optional] [@mel.as "aria-colindex"]
      ariaColindex: option(int),
      [@optional] [@mel.as "aria-colspan"]
      ariaColspan: option(int),
      [@optional] [@mel.as "aria-controls"]
      ariaControls: option(string),
      [@optional] [@mel.as "aria-describedby"]
      ariaDescribedby: option(string),
      [@optional] [@mel.as "aria-details"]
      ariaDetails: option(string),
      [@optional] [@mel.as "aria-disabled"]
      ariaDisabled: option(bool),
      [@optional] [@mel.as "aria-errormessage"]
      ariaErrormessage: option(string),
      [@optional] [@mel.as "aria-expanded"]
      ariaExpanded: option(bool),
      [@optional] [@mel.as "aria-flowto"]
      ariaFlowto: option(string),
      [@optional] [@mel.as "aria-grabbed"]
      ariaGrabbed: option(bool),
      [@optional] [@mel.as "aria-hidden"]
      ariaHidden: option(bool),
      [@optional] [@mel.as "aria-keyshortcuts"]
      ariaKeyshortcuts: option(string),
      [@optional] [@mel.as "aria-label"]
      ariaLabel: option(string),
      [@optional] [@mel.as "aria-labelledby"]
      ariaLabelledby: option(string),
      [@optional] [@mel.as "aria-level"]
      ariaLevel: option(int),
      [@optional] [@mel.as "aria-modal"]
      ariaModal: option(bool),
      [@optional] [@mel.as "aria-multiline"]
      ariaMultiline: option(bool),
      [@optional] [@mel.as "aria-multiselectable"]
      ariaMultiselectable: option(bool),
      [@optional] [@mel.as "aria-owns"]
      ariaOwns: option(string),
      [@optional] [@mel.as "aria-placeholder"]
      ariaPlaceholder: option(string),
      [@optional] [@mel.as "aria-posinset"]
      ariaPosinset: option(int),
      [@optional] [@mel.as "aria-readonly"]
      ariaReadonly: option(bool),
      [@optional] [@mel.as "aria-relevant"]
      ariaRelevant: option(string),
      [@optional] [@mel.as "aria-required"]
      ariaRequired: option(bool),
      [@optional] [@mel.as "aria-roledescription"]
      ariaRoledescription: option(string),
      [@optional] [@mel.as "aria-rowcount"]
      ariaRowcount: option(int),
      [@optional] [@mel.as "aria-rowindex"]
      ariaRowindex: option(int),
      [@optional] [@mel.as "aria-rowspan"]
      ariaRowspan: option(int),
      [@optional] [@mel.as "aria-selected"]
      ariaSelected: option(bool),
      [@optional] [@mel.as "aria-setsize"]
      ariaSetsize: option(int),
      [@optional] [@mel.as "aria-sort"]
      ariaSort: option(string),
      [@optional] [@mel.as "aria-valuemax"]
      ariaValuemax: option(float),
      [@optional] [@mel.as "aria-valuemin"]
      ariaValuemin: option(float),
      [@optional] [@mel.as "aria-valuenow"]
      ariaValuenow: option(float),
      [@optional] [@mel.as "aria-valuetext"]
      ariaValuetext: option(string),
      [@optional]
      ascent: option(string),
      [@optional]
      async: option(bool),
      [@optional]
      attributeName: option(string),
      [@optional]
      attributeType: option(string),
      [@optional]
      autoComplete: option(string),
      [@optional]
      autoFocus: option(bool),
      [@optional]
      autoPlay: option(bool),
      [@optional]
      autoReverse: option(string),
      [@optional]
      azimuth: option(string),
      [@optional]
      baseFrequency: option(string),
      [@optional]
      baselineShift: option(string),
      [@optional]
      baseProfile: option(string),
      [@optional]
      bbox: option(string),
      [@optional]
      begin_: option(string),
      [@optional]
      bias: option(string),
      [@optional]
      by: option(string),
      [@optional]
      calcMode: option(string),
      [@optional]
      capHeight: option(string),
      [@optional]
      challenge: option(string),
      [@optional]
      charSet: option(string),
      [@optional]
      checked: option(bool),
      [@optional]
      cite: option(string),
      [@optional]
      className: option(string),
      [@optional]
      clip: option(string),
      [@optional]
      clipPath: option(string),
      [@optional]
      clipPathUnits: option(string),
      [@optional]
      clipRule: option(string),
      [@optional]
      colorInterpolation: option(string),
      [@optional]
      colorInterpolationFilters: option(string),
      [@optional]
      colorProfile: option(string),
      [@optional]
      colorRendering: option(string),
      [@optional]
      cols: option(int),
      [@optional]
      colSpan: option(int),
      [@optional]
      content: option(string),
      [@optional]
      contentEditable: option(bool),
      [@optional]
      contentScriptType: option(string),
      [@optional]
      contentStyleType: option(string),
      [@optional]
      contextMenu: option(string),
      [@optional]
      controls: option(bool),
      [@optional]
      coords: option(string),
      [@optional]
      crossOrigin: option(string),
      [@optional]
      cursor: option(string),
      [@optional]
      cx: option(string),
      [@optional]
      cy: option(string),
      [@optional]
      d: option(string),
      [@optional]
      data: option(string),
      [@optional]
      datatype: option(string),
      [@optional]
      dateTime: option(string),
      [@optional]
      decelerate: option(string),
      [@optional]
      default: option(bool),
      [@optional]
      defaultChecked: option(bool),
      [@optional]
      defaultValue: option(string),
      [@optional]
      defer: option(bool),
      [@optional]
      descent: option(string),
      [@optional]
      diffuseConstant: option(string),
      [@optional]
      dir: option(string),
      [@optional]
      direction: option(string),
      [@optional]
      disabled: option(bool),
      [@optional]
      display: option(string),
      [@optional]
      divisor: option(string),
      [@optional]
      dominantBaseline: option(string),
      [@optional]
      download: option(string),
      [@optional]
      draggable: option(bool),
      [@optional]
      dur: option(string),
      [@optional]
      dx: option(string),
      [@optional]
      dy: option(string),
      [@optional]
      edgeMode: option(string),
      [@optional]
      elevation: option(string),
      [@optional]
      enableBackground: option(string),
      [@optional]
      encType: option(string),
      [@optional]
      end_: option(string),
      [@optional]
      exponent: option(string),
      [@optional]
      externalResourcesRequired: option(string),
      [@optional]
      fill: option(string),
      [@optional]
      fillOpacity: option(string),
      [@optional]
      fillRule: option(string),
      [@optional]
      filter: option(string),
      [@optional]
      filterRes: option(string),
      [@optional]
      filterUnits: option(string),
      [@optional]
      floodColor: option(string),
      [@optional]
      floodOpacity: option(string),
      [@optional]
      focusable: option(string),
      [@optional]
      fontFamily: option(string),
      [@optional]
      fontSize: option(string),
      [@optional]
      fontSizeAdjust: option(string),
      [@optional]
      fontStretch: option(string),
      [@optional]
      fontStyle: option(string),
      [@optional]
      fontVariant: option(string),
      [@optional]
      fontWeight: option(string),
      [@optional]
      form: option(string),
      [@optional]
      formAction: option(string),
      [@optional]
      formMethod: option(string),
      [@optional]
      formTarget: option(string),
      [@optional]
      from: option(string),
      [@optional]
      fx: option(string),
      [@optional]
      fy: option(string),
      [@optional]
      g1: option(string),
      [@optional]
      g2: option(string),
      [@optional]
      glyphName: option(string),
      [@optional]
      glyphOrientationHorizontal: option(string),
      [@optional]
      glyphOrientationVertical: option(string),
      [@optional]
      glyphRef: option(string),
      [@optional]
      gradientTransform: option(string),
      [@optional]
      gradientUnits: option(string),
      [@optional]
      hanging: option(string),
      [@optional]
      headers: option(string),
      [@optional]
      height: option(string),
      [@optional]
      hidden: option(bool),
      [@optional]
      high: option(int),
      [@optional]
      horizAdvX: option(string),
      [@optional]
      horizOriginX: option(string),
      [@optional]
      href: option(string),
      [@optional]
      hrefLang: option(string),
      [@optional]
      htmlFor: option(string),
      [@optional]
      httpEquiv: option(string),
      [@optional]
      icon: option(string),
      [@optional]
      id: option(string),
      [@optional]
      ideographic: option(string),
      [@optional]
      imageRendering: option(string),
      [@optional]
      in_: option(string),
      [@optional]
      in2: option(string),
      [@optional]
      inlist: option(string),
      [@optional]
      inputMode: option(string),
      [@optional]
      integrity: option(string),
      [@optional]
      intercept: option(string),
      [@optional]
      itemID: option(string),
      [@optional]
      itemProp: option(string),
      [@optional]
      itemRef: option(string),
      [@optional]
      itemScope: option(bool),
      [@optional]
      itemType: option(string),
      [@optional]
      k: option(string),
      [@optional]
      k1: option(string),
      [@optional]
      k2: option(string),
      [@optional]
      k3: option(string),
      [@optional]
      k4: option(string),
      [@optional]
      kernelMatrix: option(string),
      [@optional]
      kernelUnitLength: option(string),
      [@optional]
      kerning: option(string),
      [@optional]
      key: option(string),
      [@optional]
      keyPoints: option(string),
      [@optional]
      keySplines: option(string),
      [@optional]
      keyTimes: option(string),
      [@optional]
      keyType: option(string),
      [@optional]
      kind: option(string),
      [@optional]
      label: option(string),
      [@optional]
      lang: option(string),
      [@optional]
      lengthAdjust: option(string),
      [@optional]
      letterSpacing: option(string),
      [@optional]
      lightingColor: option(string),
      [@optional]
      limitingConeAngle: option(string),
      [@optional]
      list: option(string),
      [@optional]
      local: option(string),
      [@optional]
      loop: option(bool),
      [@optional]
      low: option(int),
      [@optional]
      manifest: option(string),
      [@optional]
      markerEnd: option(string),
      [@optional]
      markerHeight: option(string),
      [@optional]
      markerMid: option(string),
      [@optional]
      markerStart: option(string),
      [@optional]
      markerUnits: option(string),
      [@optional]
      markerWidth: option(string),
      [@optional]
      mask: option(string),
      [@optional]
      maskContentUnits: option(string),
      [@optional]
      maskUnits: option(string),
      [@optional]
      mathematical: option(string),
      [@optional]
      max: option(string),
      [@optional]
      maxLength: option(int),
      [@optional]
      media: option(string),
      [@optional]
      mediaGroup: option(string),
      [@optional]
      min: option(string),
      [@optional]
      minLength: option(int),
      [@optional]
      mode: option(string),
      [@optional]
      multiple: option(bool),
      [@optional]
      muted: option(bool),
      [@optional]
      name: option(string),
      [@optional]
      nonce: option(string),
      [@optional]
      noValidate: option(bool),
      [@optional]
      numOctaves: option(string),
      [@optional]
      offset: option(string),
      [@optional]
      opacity: option(string),
      [@optional]
      open_: option(bool),
      [@optional]
      operator: option(string),
      [@optional]
      optimum: option(int),
      [@optional]
      order: option(string),
      [@optional]
      orient: option(string),
      [@optional]
      orientation: option(string),
      [@optional]
      origin: option(string),
      [@optional]
      overflow: option(string),
      [@optional]
      overflowX: option(string),
      [@optional]
      overflowY: option(string),
      [@optional]
      overlinePosition: option(string),
      [@optional]
      overlineThickness: option(string),
      [@optional]
      paintOrder: option(string),
      [@optional]
      panose1: option(string),
      [@optional]
      pathLength: option(string),
      [@optional]
      pattern: option(string),
      [@optional]
      patternContentUnits: option(string),
      [@optional]
      patternTransform: option(string),
      [@optional]
      patternUnits: option(string),
      [@optional]
      placeholder: option(string),
      [@optional]
      pointerEvents: option(string),
      [@optional]
      points: option(string),
      [@optional]
      pointsAtX: option(string),
      [@optional]
      pointsAtY: option(string),
      [@optional]
      pointsAtZ: option(string),
      [@optional]
      poster: option(string),
      [@optional]
      prefix: option(string),
      [@optional]
      preload: option(string),
      [@optional]
      preserveAlpha: option(string),
      [@optional]
      preserveAspectRatio: option(string),
      [@optional]
      primitiveUnits: option(string),
      [@optional]
      property: option(string),
      [@optional]
      r: option(string),
      [@optional]
      radioGroup: option(string),
      [@optional]
      radius: option(string),
      [@optional]
      readOnly: option(bool),
      [@optional]
      refX: option(string),
      [@optional]
      refY: option(string),
      [@optional]
      rel: option(string),
      [@optional]
      renderingIntent: option(string),
      [@optional]
      repeatCount: option(string),
      [@optional]
      repeatDur: option(string),
      [@optional]
      required: option(bool),
      [@optional]
      requiredExtensions: option(string),
      [@optional]
      requiredFeatures: option(string),
      [@optional]
      resource: option(string),
      [@optional]
      restart: option(string),
      [@optional]
      result: option(string),
      [@optional]
      reversed: option(bool),
      [@optional]
      role: option(string),
      [@optional]
      rotate: option(string),
      [@optional]
      rows: option(int),
      [@optional]
      rowSpan: option(int),
      [@optional]
      rx: option(string),
      [@optional]
      ry: option(string),
      [@optional]
      sandbox: option(string),
      [@optional]
      scale: option(string),
      [@optional]
      scope: option(string),
      [@optional]
      scoped: option(bool),
      [@optional]
      scrolling: option(string),
      [@optional]
      seed: option(string),
      [@optional]
      selected: option(bool),
      [@optional]
      shape: option(string),
      [@optional]
      shapeRendering: option(string),
      [@optional]
      size: option(int),
      [@optional]
      sizes: option(string),
      [@optional]
      slope: option(string),
      [@optional]
      spacing: option(string),
      [@optional]
      span: option(int),
      [@optional]
      specularConstant: option(string),
      [@optional]
      specularExponent: option(string),
      [@optional]
      speed: option(string),
      [@optional]
      spellCheck: option(bool),
      [@optional]
      spreadMethod: option(string),
      [@optional]
      src: option(string),
      [@optional]
      srcDoc: option(string),
      [@optional]
      srcLang: option(string),
      [@optional]
      srcSet: option(string),
      [@optional]
      start: option(int),
      [@optional]
      startOffset: option(string),
      [@optional]
      stdDeviation: option(string),
      [@optional]
      stemh: option(string),
      [@optional]
      stemv: option(string),
      [@optional]
      step: option(float),
      [@optional]
      stitchTiles: option(string),
      [@optional]
      stopColor: option(string),
      [@optional]
      stopOpacity: option(string),
      [@optional]
      strikethroughPosition: option(string),
      [@optional]
      strikethroughThickness: option(string),
      [@optional]
      stroke: option(string),
      [@optional]
      strokeDasharray: option(string),
      [@optional]
      strokeDashoffset: option(string),
      [@optional]
      strokeLinecap: option(string),
      [@optional]
      strokeLinejoin: option(string),
      [@optional]
      strokeMiterlimit: option(string),
      [@optional]
      strokeOpacity: option(string),
      [@optional]
      strokeWidth: option(string),
      [@optional]
      style: option(ReactDOM.Style.t),
      [@optional]
      summary: option(string),
      [@optional]
      suppressContentEditableWarning: option(bool),
      [@optional]
      surfaceScale: option(string),
      [@optional]
      systemLanguage: option(string),
      [@optional]
      tabIndex: option(int),
      [@optional]
      tableValues: option(string),
      [@optional]
      target: option(string),
      [@optional]
      targetX: option(string),
      [@optional]
      targetY: option(string),
      [@optional]
      textAnchor: option(string),
      [@optional]
      textDecoration: option(string),
      [@optional]
      textLength: option(string),
      [@optional]
      textRendering: option(string),
      [@optional]
      title: option(string),
      [@optional]
      to_: option(string),
      [@optional]
      transform: option(string),
      [@optional] [@mel.as "type"]
      type_: option(string),
      [@optional]
      typeof: option(string),
      [@optional]
      u1: option(string),
      [@optional]
      u2: option(string),
      [@optional]
      underlinePosition: option(string),
      [@optional]
      underlineThickness: option(string),
      [@optional]
      unicode: option(string),
      [@optional]
      unicodeBidi: option(string),
      [@optional]
      unicodeRange: option(string),
      [@optional]
      unitsPerEm: option(string),
      [@optional]
      useMap: option(string),
      [@optional]
      vAlphabetic: option(string),
      [@optional]
      value: option(string),
      [@optional]
      values: option(string),
      [@optional]
      vectorEffect: option(string),
      [@optional]
      version: option(string),
      [@optional]
      vertAdvX: option(string),
      [@optional]
      vertAdvY: option(string),
      [@optional]
      vertOriginX: option(string),
      [@optional]
      vertOriginY: option(string),
      [@optional]
      vHanging: option(string),
      [@optional]
      vIdeographic: option(string),
      [@optional]
      viewBox: option(string),
      [@optional]
      viewTarget: option(string),
      [@optional]
      visibility: option(string),
      [@optional]
      vMathematical: option(string),
      [@optional]
      vocab: option(string),
      [@optional]
      width: option(string),
      [@optional]
      widths: option(string),
      [@optional]
      wordSpacing: option(string),
      [@optional]
      wrap: option(string),
      [@optional]
      writingMode: option(string),
      [@optional]
      x: option(string),
      [@optional]
      x1: option(string),
      [@optional]
      x2: option(string),
      [@optional]
      xChannelSelector: option(string),
      [@optional]
      xHeight: option(string),
      [@optional]
      xlinkActuate: option(string),
      [@optional]
      xlinkArcrole: option(string),
      [@optional]
      xlinkHref: option(string),
      [@optional]
      xlinkRole: option(string),
      [@optional]
      xlinkShow: option(string),
      [@optional]
      xlinkTitle: option(string),
      [@optional]
      xlinkType: option(string),
      [@optional]
      xmlBase: option(string),
      [@optional]
      xmlLang: option(string),
      [@optional]
      xmlns: option(string),
      [@optional]
      xmlnsXlink: option(string),
      [@optional]
      xmlSpace: option(string),
      [@optional]
      y: option(string),
      [@optional]
      y1: option(string),
      [@optional]
      y2: option(string),
      [@optional]
      yChannelSelector: option(string),
      [@optional]
      z: option(string),
      [@optional]
      zoomAndPan: option(string),
      [@optional]
      onAbort: option(React.Event.Media.t => unit),
      [@optional]
      onAnimationEnd: option(React.Event.Animation.t => unit),
      [@optional]
      onAnimationIteration: option(React.Event.Animation.t => unit),
      [@optional]
      onAnimationStart: option(React.Event.Animation.t => unit),
      [@optional]
      onBlur: option(React.Event.Focus.t => unit),
      [@optional]
      onCanPlay: option(React.Event.Media.t => unit),
      [@optional]
      onCanPlayThrough: option(React.Event.Media.t => unit),
      [@optional]
      onChange: option(React.Event.Form.t => unit),
      [@optional]
      onClick: option(React.Event.Mouse.t => unit),
      [@optional]
      onCompositionEnd: option(React.Event.Composition.t => unit),
      [@optional]
      onCompositionStart: option(React.Event.Composition.t => unit),
      [@optional]
      onCompositionUpdate: option(React.Event.Composition.t => unit),
      [@optional]
      onContextMenu: option(React.Event.Mouse.t => unit),
      [@optional]
      onCopy: option(React.Event.Clipboard.t => unit),
      [@optional]
      onCut: option(React.Event.Clipboard.t => unit),
      [@optional]
      onDoubleClick: option(React.Event.Mouse.t => unit),
      [@optional]
      onDrag: option(React.Event.Mouse.t => unit),
      [@optional]
      onDragEnd: option(React.Event.Mouse.t => unit),
      [@optional]
      onDragEnter: option(React.Event.Mouse.t => unit),
      [@optional]
      onDragExit: option(React.Event.Mouse.t => unit),
      [@optional]
      onDragLeave: option(React.Event.Mouse.t => unit),
      [@optional]
      onDragOver: option(React.Event.Mouse.t => unit),
      [@optional]
      onDragStart: option(React.Event.Mouse.t => unit),
      [@optional]
      onDrop: option(React.Event.Mouse.t => unit),
      [@optional]
      onDurationChange: option(React.Event.Media.t => unit),
      [@optional]
      onEmptied: option(React.Event.Media.t => unit),
      [@optional]
      onEncrypetd: option(React.Event.Media.t => unit),
      [@optional]
      onEnded: option(React.Event.Media.t => unit),
      [@optional]
      onError: option(React.Event.Media.t => unit),
      [@optional]
      onFocus: option(React.Event.Focus.t => unit),
      [@optional]
      onInput: option(React.Event.Form.t => unit),
      [@optional]
      onKeyDown: option(React.Event.Keyboard.t => unit),
      [@optional]
      onKeyPress: option(React.Event.Keyboard.t => unit),
      [@optional]
      onKeyUp: option(React.Event.Keyboard.t => unit),
      [@optional]
      onLoadedData: option(React.Event.Media.t => unit),
      [@optional]
      onLoadedMetadata: option(React.Event.Media.t => unit),
      [@optional]
      onLoadStart: option(React.Event.Media.t => unit),
      [@optional]
      onMouseDown: option(React.Event.Mouse.t => unit),
      [@optional]
      onMouseEnter: option(React.Event.Mouse.t => unit),
      [@optional]
      onMouseLeave: option(React.Event.Mouse.t => unit),
      [@optional]
      onMouseMove: option(React.Event.Mouse.t => unit),
      [@optional]
      onMouseOut: option(React.Event.Mouse.t => unit),
      [@optional]
      onMouseOver: option(React.Event.Mouse.t => unit),
      [@optional]
      onMouseUp: option(React.Event.Mouse.t => unit),
      [@optional]
      onPaste: option(React.Event.Clipboard.t => unit),
      [@optional]
      onPause: option(React.Event.Media.t => unit),
      [@optional]
      onPlay: option(React.Event.Media.t => unit),
      [@optional]
      onPlaying: option(React.Event.Media.t => unit),
      [@optional]
      onProgress: option(React.Event.Media.t => unit),
      [@optional]
      onRateChange: option(React.Event.Media.t => unit),
      [@optional]
      onScroll: option(React.Event.UI.t => unit),
      [@optional]
      onSeeked: option(React.Event.Media.t => unit),
      [@optional]
      onSeeking: option(React.Event.Media.t => unit),
      [@optional]
      onSelect: option(React.Event.Selection.t => unit),
      [@optional]
      onStalled: option(React.Event.Media.t => unit),
      [@optional]
      onSubmit: option(React.Event.Form.t => unit),
      [@optional]
      onSuspend: option(React.Event.Media.t => unit),
      [@optional]
      onTimeUpdate: option(React.Event.Media.t => unit),
      [@optional]
      onTouchCancel: option(React.Event.Touch.t => unit),
      [@optional]
      onTouchEnd: option(React.Event.Touch.t => unit),
      [@optional]
      onTouchMove: option(React.Event.Touch.t => unit),
      [@optional]
      onTouchStart: option(React.Event.Touch.t => unit),
      [@optional]
      onTransitionEnd: option(React.Event.Transition.t => unit),
      [@optional]
      onVolumeChange: option(React.Event.Media.t => unit),
      [@optional]
      onWaiting: option(React.Event.Media.t => unit),
      [@optional]
      onWheel: option(React.Event.Wheel.t => unit),
    };
    let getOrEmpty = str =>
      switch (str) {
      | Some(str) => " " ++ str
      | None => ""
      };
    let styles =
      CSS.make_labeled(
        "MultiLineStrings",
        "css-k008qs-MultiLineStrings css-1tyndxa-MultiLineStrings",
        [],
      );
    let make = (props: makeProps) => {
      let className = CSS.className(styles) ++ getOrEmpty(props.className)
      and style = CSS.styles(styles);
      React.createElement(
        switch (props.as_) {
        | Some(v) => v
        | None => "section"
        },
        ReactDOM.domProps(
          ~className,
          ~style,
          ~ref=?props.innerRef,
          ~about=?props.about,
          ~accentHeight=?props.accentHeight,
          ~accept=?props.accept,
          ~acceptCharset=?props.acceptCharset,
          ~accessKey=?props.accessKey,
          ~accumulate=?props.accumulate,
          ~action=?props.action,
          ~additive=?props.additive,
          ~alignmentBaseline=?props.alignmentBaseline,
          ~allowFullScreen=?props.allowFullScreen,
          ~allowReorder=?props.allowReorder,
          ~alphabetic=?props.alphabetic,
          ~alt=?props.alt,
          ~amplitude=?props.amplitude,
          ~arabicForm=?props.arabicForm,
          ~ariaActivedescendant=?props.ariaActivedescendant,
          ~ariaAtomic=?props.ariaAtomic,
          ~ariaBusy=?props.ariaBusy,
          ~ariaColcount=?props.ariaColcount,
          ~ariaColindex=?props.ariaColindex,
          ~ariaColspan=?props.ariaColspan,
          ~ariaControls=?props.ariaControls,
          ~ariaDescribedby=?props.ariaDescribedby,
          ~ariaDetails=?props.ariaDetails,
          ~ariaDisabled=?props.ariaDisabled,
          ~ariaErrormessage=?props.ariaErrormessage,
          ~ariaExpanded=?props.ariaExpanded,
          ~ariaFlowto=?props.ariaFlowto,
          ~ariaGrabbed=?props.ariaGrabbed,
          ~ariaHidden=?props.ariaHidden,
          ~ariaKeyshortcuts=?props.ariaKeyshortcuts,
          ~ariaLabel=?props.ariaLabel,
          ~ariaLabelledby=?props.ariaLabelledby,
          ~ariaLevel=?props.ariaLevel,
          ~ariaModal=?props.ariaModal,
          ~ariaMultiline=?props.ariaMultiline,
          ~ariaMultiselectable=?props.ariaMultiselectable,
          ~ariaOwns=?props.ariaOwns,
          ~ariaPlaceholder=?props.ariaPlaceholder,
          ~ariaPosinset=?props.ariaPosinset,
          ~ariaReadonly=?props.ariaReadonly,
          ~ariaRelevant=?props.ariaRelevant,
          ~ariaRequired=?props.ariaRequired,
          ~ariaRoledescription=?props.ariaRoledescription,
          ~ariaRowcount=?props.ariaRowcount,
          ~ariaRowindex=?props.ariaRowindex,
          ~ariaRowspan=?props.ariaRowspan,
          ~ariaSelected=?props.ariaSelected,
          ~ariaSetsize=?props.ariaSetsize,
          ~ariaSort=?props.ariaSort,
          ~ariaValuemax=?props.ariaValuemax,
          ~ariaValuemin=?props.ariaValuemin,
          ~ariaValuenow=?props.ariaValuenow,
          ~ariaValuetext=?props.ariaValuetext,
          ~ascent=?props.ascent,
          ~async=?props.async,
          ~attributeName=?props.attributeName,
          ~attributeType=?props.attributeType,
          ~autoComplete=?props.autoComplete,
          ~autoFocus=?props.autoFocus,
          ~autoPlay=?props.autoPlay,
          ~autoReverse=?props.autoReverse,
          ~azimuth=?props.azimuth,
          ~baseFrequency=?props.baseFrequency,
          ~baselineShift=?props.baselineShift,
          ~baseProfile=?props.baseProfile,
          ~bbox=?props.bbox,
          ~begin_=?props.begin_,
          ~bias=?props.bias,
          ~by=?props.by,
          ~calcMode=?props.calcMode,
          ~capHeight=?props.capHeight,
          ~challenge=?props.challenge,
          ~charSet=?props.charSet,
          ~checked=?props.checked,
          ~cite=?props.cite,
          ~clip=?props.clip,
          ~clipPath=?props.clipPath,
          ~clipPathUnits=?props.clipPathUnits,
          ~clipRule=?props.clipRule,
          ~colorInterpolation=?props.colorInterpolation,
          ~colorInterpolationFilters=?props.colorInterpolationFilters,
          ~colorProfile=?props.colorProfile,
          ~colorRendering=?props.colorRendering,
          ~cols=?props.cols,
          ~colSpan=?props.colSpan,
          ~content=?props.content,
          ~contentEditable=?props.contentEditable,
          ~contentScriptType=?props.contentScriptType,
          ~contentStyleType=?props.contentStyleType,
          ~contextMenu=?props.contextMenu,
          ~controls=?props.controls,
          ~coords=?props.coords,
          ~crossOrigin=?props.crossOrigin,
          ~cursor=?props.cursor,
          ~cx=?props.cx,
          ~cy=?props.cy,
          ~d=?props.d,
          ~data=?props.data,
          ~datatype=?props.datatype,
          ~dateTime=?props.dateTime,
          ~decelerate=?props.decelerate,
          ~default=?props.default,
          ~defaultChecked=?props.defaultChecked,
          ~defaultValue=?props.defaultValue,
          ~defer=?props.defer,
          ~descent=?props.descent,
          ~diffuseConstant=?props.diffuseConstant,
          ~dir=?props.dir,
          ~direction=?props.direction,
          ~disabled=?props.disabled,
          ~display=?props.display,
          ~divisor=?props.divisor,
          ~dominantBaseline=?props.dominantBaseline,
          ~download=?props.download,
          ~draggable=?props.draggable,
          ~dur=?props.dur,
          ~dx=?props.dx,
          ~dy=?props.dy,
          ~edgeMode=?props.edgeMode,
          ~elevation=?props.elevation,
          ~enableBackground=?props.enableBackground,
          ~encType=?props.encType,
          ~end_=?props.end_,
          ~exponent=?props.exponent,
          ~externalResourcesRequired=?props.externalResourcesRequired,
          ~fill=?props.fill,
          ~fillOpacity=?props.fillOpacity,
          ~fillRule=?props.fillRule,
          ~filter=?props.filter,
          ~filterRes=?props.filterRes,
          ~filterUnits=?props.filterUnits,
          ~floodColor=?props.floodColor,
          ~floodOpacity=?props.floodOpacity,
          ~focusable=?props.focusable,
          ~fontFamily=?props.fontFamily,
          ~fontSize=?props.fontSize,
          ~fontSizeAdjust=?props.fontSizeAdjust,
          ~fontStretch=?props.fontStretch,
          ~fontStyle=?props.fontStyle,
          ~fontVariant=?props.fontVariant,
          ~fontWeight=?props.fontWeight,
          ~form=?props.form,
          ~formAction=?props.formAction,
          ~formMethod=?props.formMethod,
          ~formTarget=?props.formTarget,
          ~from=?props.from,
          ~fx=?props.fx,
          ~fy=?props.fy,
          ~g1=?props.g1,
          ~g2=?props.g2,
          ~glyphName=?props.glyphName,
          ~glyphOrientationHorizontal=?props.glyphOrientationHorizontal,
          ~glyphOrientationVertical=?props.glyphOrientationVertical,
          ~glyphRef=?props.glyphRef,
          ~gradientTransform=?props.gradientTransform,
          ~gradientUnits=?props.gradientUnits,
          ~hanging=?props.hanging,
          ~headers=?props.headers,
          ~height=?props.height,
          ~hidden=?props.hidden,
          ~high=?props.high,
          ~horizAdvX=?props.horizAdvX,
          ~horizOriginX=?props.horizOriginX,
          ~href=?props.href,
          ~hrefLang=?props.hrefLang,
          ~htmlFor=?props.htmlFor,
          ~httpEquiv=?props.httpEquiv,
          ~icon=?props.icon,
          ~id=?props.id,
          ~ideographic=?props.ideographic,
          ~imageRendering=?props.imageRendering,
          ~in_=?props.in_,
          ~in2=?props.in2,
          ~inlist=?props.inlist,
          ~inputMode=?props.inputMode,
          ~integrity=?props.integrity,
          ~intercept=?props.intercept,
          ~itemID=?props.itemID,
          ~itemProp=?props.itemProp,
          ~itemRef=?props.itemRef,
          ~itemScope=?props.itemScope,
          ~itemType=?props.itemType,
          ~k=?props.k,
          ~k1=?props.k1,
          ~k2=?props.k2,
          ~k3=?props.k3,
          ~k4=?props.k4,
          ~kernelMatrix=?props.kernelMatrix,
          ~kernelUnitLength=?props.kernelUnitLength,
          ~kerning=?props.kerning,
          ~keyPoints=?props.keyPoints,
          ~keySplines=?props.keySplines,
          ~keyTimes=?props.keyTimes,
          ~keyType=?props.keyType,
          ~kind=?props.kind,
          ~label=?props.label,
          ~lang=?props.lang,
          ~lengthAdjust=?props.lengthAdjust,
          ~letterSpacing=?props.letterSpacing,
          ~lightingColor=?props.lightingColor,
          ~limitingConeAngle=?props.limitingConeAngle,
          ~list=?props.list,
          ~local=?props.local,
          ~loop=?props.loop,
          ~low=?props.low,
          ~manifest=?props.manifest,
          ~markerEnd=?props.markerEnd,
          ~markerHeight=?props.markerHeight,
          ~markerMid=?props.markerMid,
          ~markerStart=?props.markerStart,
          ~markerUnits=?props.markerUnits,
          ~markerWidth=?props.markerWidth,
          ~mask=?props.mask,
          ~maskContentUnits=?props.maskContentUnits,
          ~maskUnits=?props.maskUnits,
          ~mathematical=?props.mathematical,
          ~max=?props.max,
          ~maxLength=?props.maxLength,
          ~media=?props.media,
          ~mediaGroup=?props.mediaGroup,
          ~min=?props.min,
          ~minLength=?props.minLength,
          ~mode=?props.mode,
          ~multiple=?props.multiple,
          ~muted=?props.muted,
          ~name=?props.name,
          ~nonce=?props.nonce,
          ~noValidate=?props.noValidate,
          ~numOctaves=?props.numOctaves,
          ~offset=?props.offset,
          ~opacity=?props.opacity,
          ~open_=?props.open_,
          ~operator=?props.operator,
          ~optimum=?props.optimum,
          ~order=?props.order,
          ~orient=?props.orient,
          ~orientation=?props.orientation,
          ~origin=?props.origin,
          ~overflow=?props.overflow,
          ~overflowX=?props.overflowX,
          ~overflowY=?props.overflowY,
          ~overlinePosition=?props.overlinePosition,
          ~overlineThickness=?props.overlineThickness,
          ~paintOrder=?props.paintOrder,
          ~panose1=?props.panose1,
          ~pathLength=?props.pathLength,
          ~pattern=?props.pattern,
          ~patternContentUnits=?props.patternContentUnits,
          ~patternTransform=?props.patternTransform,
          ~patternUnits=?props.patternUnits,
          ~placeholder=?props.placeholder,
          ~pointerEvents=?props.pointerEvents,
          ~points=?props.points,
          ~pointsAtX=?props.pointsAtX,
          ~pointsAtY=?props.pointsAtY,
          ~pointsAtZ=?props.pointsAtZ,
          ~poster=?props.poster,
          ~prefix=?props.prefix,
          ~preload=?props.preload,
          ~preserveAlpha=?props.preserveAlpha,
          ~preserveAspectRatio=?props.preserveAspectRatio,
          ~primitiveUnits=?props.primitiveUnits,
          ~property=?props.property,
          ~r=?props.r,
          ~radioGroup=?props.radioGroup,
          ~radius=?props.radius,
          ~readOnly=?props.readOnly,
          ~refX=?props.refX,
          ~refY=?props.refY,
          ~rel=?props.rel,
          ~renderingIntent=?props.renderingIntent,
          ~repeatCount=?props.repeatCount,
          ~repeatDur=?props.repeatDur,
          ~required=?props.required,
          ~requiredExtensions=?props.requiredExtensions,
          ~requiredFeatures=?props.requiredFeatures,
          ~resource=?props.resource,
          ~restart=?props.restart,
          ~result=?props.result,
          ~reversed=?props.reversed,
          ~role=?props.role,
          ~rotate=?props.rotate,
          ~rows=?props.rows,
          ~rowSpan=?props.rowSpan,
          ~rx=?props.rx,
          ~ry=?props.ry,
          ~sandbox=?props.sandbox,
          ~scale=?props.scale,
          ~scope=?props.scope,
          ~scoped=?props.scoped,
          ~scrolling=?props.scrolling,
          ~seed=?props.seed,
          ~selected=?props.selected,
          ~shape=?props.shape,
          ~shapeRendering=?props.shapeRendering,
          ~size=?props.size,
          ~sizes=?props.sizes,
          ~slope=?props.slope,
          ~spacing=?props.spacing,
          ~span=?props.span,
          ~specularConstant=?props.specularConstant,
          ~specularExponent=?props.specularExponent,
          ~speed=?props.speed,
          ~spellCheck=?props.spellCheck,
          ~spreadMethod=?props.spreadMethod,
          ~src=?props.src,
          ~srcDoc=?props.srcDoc,
          ~srcLang=?props.srcLang,
          ~srcSet=?props.srcSet,
          ~start=?props.start,
          ~startOffset=?props.startOffset,
          ~stdDeviation=?props.stdDeviation,
          ~stemh=?props.stemh,
          ~stemv=?props.stemv,
          ~step=?props.step,
          ~stitchTiles=?props.stitchTiles,
          ~stopColor=?props.stopColor,
          ~stopOpacity=?props.stopOpacity,
          ~strikethroughPosition=?props.strikethroughPosition,
          ~strikethroughThickness=?props.strikethroughThickness,
          ~stroke=?props.stroke,
          ~strokeDasharray=?props.strokeDasharray,
          ~strokeDashoffset=?props.strokeDashoffset,
          ~strokeLinecap=?props.strokeLinecap,
          ~strokeLinejoin=?props.strokeLinejoin,
          ~strokeMiterlimit=?props.strokeMiterlimit,
          ~strokeOpacity=?props.strokeOpacity,
          ~strokeWidth=?props.strokeWidth,
          ~summary=?props.summary,
          ~suppressContentEditableWarning=?props.suppressContentEditableWarning,
          ~surfaceScale=?props.surfaceScale,
          ~systemLanguage=?props.systemLanguage,
          ~tabIndex=?props.tabIndex,
          ~tableValues=?props.tableValues,
          ~target=?props.target,
          ~targetX=?props.targetX,
          ~targetY=?props.targetY,
          ~textAnchor=?props.textAnchor,
          ~textDecoration=?props.textDecoration,
          ~textLength=?props.textLength,
          ~textRendering=?props.textRendering,
          ~title=?props.title,
          ~to_=?props.to_,
          ~transform=?props.transform,
          ~type_=?props.type_,
          ~typeof=?props.typeof,
          ~u1=?props.u1,
          ~u2=?props.u2,
          ~underlinePosition=?props.underlinePosition,
          ~underlineThickness=?props.underlineThickness,
          ~unicode=?props.unicode,
          ~unicodeBidi=?props.unicodeBidi,
          ~unicodeRange=?props.unicodeRange,
          ~unitsPerEm=?props.unitsPerEm,
          ~useMap=?props.useMap,
          ~vAlphabetic=?props.vAlphabetic,
          ~value=?props.value,
          ~values=?props.values,
          ~vectorEffect=?props.vectorEffect,
          ~version=?props.version,
          ~vertAdvX=?props.vertAdvX,
          ~vertAdvY=?props.vertAdvY,
          ~vertOriginX=?props.vertOriginX,
          ~vertOriginY=?props.vertOriginY,
          ~vHanging=?props.vHanging,
          ~vIdeographic=?props.vIdeographic,
          ~viewBox=?props.viewBox,
          ~viewTarget=?props.viewTarget,
          ~visibility=?props.visibility,
          ~vMathematical=?props.vMathematical,
          ~vocab=?props.vocab,
          ~width=?props.width,
          ~widths=?props.widths,
          ~wordSpacing=?props.wordSpacing,
          ~wrap=?props.wrap,
          ~writingMode=?props.writingMode,
          ~x=?props.x,
          ~x1=?props.x1,
          ~x2=?props.x2,
          ~xChannelSelector=?props.xChannelSelector,
          ~xHeight=?props.xHeight,
          ~xlinkActuate=?props.xlinkActuate,
          ~xlinkArcrole=?props.xlinkArcrole,
          ~xlinkHref=?props.xlinkHref,
          ~xlinkRole=?props.xlinkRole,
          ~xlinkShow=?props.xlinkShow,
          ~xlinkTitle=?props.xlinkTitle,
          ~xlinkType=?props.xlinkType,
          ~xmlBase=?props.xmlBase,
          ~xmlLang=?props.xmlLang,
          ~xmlns=?props.xmlns,
          ~xmlnsXlink=?props.xmlnsXlink,
          ~xmlSpace=?props.xmlSpace,
          ~y=?props.y,
          ~y1=?props.y1,
          ~y2=?props.y2,
          ~yChannelSelector=?props.yChannelSelector,
          ~z=?props.z,
          ~zoomAndPan=?props.zoomAndPan,
          ~onAbort=?props.onAbort,
          ~onAnimationEnd=?props.onAnimationEnd,
          ~onAnimationIteration=?props.onAnimationIteration,
          ~onAnimationStart=?props.onAnimationStart,
          ~onBlur=?props.onBlur,
          ~onCanPlay=?props.onCanPlay,
          ~onCanPlayThrough=?props.onCanPlayThrough,
          ~onChange=?props.onChange,
          ~onClick=?props.onClick,
          ~onCompositionEnd=?props.onCompositionEnd,
          ~onCompositionStart=?props.onCompositionStart,
          ~onCompositionUpdate=?props.onCompositionUpdate,
          ~onContextMenu=?props.onContextMenu,
          ~onCopy=?props.onCopy,
          ~onCut=?props.onCut,
          ~onDoubleClick=?props.onDoubleClick,
          ~onDrag=?props.onDrag,
          ~onDragEnd=?props.onDragEnd,
          ~onDragEnter=?props.onDragEnter,
          ~onDragExit=?props.onDragExit,
          ~onDragLeave=?props.onDragLeave,
          ~onDragOver=?props.onDragOver,
          ~onDragStart=?props.onDragStart,
          ~onDrop=?props.onDrop,
          ~onDurationChange=?props.onDurationChange,
          ~onEmptied=?props.onEmptied,
          ~onEncrypetd=?props.onEncrypetd,
          ~onEnded=?props.onEnded,
          ~onError=?props.onError,
          ~onFocus=?props.onFocus,
          ~onInput=?props.onInput,
          ~onKeyDown=?props.onKeyDown,
          ~onKeyPress=?props.onKeyPress,
          ~onKeyUp=?props.onKeyUp,
          ~onLoadedData=?props.onLoadedData,
          ~onLoadedMetadata=?props.onLoadedMetadata,
          ~onLoadStart=?props.onLoadStart,
          ~onMouseDown=?props.onMouseDown,
          ~onMouseEnter=?props.onMouseEnter,
          ~onMouseLeave=?props.onMouseLeave,
          ~onMouseMove=?props.onMouseMove,
          ~onMouseOut=?props.onMouseOut,
          ~onMouseOver=?props.onMouseOver,
          ~onMouseUp=?props.onMouseUp,
          ~onPaste=?props.onPaste,
          ~onPause=?props.onPause,
          ~onPlay=?props.onPlay,
          ~onPlaying=?props.onPlaying,
          ~onProgress=?props.onProgress,
          ~onRateChange=?props.onRateChange,
          ~onScroll=?props.onScroll,
          ~onSeeked=?props.onSeeked,
          ~onSeeking=?props.onSeeking,
          ~onSelect=?props.onSelect,
          ~onStalled=?props.onStalled,
          ~onSubmit=?props.onSubmit,
          ~onSuspend=?props.onSuspend,
          ~onTimeUpdate=?props.onTimeUpdate,
          ~onTouchCancel=?props.onTouchCancel,
          ~onTouchEnd=?props.onTouchEnd,
          ~onTouchMove=?props.onTouchMove,
          ~onTouchStart=?props.onTouchStart,
          ~onTransitionEnd=?props.onTransitionEnd,
          ~onVolumeChange=?props.onVolumeChange,
          ~onWaiting=?props.onWaiting,
          ~onWheel=?props.onWheel,
          (),
        ),
        [
          switch (props.children) {
          | Some(c) => c
          | None => React.null
          },
        ],
      );
    };
  };
