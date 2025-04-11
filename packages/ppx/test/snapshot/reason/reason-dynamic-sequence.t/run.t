  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module SequenceDynamicComponent = {
    [@deriving (jsProperties, getSet)]
    type makeProps('size) = {
      [@mel.optional]
      innerRef: option(ReactDOM.domRef),
      [@mel.optional]
      children: option(React.element),
      [@mel.optional] [@mel.as "as"]
      as_: option(string),
      [@mel.optional]
      about: option(string),
      [@mel.optional]
      accentHeight: option(string),
      [@mel.optional]
      accept: option(string),
      [@mel.optional]
      acceptCharset: option(string),
      [@mel.optional]
      accessKey: option(string),
      [@mel.optional]
      accumulate: option(string),
      [@mel.optional]
      action: option(string),
      [@mel.optional]
      additive: option(string),
      [@mel.optional]
      alignmentBaseline: option(string),
      [@mel.optional]
      allowFullScreen: option(bool),
      [@mel.optional]
      allowReorder: option(string),
      [@mel.optional]
      alphabetic: option(string),
      [@mel.optional]
      alt: option(string),
      [@mel.optional]
      amplitude: option(string),
      [@mel.optional]
      arabicForm: option(string),
      [@mel.optional] [@mel.as "aria-activedescendant"]
      ariaActivedescendant: option(string),
      [@mel.optional] [@mel.as "aria-atomic"]
      ariaAtomic: option(bool),
      [@mel.optional] [@mel.as "aria-busy"]
      ariaBusy: option(bool),
      [@mel.optional] [@mel.as "aria-colcount"]
      ariaColcount: option(int),
      [@mel.optional] [@mel.as "aria-colindex"]
      ariaColindex: option(int),
      [@mel.optional] [@mel.as "aria-colspan"]
      ariaColspan: option(int),
      [@mel.optional] [@mel.as "aria-controls"]
      ariaControls: option(string),
      [@mel.optional] [@mel.as "aria-describedby"]
      ariaDescribedby: option(string),
      [@mel.optional] [@mel.as "aria-details"]
      ariaDetails: option(string),
      [@mel.optional] [@mel.as "aria-disabled"]
      ariaDisabled: option(bool),
      [@mel.optional] [@mel.as "aria-errormessage"]
      ariaErrormessage: option(string),
      [@mel.optional] [@mel.as "aria-expanded"]
      ariaExpanded: option(bool),
      [@mel.optional] [@mel.as "aria-flowto"]
      ariaFlowto: option(string),
      [@mel.optional] [@mel.as "aria-grabbed"]
      ariaGrabbed: option(bool),
      [@mel.optional] [@mel.as "aria-hidden"]
      ariaHidden: option(bool),
      [@mel.optional] [@mel.as "aria-keyshortcuts"]
      ariaKeyshortcuts: option(string),
      [@mel.optional] [@mel.as "aria-label"]
      ariaLabel: option(string),
      [@mel.optional] [@mel.as "aria-labelledby"]
      ariaLabelledby: option(string),
      [@mel.optional] [@mel.as "aria-level"]
      ariaLevel: option(int),
      [@mel.optional] [@mel.as "aria-modal"]
      ariaModal: option(bool),
      [@mel.optional] [@mel.as "aria-multiline"]
      ariaMultiline: option(bool),
      [@mel.optional] [@mel.as "aria-multiselectable"]
      ariaMultiselectable: option(bool),
      [@mel.optional] [@mel.as "aria-owns"]
      ariaOwns: option(string),
      [@mel.optional] [@mel.as "aria-placeholder"]
      ariaPlaceholder: option(string),
      [@mel.optional] [@mel.as "aria-posinset"]
      ariaPosinset: option(int),
      [@mel.optional] [@mel.as "aria-readonly"]
      ariaReadonly: option(bool),
      [@mel.optional] [@mel.as "aria-relevant"]
      ariaRelevant: option(string),
      [@mel.optional] [@mel.as "aria-required"]
      ariaRequired: option(bool),
      [@mel.optional] [@mel.as "aria-roledescription"]
      ariaRoledescription: option(string),
      [@mel.optional] [@mel.as "aria-rowcount"]
      ariaRowcount: option(int),
      [@mel.optional] [@mel.as "aria-rowindex"]
      ariaRowindex: option(int),
      [@mel.optional] [@mel.as "aria-rowspan"]
      ariaRowspan: option(int),
      [@mel.optional] [@mel.as "aria-selected"]
      ariaSelected: option(bool),
      [@mel.optional] [@mel.as "aria-setsize"]
      ariaSetsize: option(int),
      [@mel.optional] [@mel.as "aria-sort"]
      ariaSort: option(string),
      [@mel.optional] [@mel.as "aria-valuemax"]
      ariaValuemax: option(float),
      [@mel.optional] [@mel.as "aria-valuemin"]
      ariaValuemin: option(float),
      [@mel.optional] [@mel.as "aria-valuenow"]
      ariaValuenow: option(float),
      [@mel.optional] [@mel.as "aria-valuetext"]
      ariaValuetext: option(string),
      [@mel.optional]
      ascent: option(string),
      [@mel.optional]
      async: option(bool),
      [@mel.optional]
      attributeName: option(string),
      [@mel.optional]
      attributeType: option(string),
      [@mel.optional]
      autoComplete: option(string),
      [@mel.optional]
      autoFocus: option(bool),
      [@mel.optional]
      autoPlay: option(bool),
      [@mel.optional]
      autoReverse: option(string),
      [@mel.optional]
      azimuth: option(string),
      [@mel.optional]
      baseFrequency: option(string),
      [@mel.optional]
      baselineShift: option(string),
      [@mel.optional]
      baseProfile: option(string),
      [@mel.optional]
      bbox: option(string),
      [@mel.optional]
      begin_: option(string),
      [@mel.optional]
      bias: option(string),
      [@mel.optional]
      by: option(string),
      [@mel.optional]
      calcMode: option(string),
      [@mel.optional]
      capHeight: option(string),
      [@mel.optional]
      challenge: option(string),
      [@mel.optional]
      charSet: option(string),
      [@mel.optional]
      checked: option(bool),
      [@mel.optional]
      cite: option(string),
      [@mel.optional]
      className: option(string),
      [@mel.optional]
      clip: option(string),
      [@mel.optional]
      clipPath: option(string),
      [@mel.optional]
      clipPathUnits: option(string),
      [@mel.optional]
      clipRule: option(string),
      [@mel.optional]
      colorInterpolation: option(string),
      [@mel.optional]
      colorInterpolationFilters: option(string),
      [@mel.optional]
      colorProfile: option(string),
      [@mel.optional]
      colorRendering: option(string),
      [@mel.optional]
      cols: option(int),
      [@mel.optional]
      colSpan: option(int),
      [@mel.optional]
      content: option(string),
      [@mel.optional]
      contentEditable: option(bool),
      [@mel.optional]
      contentScriptType: option(string),
      [@mel.optional]
      contentStyleType: option(string),
      [@mel.optional]
      contextMenu: option(string),
      [@mel.optional]
      controls: option(bool),
      [@mel.optional]
      coords: option(string),
      [@mel.optional]
      crossOrigin: option(string),
      [@mel.optional]
      cursor: option(string),
      [@mel.optional]
      cx: option(string),
      [@mel.optional]
      cy: option(string),
      [@mel.optional]
      d: option(string),
      [@mel.optional]
      data: option(string),
      [@mel.optional]
      datatype: option(string),
      [@mel.optional]
      dateTime: option(string),
      [@mel.optional]
      decelerate: option(string),
      [@mel.optional]
      default: option(bool),
      [@mel.optional]
      defaultChecked: option(bool),
      [@mel.optional]
      defaultValue: option(string),
      [@mel.optional]
      defer: option(bool),
      [@mel.optional]
      descent: option(string),
      [@mel.optional]
      diffuseConstant: option(string),
      [@mel.optional]
      dir: option(string),
      [@mel.optional]
      direction: option(string),
      [@mel.optional]
      disabled: option(bool),
      [@mel.optional]
      display: option(string),
      [@mel.optional]
      divisor: option(string),
      [@mel.optional]
      dominantBaseline: option(string),
      [@mel.optional]
      download: option(string),
      [@mel.optional]
      draggable: option(bool),
      [@mel.optional]
      dur: option(string),
      [@mel.optional]
      dx: option(string),
      [@mel.optional]
      dy: option(string),
      [@mel.optional]
      edgeMode: option(string),
      [@mel.optional]
      elevation: option(string),
      [@mel.optional]
      enableBackground: option(string),
      [@mel.optional]
      encType: option(string),
      [@mel.optional]
      end_: option(string),
      [@mel.optional]
      exponent: option(string),
      [@mel.optional]
      externalResourcesRequired: option(string),
      [@mel.optional]
      fill: option(string),
      [@mel.optional]
      fillOpacity: option(string),
      [@mel.optional]
      fillRule: option(string),
      [@mel.optional]
      filter: option(string),
      [@mel.optional]
      filterRes: option(string),
      [@mel.optional]
      filterUnits: option(string),
      [@mel.optional]
      floodColor: option(string),
      [@mel.optional]
      floodOpacity: option(string),
      [@mel.optional]
      focusable: option(string),
      [@mel.optional]
      fomat: option(string),
      [@mel.optional]
      fontFamily: option(string),
      [@mel.optional]
      fontSize: option(string),
      [@mel.optional]
      fontSizeAdjust: option(string),
      [@mel.optional]
      fontStretch: option(string),
      [@mel.optional]
      fontStyle: option(string),
      [@mel.optional]
      fontVariant: option(string),
      [@mel.optional]
      fontWeight: option(string),
      [@mel.optional]
      form: option(string),
      [@mel.optional]
      formAction: option(string),
      [@mel.optional]
      formMethod: option(string),
      [@mel.optional]
      formTarget: option(string),
      [@mel.optional]
      from: option(string),
      [@mel.optional]
      fx: option(string),
      [@mel.optional]
      fy: option(string),
      [@mel.optional]
      g1: option(string),
      [@mel.optional]
      g2: option(string),
      [@mel.optional]
      glyphName: option(string),
      [@mel.optional]
      glyphOrientationHorizontal: option(string),
      [@mel.optional]
      glyphOrientationVertical: option(string),
      [@mel.optional]
      glyphRef: option(string),
      [@mel.optional]
      gradientTransform: option(string),
      [@mel.optional]
      gradientUnits: option(string),
      [@mel.optional]
      hanging: option(string),
      [@mel.optional]
      headers: option(string),
      [@mel.optional]
      height: option(string),
      [@mel.optional]
      hidden: option(bool),
      [@mel.optional]
      high: option(int),
      [@mel.optional]
      horizAdvX: option(string),
      [@mel.optional]
      horizOriginX: option(string),
      [@mel.optional]
      href: option(string),
      [@mel.optional]
      hrefLang: option(string),
      [@mel.optional]
      htmlFor: option(string),
      [@mel.optional]
      httpEquiv: option(string),
      [@mel.optional]
      icon: option(string),
      [@mel.optional]
      id: option(string),
      [@mel.optional]
      ideographic: option(string),
      [@mel.optional]
      imageRendering: option(string),
      [@mel.optional]
      in_: option(string),
      [@mel.optional]
      in2: option(string),
      [@mel.optional]
      inlist: option(string),
      [@mel.optional]
      inputMode: option(string),
      [@mel.optional]
      integrity: option(string),
      [@mel.optional]
      intercept: option(string),
      [@mel.optional]
      itemID: option(string),
      [@mel.optional]
      itemProp: option(string),
      [@mel.optional]
      itemRef: option(string),
      [@mel.optional]
      itemScope: option(bool),
      [@mel.optional]
      itemType: option(string),
      [@mel.optional]
      k: option(string),
      [@mel.optional]
      k1: option(string),
      [@mel.optional]
      k2: option(string),
      [@mel.optional]
      k3: option(string),
      [@mel.optional]
      k4: option(string),
      [@mel.optional]
      kernelMatrix: option(string),
      [@mel.optional]
      kernelUnitLength: option(string),
      [@mel.optional]
      kerning: option(string),
      [@mel.optional]
      key: option(string),
      [@mel.optional]
      keyPoints: option(string),
      [@mel.optional]
      keySplines: option(string),
      [@mel.optional]
      keyTimes: option(string),
      [@mel.optional]
      keyType: option(string),
      [@mel.optional]
      kind: option(string),
      [@mel.optional]
      label: option(string),
      [@mel.optional]
      lang: option(string),
      [@mel.optional]
      lengthAdjust: option(string),
      [@mel.optional]
      letterSpacing: option(string),
      [@mel.optional]
      lightingColor: option(string),
      [@mel.optional]
      limitingConeAngle: option(string),
      [@mel.optional]
      list: option(string),
      [@mel.optional]
      local: option(string),
      [@mel.optional]
      loop: option(bool),
      [@mel.optional]
      low: option(int),
      [@mel.optional]
      manifest: option(string),
      [@mel.optional]
      markerEnd: option(string),
      [@mel.optional]
      markerHeight: option(string),
      [@mel.optional]
      markerMid: option(string),
      [@mel.optional]
      markerStart: option(string),
      [@mel.optional]
      markerUnits: option(string),
      [@mel.optional]
      markerWidth: option(string),
      [@mel.optional]
      mask: option(string),
      [@mel.optional]
      maskContentUnits: option(string),
      [@mel.optional]
      maskUnits: option(string),
      [@mel.optional]
      mathematical: option(string),
      [@mel.optional]
      max: option(string),
      [@mel.optional]
      maxLength: option(int),
      [@mel.optional]
      media: option(string),
      [@mel.optional]
      mediaGroup: option(string),
      [@mel.optional]
      min: option(string),
      [@mel.optional]
      minLength: option(int),
      [@mel.optional]
      mode: option(string),
      [@mel.optional]
      multiple: option(bool),
      [@mel.optional]
      muted: option(bool),
      [@mel.optional]
      name: option(string),
      [@mel.optional]
      nonce: option(string),
      [@mel.optional]
      noValidate: option(bool),
      [@mel.optional]
      numOctaves: option(string),
      [@mel.optional]
      offset: option(string),
      [@mel.optional]
      opacity: option(string),
      [@mel.optional]
      open_: option(bool),
      [@mel.optional]
      operator: option(string),
      [@mel.optional]
      optimum: option(int),
      [@mel.optional]
      order: option(string),
      [@mel.optional]
      orient: option(string),
      [@mel.optional]
      orientation: option(string),
      [@mel.optional]
      origin: option(string),
      [@mel.optional]
      overflow: option(string),
      [@mel.optional]
      overflowX: option(string),
      [@mel.optional]
      overflowY: option(string),
      [@mel.optional]
      overlinePosition: option(string),
      [@mel.optional]
      overlineThickness: option(string),
      [@mel.optional]
      paintOrder: option(string),
      [@mel.optional]
      panose1: option(string),
      [@mel.optional]
      pathLength: option(string),
      [@mel.optional]
      pattern: option(string),
      [@mel.optional]
      patternContentUnits: option(string),
      [@mel.optional]
      patternTransform: option(string),
      [@mel.optional]
      patternUnits: option(string),
      [@mel.optional]
      placeholder: option(string),
      [@mel.optional]
      pointerEvents: option(string),
      [@mel.optional]
      points: option(string),
      [@mel.optional]
      pointsAtX: option(string),
      [@mel.optional]
      pointsAtY: option(string),
      [@mel.optional]
      pointsAtZ: option(string),
      [@mel.optional]
      poster: option(string),
      [@mel.optional]
      prefix: option(string),
      [@mel.optional]
      preload: option(string),
      [@mel.optional]
      preserveAlpha: option(string),
      [@mel.optional]
      preserveAspectRatio: option(string),
      [@mel.optional]
      primitiveUnits: option(string),
      [@mel.optional]
      property: option(string),
      [@mel.optional]
      r: option(string),
      [@mel.optional]
      radioGroup: option(string),
      [@mel.optional]
      radius: option(string),
      [@mel.optional]
      readOnly: option(bool),
      [@mel.optional]
      refX: option(string),
      [@mel.optional]
      refY: option(string),
      [@mel.optional]
      rel: option(string),
      [@mel.optional]
      renderingIntent: option(string),
      [@mel.optional]
      repeatCount: option(string),
      [@mel.optional]
      repeatDur: option(string),
      [@mel.optional]
      required: option(bool),
      [@mel.optional]
      requiredExtensions: option(string),
      [@mel.optional]
      requiredFeatures: option(string),
      [@mel.optional]
      resource: option(string),
      [@mel.optional]
      restart: option(string),
      [@mel.optional]
      result: option(string),
      [@mel.optional]
      reversed: option(bool),
      [@mel.optional]
      role: option(string),
      [@mel.optional]
      rotate: option(string),
      [@mel.optional]
      rows: option(int),
      [@mel.optional]
      rowSpan: option(int),
      [@mel.optional]
      rx: option(string),
      [@mel.optional]
      ry: option(string),
      [@mel.optional]
      sandbox: option(string),
      [@mel.optional]
      scale: option(string),
      [@mel.optional]
      scope: option(string),
      [@mel.optional]
      scoped: option(bool),
      [@mel.optional]
      scrolling: option(string),
      [@mel.optional]
      seed: option(string),
      [@mel.optional]
      selected: option(bool),
      [@mel.optional]
      shape: option(string),
      [@mel.optional]
      shapeRendering: option(string),
      [@mel.optional]
      sizes: option(string),
      [@mel.optional]
      slope: option(string),
      [@mel.optional]
      spacing: option(string),
      [@mel.optional]
      span: option(int),
      [@mel.optional]
      specularConstant: option(string),
      [@mel.optional]
      specularExponent: option(string),
      [@mel.optional]
      speed: option(string),
      [@mel.optional]
      spellCheck: option(bool),
      [@mel.optional]
      spreadMethod: option(string),
      [@mel.optional]
      src: option(string),
      [@mel.optional]
      srcDoc: option(string),
      [@mel.optional]
      srcLang: option(string),
      [@mel.optional]
      srcSet: option(string),
      [@mel.optional]
      start: option(int),
      [@mel.optional]
      startOffset: option(string),
      [@mel.optional]
      stdDeviation: option(string),
      [@mel.optional]
      stemh: option(string),
      [@mel.optional]
      stemv: option(string),
      [@mel.optional]
      step: option(float),
      [@mel.optional]
      stitchTiles: option(string),
      [@mel.optional]
      stopColor: option(string),
      [@mel.optional]
      stopOpacity: option(string),
      [@mel.optional]
      strikethroughPosition: option(string),
      [@mel.optional]
      strikethroughThickness: option(string),
      [@mel.optional]
      stroke: option(string),
      [@mel.optional]
      strokeDasharray: option(string),
      [@mel.optional]
      strokeDashoffset: option(string),
      [@mel.optional]
      strokeLinecap: option(string),
      [@mel.optional]
      strokeLinejoin: option(string),
      [@mel.optional]
      strokeMiterlimit: option(string),
      [@mel.optional]
      strokeOpacity: option(string),
      [@mel.optional]
      strokeWidth: option(string),
      [@mel.optional]
      style: option(ReactDOM.Style.t),
      [@mel.optional]
      summary: option(string),
      [@mel.optional]
      suppressContentEditableWarning: option(bool),
      [@mel.optional]
      surfaceScale: option(string),
      [@mel.optional]
      systemLanguage: option(string),
      [@mel.optional]
      tabIndex: option(int),
      [@mel.optional]
      tableValues: option(string),
      [@mel.optional]
      target: option(string),
      [@mel.optional]
      targetX: option(string),
      [@mel.optional]
      targetY: option(string),
      [@mel.optional]
      textAnchor: option(string),
      [@mel.optional]
      textDecoration: option(string),
      [@mel.optional]
      textLength: option(string),
      [@mel.optional]
      textRendering: option(string),
      [@mel.optional]
      title: option(string),
      [@mel.optional]
      to_: option(string),
      [@mel.optional]
      transform: option(string),
      [@mel.optional] [@mel.as "type"]
      type_: option(string),
      [@mel.optional]
      typeof: option(string),
      [@mel.optional]
      u1: option(string),
      [@mel.optional]
      u2: option(string),
      [@mel.optional]
      underlinePosition: option(string),
      [@mel.optional]
      underlineThickness: option(string),
      [@mel.optional]
      unicode: option(string),
      [@mel.optional]
      unicodeBidi: option(string),
      [@mel.optional]
      unicodeRange: option(string),
      [@mel.optional]
      unitsPerEm: option(string),
      [@mel.optional]
      useMap: option(string),
      [@mel.optional]
      vAlphabetic: option(string),
      [@mel.optional]
      value: option(string),
      [@mel.optional]
      values: option(string),
      [@mel.optional]
      vectorEffect: option(string),
      [@mel.optional]
      version: option(string),
      [@mel.optional]
      vertAdvX: option(string),
      [@mel.optional]
      vertAdvY: option(string),
      [@mel.optional]
      vertOriginX: option(string),
      [@mel.optional]
      vertOriginY: option(string),
      [@mel.optional]
      vHanging: option(string),
      [@mel.optional]
      vIdeographic: option(string),
      [@mel.optional]
      viewBox: option(string),
      [@mel.optional]
      viewTarget: option(string),
      [@mel.optional]
      visibility: option(string),
      [@mel.optional]
      vMathematical: option(string),
      [@mel.optional]
      vocab: option(string),
      [@mel.optional]
      width: option(string),
      [@mel.optional]
      widths: option(string),
      [@mel.optional]
      wordSpacing: option(string),
      [@mel.optional]
      wrap: option(string),
      [@mel.optional]
      writingMode: option(string),
      [@mel.optional]
      x: option(string),
      [@mel.optional]
      x1: option(string),
      [@mel.optional]
      x2: option(string),
      [@mel.optional]
      xChannelSelector: option(string),
      [@mel.optional]
      xHeight: option(string),
      [@mel.optional]
      xlinkActuate: option(string),
      [@mel.optional]
      xlinkArcrole: option(string),
      [@mel.optional]
      xlinkHref: option(string),
      [@mel.optional]
      xlinkRole: option(string),
      [@mel.optional]
      xlinkShow: option(string),
      [@mel.optional]
      xlinkTitle: option(string),
      [@mel.optional]
      xlinkType: option(string),
      [@mel.optional]
      xmlBase: option(string),
      [@mel.optional]
      xmlLang: option(string),
      [@mel.optional]
      xmlns: option(string),
      [@mel.optional]
      xmlnsXlink: option(string),
      [@mel.optional]
      xmlSpace: option(string),
      [@mel.optional]
      y: option(string),
      [@mel.optional]
      y1: option(string),
      [@mel.optional]
      y2: option(string),
      [@mel.optional]
      yChannelSelector: option(string),
      [@mel.optional]
      z: option(string),
      [@mel.optional]
      zoomAndPan: option(string),
      [@mel.optional]
      onAbort: option(React.Event.Media.t => unit),
      [@mel.optional]
      onAnimationEnd: option(React.Event.Animation.t => unit),
      [@mel.optional]
      onAnimationIteration: option(React.Event.Animation.t => unit),
      [@mel.optional]
      onAnimationStart: option(React.Event.Animation.t => unit),
      [@mel.optional]
      onBlur: option(React.Event.Focus.t => unit),
      [@mel.optional]
      onCanPlay: option(React.Event.Media.t => unit),
      [@mel.optional]
      onCanPlayThrough: option(React.Event.Media.t => unit),
      [@mel.optional]
      onChange: option(React.Event.Form.t => unit),
      [@mel.optional]
      onClick: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onCompositionEnd: option(React.Event.Composition.t => unit),
      [@mel.optional]
      onCompositionStart: option(React.Event.Composition.t => unit),
      [@mel.optional]
      onCompositionUpdate: option(React.Event.Composition.t => unit),
      [@mel.optional]
      onContextMenu: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onCopy: option(React.Event.Clipboard.t => unit),
      [@mel.optional]
      onCut: option(React.Event.Clipboard.t => unit),
      [@mel.optional]
      onDoubleClick: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDrag: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragEnd: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragEnter: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragExit: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragLeave: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragOver: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragStart: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDrop: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDurationChange: option(React.Event.Media.t => unit),
      [@mel.optional]
      onEmptied: option(React.Event.Media.t => unit),
      [@mel.optional]
      onEncrypetd: option(React.Event.Media.t => unit),
      [@mel.optional]
      onEnded: option(React.Event.Media.t => unit),
      [@mel.optional]
      onError: option(React.Event.Media.t => unit),
      [@mel.optional]
      onFocus: option(React.Event.Focus.t => unit),
      [@mel.optional]
      onInput: option(React.Event.Form.t => unit),
      [@mel.optional]
      onKeyDown: option(React.Event.Keyboard.t => unit),
      [@mel.optional]
      onKeyPress: option(React.Event.Keyboard.t => unit),
      [@mel.optional]
      onKeyUp: option(React.Event.Keyboard.t => unit),
      [@mel.optional]
      onLoadedData: option(React.Event.Media.t => unit),
      [@mel.optional]
      onLoadedMetadata: option(React.Event.Media.t => unit),
      [@mel.optional]
      onLoadStart: option(React.Event.Media.t => unit),
      [@mel.optional]
      onMouseDown: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseEnter: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseLeave: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseMove: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseOut: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseOver: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseUp: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onPaste: option(React.Event.Clipboard.t => unit),
      [@mel.optional]
      onPause: option(React.Event.Media.t => unit),
      [@mel.optional]
      onPlay: option(React.Event.Media.t => unit),
      [@mel.optional]
      onPlaying: option(React.Event.Media.t => unit),
      [@mel.optional]
      onProgress: option(React.Event.Media.t => unit),
      [@mel.optional]
      onRateChange: option(React.Event.Media.t => unit),
      [@mel.optional]
      onScroll: option(React.Event.UI.t => unit),
      [@mel.optional]
      onSeeked: option(React.Event.Media.t => unit),
      [@mel.optional]
      onSeeking: option(React.Event.Media.t => unit),
      [@mel.optional]
      onSelect: option(React.Event.Selection.t => unit),
      [@mel.optional]
      onStalled: option(React.Event.Media.t => unit),
      [@mel.optional]
      onSubmit: option(React.Event.Form.t => unit),
      [@mel.optional]
      onSuspend: option(React.Event.Media.t => unit),
      [@mel.optional]
      onTimeUpdate: option(React.Event.Media.t => unit),
      [@mel.optional]
      onTouchCancel: option(React.Event.Touch.t => unit),
      [@mel.optional]
      onTouchEnd: option(React.Event.Touch.t => unit),
      [@mel.optional]
      onTouchMove: option(React.Event.Touch.t => unit),
      [@mel.optional]
      onTouchStart: option(React.Event.Touch.t => unit),
      [@mel.optional]
      onTransitionEnd: option(React.Event.Transition.t => unit),
      [@mel.optional]
      onVolumeChange: option(React.Event.Media.t => unit),
      [@mel.optional]
      onWaiting: option(React.Event.Media.t => unit),
      [@mel.optional]
      onWheel: option(React.Event.Wheel.t => unit),
      size: 'size,
    };
    [@mel.module "react"]
    external createVariadicElement: (string, Js.t({..})) => React.element =
      "createElement";
    let deleteProp = [%mel.raw "(newProps, key) => delete newProps[key]"];
    let getOrEmpty = str =>
      switch (str) {
      | Some(str) => " " ++ str
      | None => ""
      };
    external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
      "Object.assign";
    let styles = (~size, _) => {
      Js.log("Logging when render");
      CSS.style([|(CSS.width(size): CSS.rule), CSS.display(`block)|]);
    };
    let make = (props: makeProps('size)) => {
      let className =
        styles(~size=sizeGet(props), ()) ++ getOrEmpty(classNameGet(props));
      let stylesObject = {
        "className": className,
        "ref": innerRefGet(props),
      };
      let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
      ignore(deleteProp(. newProps, "size"));
      ignore(deleteProp(. newProps, "innerRef"));
      let asTag = as_Get(props);
      ignore(deleteProp(. newProps, "as"));
      createVariadicElement(
        switch (asTag) {
        | Some(as_) => as_
        | None => "div"
        },
        newProps,
      );
    };
  };
  module DynamicComponentWithSequence = {
    [@deriving (jsProperties, getSet)]
    type makeProps('variant) = {
      [@mel.optional]
      innerRef: option(ReactDOM.domRef),
      [@mel.optional]
      children: option(React.element),
      [@mel.optional] [@mel.as "as"]
      as_: option(string),
      [@mel.optional]
      about: option(string),
      [@mel.optional]
      accentHeight: option(string),
      [@mel.optional]
      accept: option(string),
      [@mel.optional]
      acceptCharset: option(string),
      [@mel.optional]
      accessKey: option(string),
      [@mel.optional]
      accumulate: option(string),
      [@mel.optional]
      action: option(string),
      [@mel.optional]
      additive: option(string),
      [@mel.optional]
      alignmentBaseline: option(string),
      [@mel.optional]
      allowFullScreen: option(bool),
      [@mel.optional]
      allowReorder: option(string),
      [@mel.optional]
      alphabetic: option(string),
      [@mel.optional]
      alt: option(string),
      [@mel.optional]
      amplitude: option(string),
      [@mel.optional]
      arabicForm: option(string),
      [@mel.optional] [@mel.as "aria-activedescendant"]
      ariaActivedescendant: option(string),
      [@mel.optional] [@mel.as "aria-atomic"]
      ariaAtomic: option(bool),
      [@mel.optional] [@mel.as "aria-busy"]
      ariaBusy: option(bool),
      [@mel.optional] [@mel.as "aria-colcount"]
      ariaColcount: option(int),
      [@mel.optional] [@mel.as "aria-colindex"]
      ariaColindex: option(int),
      [@mel.optional] [@mel.as "aria-colspan"]
      ariaColspan: option(int),
      [@mel.optional] [@mel.as "aria-controls"]
      ariaControls: option(string),
      [@mel.optional] [@mel.as "aria-describedby"]
      ariaDescribedby: option(string),
      [@mel.optional] [@mel.as "aria-details"]
      ariaDetails: option(string),
      [@mel.optional] [@mel.as "aria-disabled"]
      ariaDisabled: option(bool),
      [@mel.optional] [@mel.as "aria-errormessage"]
      ariaErrormessage: option(string),
      [@mel.optional] [@mel.as "aria-expanded"]
      ariaExpanded: option(bool),
      [@mel.optional] [@mel.as "aria-flowto"]
      ariaFlowto: option(string),
      [@mel.optional] [@mel.as "aria-grabbed"]
      ariaGrabbed: option(bool),
      [@mel.optional] [@mel.as "aria-hidden"]
      ariaHidden: option(bool),
      [@mel.optional] [@mel.as "aria-keyshortcuts"]
      ariaKeyshortcuts: option(string),
      [@mel.optional] [@mel.as "aria-label"]
      ariaLabel: option(string),
      [@mel.optional] [@mel.as "aria-labelledby"]
      ariaLabelledby: option(string),
      [@mel.optional] [@mel.as "aria-level"]
      ariaLevel: option(int),
      [@mel.optional] [@mel.as "aria-modal"]
      ariaModal: option(bool),
      [@mel.optional] [@mel.as "aria-multiline"]
      ariaMultiline: option(bool),
      [@mel.optional] [@mel.as "aria-multiselectable"]
      ariaMultiselectable: option(bool),
      [@mel.optional] [@mel.as "aria-owns"]
      ariaOwns: option(string),
      [@mel.optional] [@mel.as "aria-placeholder"]
      ariaPlaceholder: option(string),
      [@mel.optional] [@mel.as "aria-posinset"]
      ariaPosinset: option(int),
      [@mel.optional] [@mel.as "aria-readonly"]
      ariaReadonly: option(bool),
      [@mel.optional] [@mel.as "aria-relevant"]
      ariaRelevant: option(string),
      [@mel.optional] [@mel.as "aria-required"]
      ariaRequired: option(bool),
      [@mel.optional] [@mel.as "aria-roledescription"]
      ariaRoledescription: option(string),
      [@mel.optional] [@mel.as "aria-rowcount"]
      ariaRowcount: option(int),
      [@mel.optional] [@mel.as "aria-rowindex"]
      ariaRowindex: option(int),
      [@mel.optional] [@mel.as "aria-rowspan"]
      ariaRowspan: option(int),
      [@mel.optional] [@mel.as "aria-selected"]
      ariaSelected: option(bool),
      [@mel.optional] [@mel.as "aria-setsize"]
      ariaSetsize: option(int),
      [@mel.optional] [@mel.as "aria-sort"]
      ariaSort: option(string),
      [@mel.optional] [@mel.as "aria-valuemax"]
      ariaValuemax: option(float),
      [@mel.optional] [@mel.as "aria-valuemin"]
      ariaValuemin: option(float),
      [@mel.optional] [@mel.as "aria-valuenow"]
      ariaValuenow: option(float),
      [@mel.optional] [@mel.as "aria-valuetext"]
      ariaValuetext: option(string),
      [@mel.optional]
      ascent: option(string),
      [@mel.optional]
      async: option(bool),
      [@mel.optional]
      attributeName: option(string),
      [@mel.optional]
      attributeType: option(string),
      [@mel.optional]
      autoComplete: option(string),
      [@mel.optional]
      autoFocus: option(bool),
      [@mel.optional]
      autoPlay: option(bool),
      [@mel.optional]
      autoReverse: option(string),
      [@mel.optional]
      azimuth: option(string),
      [@mel.optional]
      baseFrequency: option(string),
      [@mel.optional]
      baselineShift: option(string),
      [@mel.optional]
      baseProfile: option(string),
      [@mel.optional]
      bbox: option(string),
      [@mel.optional]
      begin_: option(string),
      [@mel.optional]
      bias: option(string),
      [@mel.optional]
      by: option(string),
      [@mel.optional]
      calcMode: option(string),
      [@mel.optional]
      capHeight: option(string),
      [@mel.optional]
      challenge: option(string),
      [@mel.optional]
      charSet: option(string),
      [@mel.optional]
      checked: option(bool),
      [@mel.optional]
      cite: option(string),
      [@mel.optional]
      className: option(string),
      [@mel.optional]
      clip: option(string),
      [@mel.optional]
      clipPath: option(string),
      [@mel.optional]
      clipPathUnits: option(string),
      [@mel.optional]
      clipRule: option(string),
      [@mel.optional]
      colorInterpolation: option(string),
      [@mel.optional]
      colorInterpolationFilters: option(string),
      [@mel.optional]
      colorProfile: option(string),
      [@mel.optional]
      colorRendering: option(string),
      [@mel.optional]
      cols: option(int),
      [@mel.optional]
      colSpan: option(int),
      [@mel.optional]
      content: option(string),
      [@mel.optional]
      contentEditable: option(bool),
      [@mel.optional]
      contentScriptType: option(string),
      [@mel.optional]
      contentStyleType: option(string),
      [@mel.optional]
      contextMenu: option(string),
      [@mel.optional]
      controls: option(bool),
      [@mel.optional]
      coords: option(string),
      [@mel.optional]
      crossOrigin: option(string),
      [@mel.optional]
      cursor: option(string),
      [@mel.optional]
      cx: option(string),
      [@mel.optional]
      cy: option(string),
      [@mel.optional]
      d: option(string),
      [@mel.optional]
      data: option(string),
      [@mel.optional]
      datatype: option(string),
      [@mel.optional]
      dateTime: option(string),
      [@mel.optional]
      decelerate: option(string),
      [@mel.optional]
      default: option(bool),
      [@mel.optional]
      defaultChecked: option(bool),
      [@mel.optional]
      defaultValue: option(string),
      [@mel.optional]
      defer: option(bool),
      [@mel.optional]
      descent: option(string),
      [@mel.optional]
      diffuseConstant: option(string),
      [@mel.optional]
      dir: option(string),
      [@mel.optional]
      direction: option(string),
      [@mel.optional]
      disabled: option(bool),
      [@mel.optional]
      display: option(string),
      [@mel.optional]
      divisor: option(string),
      [@mel.optional]
      dominantBaseline: option(string),
      [@mel.optional]
      download: option(string),
      [@mel.optional]
      draggable: option(bool),
      [@mel.optional]
      dur: option(string),
      [@mel.optional]
      dx: option(string),
      [@mel.optional]
      dy: option(string),
      [@mel.optional]
      edgeMode: option(string),
      [@mel.optional]
      elevation: option(string),
      [@mel.optional]
      enableBackground: option(string),
      [@mel.optional]
      encType: option(string),
      [@mel.optional]
      end_: option(string),
      [@mel.optional]
      exponent: option(string),
      [@mel.optional]
      externalResourcesRequired: option(string),
      [@mel.optional]
      fill: option(string),
      [@mel.optional]
      fillOpacity: option(string),
      [@mel.optional]
      fillRule: option(string),
      [@mel.optional]
      filter: option(string),
      [@mel.optional]
      filterRes: option(string),
      [@mel.optional]
      filterUnits: option(string),
      [@mel.optional]
      floodColor: option(string),
      [@mel.optional]
      floodOpacity: option(string),
      [@mel.optional]
      focusable: option(string),
      [@mel.optional]
      fomat: option(string),
      [@mel.optional]
      fontFamily: option(string),
      [@mel.optional]
      fontSize: option(string),
      [@mel.optional]
      fontSizeAdjust: option(string),
      [@mel.optional]
      fontStretch: option(string),
      [@mel.optional]
      fontStyle: option(string),
      [@mel.optional]
      fontVariant: option(string),
      [@mel.optional]
      fontWeight: option(string),
      [@mel.optional]
      form: option(string),
      [@mel.optional]
      formAction: option(string),
      [@mel.optional]
      formMethod: option(string),
      [@mel.optional]
      formTarget: option(string),
      [@mel.optional]
      from: option(string),
      [@mel.optional]
      fx: option(string),
      [@mel.optional]
      fy: option(string),
      [@mel.optional]
      g1: option(string),
      [@mel.optional]
      g2: option(string),
      [@mel.optional]
      glyphName: option(string),
      [@mel.optional]
      glyphOrientationHorizontal: option(string),
      [@mel.optional]
      glyphOrientationVertical: option(string),
      [@mel.optional]
      glyphRef: option(string),
      [@mel.optional]
      gradientTransform: option(string),
      [@mel.optional]
      gradientUnits: option(string),
      [@mel.optional]
      hanging: option(string),
      [@mel.optional]
      headers: option(string),
      [@mel.optional]
      height: option(string),
      [@mel.optional]
      hidden: option(bool),
      [@mel.optional]
      high: option(int),
      [@mel.optional]
      horizAdvX: option(string),
      [@mel.optional]
      horizOriginX: option(string),
      [@mel.optional]
      href: option(string),
      [@mel.optional]
      hrefLang: option(string),
      [@mel.optional]
      htmlFor: option(string),
      [@mel.optional]
      httpEquiv: option(string),
      [@mel.optional]
      icon: option(string),
      [@mel.optional]
      id: option(string),
      [@mel.optional]
      ideographic: option(string),
      [@mel.optional]
      imageRendering: option(string),
      [@mel.optional]
      in_: option(string),
      [@mel.optional]
      in2: option(string),
      [@mel.optional]
      inlist: option(string),
      [@mel.optional]
      inputMode: option(string),
      [@mel.optional]
      integrity: option(string),
      [@mel.optional]
      intercept: option(string),
      [@mel.optional]
      itemID: option(string),
      [@mel.optional]
      itemProp: option(string),
      [@mel.optional]
      itemRef: option(string),
      [@mel.optional]
      itemScope: option(bool),
      [@mel.optional]
      itemType: option(string),
      [@mel.optional]
      k: option(string),
      [@mel.optional]
      k1: option(string),
      [@mel.optional]
      k2: option(string),
      [@mel.optional]
      k3: option(string),
      [@mel.optional]
      k4: option(string),
      [@mel.optional]
      kernelMatrix: option(string),
      [@mel.optional]
      kernelUnitLength: option(string),
      [@mel.optional]
      kerning: option(string),
      [@mel.optional]
      key: option(string),
      [@mel.optional]
      keyPoints: option(string),
      [@mel.optional]
      keySplines: option(string),
      [@mel.optional]
      keyTimes: option(string),
      [@mel.optional]
      keyType: option(string),
      [@mel.optional]
      kind: option(string),
      [@mel.optional]
      label: option(string),
      [@mel.optional]
      lang: option(string),
      [@mel.optional]
      lengthAdjust: option(string),
      [@mel.optional]
      letterSpacing: option(string),
      [@mel.optional]
      lightingColor: option(string),
      [@mel.optional]
      limitingConeAngle: option(string),
      [@mel.optional]
      list: option(string),
      [@mel.optional]
      local: option(string),
      [@mel.optional]
      loop: option(bool),
      [@mel.optional]
      low: option(int),
      [@mel.optional]
      manifest: option(string),
      [@mel.optional]
      markerEnd: option(string),
      [@mel.optional]
      markerHeight: option(string),
      [@mel.optional]
      markerMid: option(string),
      [@mel.optional]
      markerStart: option(string),
      [@mel.optional]
      markerUnits: option(string),
      [@mel.optional]
      markerWidth: option(string),
      [@mel.optional]
      mask: option(string),
      [@mel.optional]
      maskContentUnits: option(string),
      [@mel.optional]
      maskUnits: option(string),
      [@mel.optional]
      mathematical: option(string),
      [@mel.optional]
      max: option(string),
      [@mel.optional]
      maxLength: option(int),
      [@mel.optional]
      media: option(string),
      [@mel.optional]
      mediaGroup: option(string),
      [@mel.optional]
      min: option(string),
      [@mel.optional]
      minLength: option(int),
      [@mel.optional]
      mode: option(string),
      [@mel.optional]
      multiple: option(bool),
      [@mel.optional]
      muted: option(bool),
      [@mel.optional]
      name: option(string),
      [@mel.optional]
      nonce: option(string),
      [@mel.optional]
      noValidate: option(bool),
      [@mel.optional]
      numOctaves: option(string),
      [@mel.optional]
      offset: option(string),
      [@mel.optional]
      opacity: option(string),
      [@mel.optional]
      open_: option(bool),
      [@mel.optional]
      operator: option(string),
      [@mel.optional]
      optimum: option(int),
      [@mel.optional]
      order: option(string),
      [@mel.optional]
      orient: option(string),
      [@mel.optional]
      orientation: option(string),
      [@mel.optional]
      origin: option(string),
      [@mel.optional]
      overflow: option(string),
      [@mel.optional]
      overflowX: option(string),
      [@mel.optional]
      overflowY: option(string),
      [@mel.optional]
      overlinePosition: option(string),
      [@mel.optional]
      overlineThickness: option(string),
      [@mel.optional]
      paintOrder: option(string),
      [@mel.optional]
      panose1: option(string),
      [@mel.optional]
      pathLength: option(string),
      [@mel.optional]
      pattern: option(string),
      [@mel.optional]
      patternContentUnits: option(string),
      [@mel.optional]
      patternTransform: option(string),
      [@mel.optional]
      patternUnits: option(string),
      [@mel.optional]
      placeholder: option(string),
      [@mel.optional]
      pointerEvents: option(string),
      [@mel.optional]
      points: option(string),
      [@mel.optional]
      pointsAtX: option(string),
      [@mel.optional]
      pointsAtY: option(string),
      [@mel.optional]
      pointsAtZ: option(string),
      [@mel.optional]
      poster: option(string),
      [@mel.optional]
      prefix: option(string),
      [@mel.optional]
      preload: option(string),
      [@mel.optional]
      preserveAlpha: option(string),
      [@mel.optional]
      preserveAspectRatio: option(string),
      [@mel.optional]
      primitiveUnits: option(string),
      [@mel.optional]
      property: option(string),
      [@mel.optional]
      r: option(string),
      [@mel.optional]
      radioGroup: option(string),
      [@mel.optional]
      radius: option(string),
      [@mel.optional]
      readOnly: option(bool),
      [@mel.optional]
      refX: option(string),
      [@mel.optional]
      refY: option(string),
      [@mel.optional]
      rel: option(string),
      [@mel.optional]
      renderingIntent: option(string),
      [@mel.optional]
      repeatCount: option(string),
      [@mel.optional]
      repeatDur: option(string),
      [@mel.optional]
      required: option(bool),
      [@mel.optional]
      requiredExtensions: option(string),
      [@mel.optional]
      requiredFeatures: option(string),
      [@mel.optional]
      resource: option(string),
      [@mel.optional]
      restart: option(string),
      [@mel.optional]
      result: option(string),
      [@mel.optional]
      reversed: option(bool),
      [@mel.optional]
      role: option(string),
      [@mel.optional]
      rotate: option(string),
      [@mel.optional]
      rows: option(int),
      [@mel.optional]
      rowSpan: option(int),
      [@mel.optional]
      rx: option(string),
      [@mel.optional]
      ry: option(string),
      [@mel.optional]
      sandbox: option(string),
      [@mel.optional]
      scale: option(string),
      [@mel.optional]
      scope: option(string),
      [@mel.optional]
      scoped: option(bool),
      [@mel.optional]
      scrolling: option(string),
      [@mel.optional]
      seed: option(string),
      [@mel.optional]
      selected: option(bool),
      [@mel.optional]
      shape: option(string),
      [@mel.optional]
      shapeRendering: option(string),
      [@mel.optional]
      size: option(int),
      [@mel.optional]
      sizes: option(string),
      [@mel.optional]
      slope: option(string),
      [@mel.optional]
      spacing: option(string),
      [@mel.optional]
      span: option(int),
      [@mel.optional]
      specularConstant: option(string),
      [@mel.optional]
      specularExponent: option(string),
      [@mel.optional]
      speed: option(string),
      [@mel.optional]
      spellCheck: option(bool),
      [@mel.optional]
      spreadMethod: option(string),
      [@mel.optional]
      src: option(string),
      [@mel.optional]
      srcDoc: option(string),
      [@mel.optional]
      srcLang: option(string),
      [@mel.optional]
      srcSet: option(string),
      [@mel.optional]
      start: option(int),
      [@mel.optional]
      startOffset: option(string),
      [@mel.optional]
      stdDeviation: option(string),
      [@mel.optional]
      stemh: option(string),
      [@mel.optional]
      stemv: option(string),
      [@mel.optional]
      step: option(float),
      [@mel.optional]
      stitchTiles: option(string),
      [@mel.optional]
      stopColor: option(string),
      [@mel.optional]
      stopOpacity: option(string),
      [@mel.optional]
      strikethroughPosition: option(string),
      [@mel.optional]
      strikethroughThickness: option(string),
      [@mel.optional]
      stroke: option(string),
      [@mel.optional]
      strokeDasharray: option(string),
      [@mel.optional]
      strokeDashoffset: option(string),
      [@mel.optional]
      strokeLinecap: option(string),
      [@mel.optional]
      strokeLinejoin: option(string),
      [@mel.optional]
      strokeMiterlimit: option(string),
      [@mel.optional]
      strokeOpacity: option(string),
      [@mel.optional]
      strokeWidth: option(string),
      [@mel.optional]
      style: option(ReactDOM.Style.t),
      [@mel.optional]
      summary: option(string),
      [@mel.optional]
      suppressContentEditableWarning: option(bool),
      [@mel.optional]
      surfaceScale: option(string),
      [@mel.optional]
      systemLanguage: option(string),
      [@mel.optional]
      tabIndex: option(int),
      [@mel.optional]
      tableValues: option(string),
      [@mel.optional]
      target: option(string),
      [@mel.optional]
      targetX: option(string),
      [@mel.optional]
      targetY: option(string),
      [@mel.optional]
      textAnchor: option(string),
      [@mel.optional]
      textDecoration: option(string),
      [@mel.optional]
      textLength: option(string),
      [@mel.optional]
      textRendering: option(string),
      [@mel.optional]
      title: option(string),
      [@mel.optional]
      to_: option(string),
      [@mel.optional]
      transform: option(string),
      [@mel.optional] [@mel.as "type"]
      type_: option(string),
      [@mel.optional]
      typeof: option(string),
      [@mel.optional]
      u1: option(string),
      [@mel.optional]
      u2: option(string),
      [@mel.optional]
      underlinePosition: option(string),
      [@mel.optional]
      underlineThickness: option(string),
      [@mel.optional]
      unicode: option(string),
      [@mel.optional]
      unicodeBidi: option(string),
      [@mel.optional]
      unicodeRange: option(string),
      [@mel.optional]
      unitsPerEm: option(string),
      [@mel.optional]
      useMap: option(string),
      [@mel.optional]
      vAlphabetic: option(string),
      [@mel.optional]
      value: option(string),
      [@mel.optional]
      values: option(string),
      [@mel.optional]
      vectorEffect: option(string),
      [@mel.optional]
      version: option(string),
      [@mel.optional]
      vertAdvX: option(string),
      [@mel.optional]
      vertAdvY: option(string),
      [@mel.optional]
      vertOriginX: option(string),
      [@mel.optional]
      vertOriginY: option(string),
      [@mel.optional]
      vHanging: option(string),
      [@mel.optional]
      vIdeographic: option(string),
      [@mel.optional]
      viewBox: option(string),
      [@mel.optional]
      viewTarget: option(string),
      [@mel.optional]
      visibility: option(string),
      [@mel.optional]
      vMathematical: option(string),
      [@mel.optional]
      vocab: option(string),
      [@mel.optional]
      width: option(string),
      [@mel.optional]
      widths: option(string),
      [@mel.optional]
      wordSpacing: option(string),
      [@mel.optional]
      wrap: option(string),
      [@mel.optional]
      writingMode: option(string),
      [@mel.optional]
      x: option(string),
      [@mel.optional]
      x1: option(string),
      [@mel.optional]
      x2: option(string),
      [@mel.optional]
      xChannelSelector: option(string),
      [@mel.optional]
      xHeight: option(string),
      [@mel.optional]
      xlinkActuate: option(string),
      [@mel.optional]
      xlinkArcrole: option(string),
      [@mel.optional]
      xlinkHref: option(string),
      [@mel.optional]
      xlinkRole: option(string),
      [@mel.optional]
      xlinkShow: option(string),
      [@mel.optional]
      xlinkTitle: option(string),
      [@mel.optional]
      xlinkType: option(string),
      [@mel.optional]
      xmlBase: option(string),
      [@mel.optional]
      xmlLang: option(string),
      [@mel.optional]
      xmlns: option(string),
      [@mel.optional]
      xmlnsXlink: option(string),
      [@mel.optional]
      xmlSpace: option(string),
      [@mel.optional]
      y: option(string),
      [@mel.optional]
      y1: option(string),
      [@mel.optional]
      y2: option(string),
      [@mel.optional]
      yChannelSelector: option(string),
      [@mel.optional]
      z: option(string),
      [@mel.optional]
      zoomAndPan: option(string),
      [@mel.optional]
      onAbort: option(React.Event.Media.t => unit),
      [@mel.optional]
      onAnimationEnd: option(React.Event.Animation.t => unit),
      [@mel.optional]
      onAnimationIteration: option(React.Event.Animation.t => unit),
      [@mel.optional]
      onAnimationStart: option(React.Event.Animation.t => unit),
      [@mel.optional]
      onBlur: option(React.Event.Focus.t => unit),
      [@mel.optional]
      onCanPlay: option(React.Event.Media.t => unit),
      [@mel.optional]
      onCanPlayThrough: option(React.Event.Media.t => unit),
      [@mel.optional]
      onChange: option(React.Event.Form.t => unit),
      [@mel.optional]
      onClick: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onCompositionEnd: option(React.Event.Composition.t => unit),
      [@mel.optional]
      onCompositionStart: option(React.Event.Composition.t => unit),
      [@mel.optional]
      onCompositionUpdate: option(React.Event.Composition.t => unit),
      [@mel.optional]
      onContextMenu: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onCopy: option(React.Event.Clipboard.t => unit),
      [@mel.optional]
      onCut: option(React.Event.Clipboard.t => unit),
      [@mel.optional]
      onDoubleClick: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDrag: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragEnd: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragEnter: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragExit: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragLeave: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragOver: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDragStart: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDrop: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onDurationChange: option(React.Event.Media.t => unit),
      [@mel.optional]
      onEmptied: option(React.Event.Media.t => unit),
      [@mel.optional]
      onEncrypetd: option(React.Event.Media.t => unit),
      [@mel.optional]
      onEnded: option(React.Event.Media.t => unit),
      [@mel.optional]
      onError: option(React.Event.Media.t => unit),
      [@mel.optional]
      onFocus: option(React.Event.Focus.t => unit),
      [@mel.optional]
      onInput: option(React.Event.Form.t => unit),
      [@mel.optional]
      onKeyDown: option(React.Event.Keyboard.t => unit),
      [@mel.optional]
      onKeyPress: option(React.Event.Keyboard.t => unit),
      [@mel.optional]
      onKeyUp: option(React.Event.Keyboard.t => unit),
      [@mel.optional]
      onLoadedData: option(React.Event.Media.t => unit),
      [@mel.optional]
      onLoadedMetadata: option(React.Event.Media.t => unit),
      [@mel.optional]
      onLoadStart: option(React.Event.Media.t => unit),
      [@mel.optional]
      onMouseDown: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseEnter: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseLeave: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseMove: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseOut: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseOver: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onMouseUp: option(React.Event.Mouse.t => unit),
      [@mel.optional]
      onPaste: option(React.Event.Clipboard.t => unit),
      [@mel.optional]
      onPause: option(React.Event.Media.t => unit),
      [@mel.optional]
      onPlay: option(React.Event.Media.t => unit),
      [@mel.optional]
      onPlaying: option(React.Event.Media.t => unit),
      [@mel.optional]
      onProgress: option(React.Event.Media.t => unit),
      [@mel.optional]
      onRateChange: option(React.Event.Media.t => unit),
      [@mel.optional]
      onScroll: option(React.Event.UI.t => unit),
      [@mel.optional]
      onSeeked: option(React.Event.Media.t => unit),
      [@mel.optional]
      onSeeking: option(React.Event.Media.t => unit),
      [@mel.optional]
      onSelect: option(React.Event.Selection.t => unit),
      [@mel.optional]
      onStalled: option(React.Event.Media.t => unit),
      [@mel.optional]
      onSubmit: option(React.Event.Form.t => unit),
      [@mel.optional]
      onSuspend: option(React.Event.Media.t => unit),
      [@mel.optional]
      onTimeUpdate: option(React.Event.Media.t => unit),
      [@mel.optional]
      onTouchCancel: option(React.Event.Touch.t => unit),
      [@mel.optional]
      onTouchEnd: option(React.Event.Touch.t => unit),
      [@mel.optional]
      onTouchMove: option(React.Event.Touch.t => unit),
      [@mel.optional]
      onTouchStart: option(React.Event.Touch.t => unit),
      [@mel.optional]
      onTransitionEnd: option(React.Event.Transition.t => unit),
      [@mel.optional]
      onVolumeChange: option(React.Event.Media.t => unit),
      [@mel.optional]
      onWaiting: option(React.Event.Media.t => unit),
      [@mel.optional]
      onWheel: option(React.Event.Wheel.t => unit),
      variant: 'variant,
    };
    [@mel.module "react"]
    external createVariadicElement: (string, Js.t({..})) => React.element =
      "createElement";
    let deleteProp = [%mel.raw "(newProps, key) => delete newProps[key]"];
    let getOrEmpty = str =>
      switch (str) {
      | Some(str) => " " ++ str
      | None => ""
      };
    external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
      "Object.assign";
    let styles = (~variant, _) => {
      let color = Theme.button(variant);
      CSS.style([|
        CSS.display(`inlineFlex),
        (CSS.color(color): CSS.rule),
        CSS.width(`percent(100.)),
      |]);
    };
    let make = (props: makeProps('variant)) => {
      let className =
        styles(~variant=variantGet(props), ())
        ++ getOrEmpty(classNameGet(props));
      let stylesObject = {
        "className": className,
        "ref": innerRefGet(props),
      };
      let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
      ignore(deleteProp(. newProps, "variant"));
      ignore(deleteProp(. newProps, "innerRef"));
      let asTag = as_Get(props);
      ignore(deleteProp(. newProps, "as"));
      createVariadicElement(
        switch (asTag) {
        | Some(as_) => as_
        | None => "button"
        },
        newProps,
      );
    };
  };
