  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module OneSingleProperty = {
    [@deriving abstract]
    type makeProps = {
      [@mel.optional]
      innerRef: ReactDOM.domRef,
      [@mel.optional]
      children: React.element,
      [@mel.optional]
      about: string,
      [@mel.optional]
      accentHeight: string,
      [@mel.optional]
      accept: string,
      [@mel.optional]
      acceptCharset: string,
      [@mel.optional]
      accessKey: string,
      [@mel.optional]
      accumulate: string,
      [@mel.optional]
      action: string,
      [@mel.optional]
      additive: string,
      [@mel.optional]
      alignmentBaseline: string,
      [@mel.optional]
      allowFullScreen: bool,
      [@mel.optional]
      allowReorder: string,
      [@mel.optional]
      alphabetic: string,
      [@mel.optional]
      alt: string,
      [@mel.optional]
      amplitude: string,
      [@mel.optional]
      arabicForm: string,
      [@mel.optional] [@mel.as "aria-activedescendant"]
      ariaActivedescendant: string,
      [@mel.optional] [@mel.as "aria-atomic"]
      ariaAtomic: bool,
      [@mel.optional] [@mel.as "aria-busy"]
      ariaBusy: bool,
      [@mel.optional] [@mel.as "aria-colcount"]
      ariaColcount: int,
      [@mel.optional] [@mel.as "aria-colindex"]
      ariaColindex: int,
      [@mel.optional] [@mel.as "aria-colspan"]
      ariaColspan: int,
      [@mel.optional] [@mel.as "aria-controls"]
      ariaControls: string,
      [@mel.optional] [@mel.as "aria-describedby"]
      ariaDescribedby: string,
      [@mel.optional] [@mel.as "aria-details"]
      ariaDetails: string,
      [@mel.optional] [@mel.as "aria-disabled"]
      ariaDisabled: bool,
      [@mel.optional] [@mel.as "aria-errormessage"]
      ariaErrormessage: string,
      [@mel.optional] [@mel.as "aria-expanded"]
      ariaExpanded: bool,
      [@mel.optional] [@mel.as "aria-flowto"]
      ariaFlowto: string,
      [@mel.optional] [@mel.as "aria-grabbed"]
      ariaGrabbed: bool,
      [@mel.optional] [@mel.as "aria-hidden"]
      ariaHidden: bool,
      [@mel.optional] [@mel.as "aria-keyshortcuts"]
      ariaKeyshortcuts: string,
      [@mel.optional] [@mel.as "aria-label"]
      ariaLabel: string,
      [@mel.optional] [@mel.as "aria-labelledby"]
      ariaLabelledby: string,
      [@mel.optional] [@mel.as "aria-level"]
      ariaLevel: int,
      [@mel.optional] [@mel.as "aria-modal"]
      ariaModal: bool,
      [@mel.optional] [@mel.as "aria-multiline"]
      ariaMultiline: bool,
      [@mel.optional] [@mel.as "aria-multiselectable"]
      ariaMultiselectable: bool,
      [@mel.optional] [@mel.as "aria-owns"]
      ariaOwns: string,
      [@mel.optional] [@mel.as "aria-placeholder"]
      ariaPlaceholder: string,
      [@mel.optional] [@mel.as "aria-posinset"]
      ariaPosinset: int,
      [@mel.optional] [@mel.as "aria-readonly"]
      ariaReadonly: bool,
      [@mel.optional] [@mel.as "aria-relevant"]
      ariaRelevant: string,
      [@mel.optional] [@mel.as "aria-required"]
      ariaRequired: bool,
      [@mel.optional] [@mel.as "aria-roledescription"]
      ariaRoledescription: string,
      [@mel.optional] [@mel.as "aria-rowcount"]
      ariaRowcount: int,
      [@mel.optional] [@mel.as "aria-rowindex"]
      ariaRowindex: int,
      [@mel.optional] [@mel.as "aria-rowspan"]
      ariaRowspan: int,
      [@mel.optional] [@mel.as "aria-selected"]
      ariaSelected: bool,
      [@mel.optional] [@mel.as "aria-setsize"]
      ariaSetsize: int,
      [@mel.optional] [@mel.as "aria-sort"]
      ariaSort: string,
      [@mel.optional] [@mel.as "aria-valuemax"]
      ariaValuemax: float,
      [@mel.optional] [@mel.as "aria-valuemin"]
      ariaValuemin: float,
      [@mel.optional] [@mel.as "aria-valuenow"]
      ariaValuenow: float,
      [@mel.optional] [@mel.as "aria-valuetext"]
      ariaValuetext: string,
      [@mel.optional]
      ascent: string,
      [@mel.optional]
      async: bool,
      [@mel.optional]
      attributeName: string,
      [@mel.optional]
      attributeType: string,
      [@mel.optional]
      autoComplete: string,
      [@mel.optional]
      autoFocus: bool,
      [@mel.optional]
      autoPlay: bool,
      [@mel.optional]
      autoReverse: string,
      [@mel.optional]
      azimuth: string,
      [@mel.optional]
      baseFrequency: string,
      [@mel.optional]
      baselineShift: string,
      [@mel.optional]
      baseProfile: string,
      [@mel.optional]
      bbox: string,
      [@mel.optional]
      begin_: string,
      [@mel.optional]
      bias: string,
      [@mel.optional]
      by: string,
      [@mel.optional]
      calcMode: string,
      [@mel.optional]
      capHeight: string,
      [@mel.optional]
      challenge: string,
      [@mel.optional]
      charSet: string,
      [@mel.optional]
      checked: bool,
      [@mel.optional]
      cite: string,
      [@mel.optional]
      className: string,
      [@mel.optional]
      clip: string,
      [@mel.optional]
      clipPath: string,
      [@mel.optional]
      clipPathUnits: string,
      [@mel.optional]
      clipRule: string,
      [@mel.optional]
      colorInterpolation: string,
      [@mel.optional]
      colorInterpolationFilters: string,
      [@mel.optional]
      colorProfile: string,
      [@mel.optional]
      colorRendering: string,
      [@mel.optional]
      cols: int,
      [@mel.optional]
      colSpan: int,
      [@mel.optional]
      content: string,
      [@mel.optional]
      contentEditable: bool,
      [@mel.optional]
      contentScriptType: string,
      [@mel.optional]
      contentStyleType: string,
      [@mel.optional]
      contextMenu: string,
      [@mel.optional]
      controls: bool,
      [@mel.optional]
      coords: string,
      [@mel.optional]
      crossorigin: bool,
      [@mel.optional]
      cursor: string,
      [@mel.optional]
      cx: string,
      [@mel.optional]
      cy: string,
      [@mel.optional]
      d: string,
      [@mel.optional]
      data: string,
      [@mel.optional]
      datatype: string,
      [@mel.optional]
      dateTime: string,
      [@mel.optional]
      decelerate: string,
      [@mel.optional]
      default: bool,
      [@mel.optional]
      defaultChecked: bool,
      [@mel.optional]
      defaultValue: string,
      [@mel.optional]
      defer: bool,
      [@mel.optional]
      descent: string,
      [@mel.optional]
      diffuseConstant: string,
      [@mel.optional]
      dir: string,
      [@mel.optional]
      direction: string,
      [@mel.optional]
      disabled: bool,
      [@mel.optional]
      display: string,
      [@mel.optional]
      divisor: string,
      [@mel.optional]
      dominantBaseline: string,
      [@mel.optional]
      download: string,
      [@mel.optional]
      draggable: bool,
      [@mel.optional]
      dur: string,
      [@mel.optional]
      dx: string,
      [@mel.optional]
      dy: string,
      [@mel.optional]
      edgeMode: string,
      [@mel.optional]
      elevation: string,
      [@mel.optional]
      enableBackground: string,
      [@mel.optional]
      encType: string,
      [@mel.optional]
      end_: string,
      [@mel.optional]
      exponent: string,
      [@mel.optional]
      externalResourcesRequired: string,
      [@mel.optional]
      fill: string,
      [@mel.optional]
      fillOpacity: string,
      [@mel.optional]
      fillRule: string,
      [@mel.optional]
      filter: string,
      [@mel.optional]
      filterRes: string,
      [@mel.optional]
      filterUnits: string,
      [@mel.optional]
      floodColor: string,
      [@mel.optional]
      floodOpacity: string,
      [@mel.optional]
      focusable: string,
      [@mel.optional]
      fomat: string,
      [@mel.optional]
      fontFamily: string,
      [@mel.optional]
      fontSize: string,
      [@mel.optional]
      fontSizeAdjust: string,
      [@mel.optional]
      fontStretch: string,
      [@mel.optional]
      fontStyle: string,
      [@mel.optional]
      fontVariant: string,
      [@mel.optional]
      fontWeight: string,
      [@mel.optional]
      form: string,
      [@mel.optional]
      formAction: string,
      [@mel.optional]
      formMethod: string,
      [@mel.optional]
      formTarget: string,
      [@mel.optional]
      from: string,
      [@mel.optional]
      fx: string,
      [@mel.optional]
      fy: string,
      [@mel.optional]
      g1: string,
      [@mel.optional]
      g2: string,
      [@mel.optional]
      glyphName: string,
      [@mel.optional]
      glyphOrientationHorizontal: string,
      [@mel.optional]
      glyphOrientationVertical: string,
      [@mel.optional]
      glyphRef: string,
      [@mel.optional]
      gradientTransform: string,
      [@mel.optional]
      gradientUnits: string,
      [@mel.optional]
      hanging: string,
      [@mel.optional]
      headers: string,
      [@mel.optional]
      height: string,
      [@mel.optional]
      hidden: bool,
      [@mel.optional]
      high: int,
      [@mel.optional]
      horizAdvX: string,
      [@mel.optional]
      horizOriginX: string,
      [@mel.optional]
      href: string,
      [@mel.optional]
      hrefLang: string,
      [@mel.optional]
      htmlFor: string,
      [@mel.optional]
      httpEquiv: string,
      [@mel.optional]
      icon: string,
      [@mel.optional]
      id: string,
      [@mel.optional]
      ideographic: string,
      [@mel.optional]
      imageRendering: string,
      [@mel.optional]
      in_: string,
      [@mel.optional]
      in2: string,
      [@mel.optional]
      inlist: string,
      [@mel.optional]
      inputMode: string,
      [@mel.optional]
      integrity: string,
      [@mel.optional]
      intercept: string,
      [@mel.optional]
      itemID: string,
      [@mel.optional]
      itemProp: string,
      [@mel.optional]
      itemRef: string,
      [@mel.optional]
      itemScope: bool,
      [@mel.optional]
      itemType: string,
      [@mel.optional]
      k: string,
      [@mel.optional]
      k1: string,
      [@mel.optional]
      k2: string,
      [@mel.optional]
      k3: string,
      [@mel.optional]
      k4: string,
      [@mel.optional]
      kernelMatrix: string,
      [@mel.optional]
      kernelUnitLength: string,
      [@mel.optional]
      kerning: string,
      [@mel.optional]
      key: string,
      [@mel.optional]
      keyPoints: string,
      [@mel.optional]
      keySplines: string,
      [@mel.optional]
      keyTimes: string,
      [@mel.optional]
      keyType: string,
      [@mel.optional]
      kind: string,
      [@mel.optional]
      label: string,
      [@mel.optional]
      lang: string,
      [@mel.optional]
      lengthAdjust: string,
      [@mel.optional]
      letterSpacing: string,
      [@mel.optional]
      lightingColor: string,
      [@mel.optional]
      limitingConeAngle: string,
      [@mel.optional]
      list: string,
      [@mel.optional]
      local: string,
      [@mel.optional]
      loop: bool,
      [@mel.optional]
      low: int,
      [@mel.optional]
      manifest: string,
      [@mel.optional]
      markerEnd: string,
      [@mel.optional]
      markerHeight: string,
      [@mel.optional]
      markerMid: string,
      [@mel.optional]
      markerStart: string,
      [@mel.optional]
      markerUnits: string,
      [@mel.optional]
      markerWidth: string,
      [@mel.optional]
      mask: string,
      [@mel.optional]
      maskContentUnits: string,
      [@mel.optional]
      maskUnits: string,
      [@mel.optional]
      mathematical: string,
      [@mel.optional]
      max: string,
      [@mel.optional]
      maxLength: int,
      [@mel.optional]
      media: string,
      [@mel.optional]
      mediaGroup: string,
      [@mel.optional]
      min: int,
      [@mel.optional]
      minLength: int,
      [@mel.optional]
      mode: string,
      [@mel.optional]
      multiple: bool,
      [@mel.optional]
      muted: bool,
      [@mel.optional]
      name: string,
      [@mel.optional]
      nonce: string,
      [@mel.optional]
      noValidate: bool,
      [@mel.optional]
      numOctaves: string,
      [@mel.optional]
      offset: string,
      [@mel.optional]
      opacity: string,
      [@mel.optional]
      open_: bool,
      [@mel.optional]
      operator: string,
      [@mel.optional]
      optimum: int,
      [@mel.optional]
      order: string,
      [@mel.optional]
      orient: string,
      [@mel.optional]
      orientation: string,
      [@mel.optional]
      origin: string,
      [@mel.optional]
      overflow: string,
      [@mel.optional]
      overflowX: string,
      [@mel.optional]
      overflowY: string,
      [@mel.optional]
      overlinePosition: string,
      [@mel.optional]
      overlineThickness: string,
      [@mel.optional]
      paintOrder: string,
      [@mel.optional]
      panose1: string,
      [@mel.optional]
      pathLength: string,
      [@mel.optional]
      pattern: string,
      [@mel.optional]
      patternContentUnits: string,
      [@mel.optional]
      patternTransform: string,
      [@mel.optional]
      patternUnits: string,
      [@mel.optional]
      placeholder: string,
      [@mel.optional]
      pointerEvents: string,
      [@mel.optional]
      points: string,
      [@mel.optional]
      pointsAtX: string,
      [@mel.optional]
      pointsAtY: string,
      [@mel.optional]
      pointsAtZ: string,
      [@mel.optional]
      poster: string,
      [@mel.optional]
      prefix: string,
      [@mel.optional]
      preload: string,
      [@mel.optional]
      preserveAlpha: string,
      [@mel.optional]
      preserveAspectRatio: string,
      [@mel.optional]
      primitiveUnits: string,
      [@mel.optional]
      property: string,
      [@mel.optional]
      r: string,
      [@mel.optional]
      radioGroup: string,
      [@mel.optional]
      radius: string,
      [@mel.optional]
      readOnly: bool,
      [@mel.optional]
      refX: string,
      [@mel.optional]
      refY: string,
      [@mel.optional]
      rel: string,
      [@mel.optional]
      renderingIntent: string,
      [@mel.optional]
      repeatCount: string,
      [@mel.optional]
      repeatDur: string,
      [@mel.optional]
      required: bool,
      [@mel.optional]
      requiredExtensions: string,
      [@mel.optional]
      requiredFeatures: string,
      [@mel.optional]
      resource: string,
      [@mel.optional]
      restart: string,
      [@mel.optional]
      result: string,
      [@mel.optional]
      reversed: bool,
      [@mel.optional]
      role: string,
      [@mel.optional]
      rotate: string,
      [@mel.optional]
      rows: int,
      [@mel.optional]
      rowSpan: int,
      [@mel.optional]
      rx: string,
      [@mel.optional]
      ry: string,
      [@mel.optional]
      sandbox: string,
      [@mel.optional]
      scale: string,
      [@mel.optional]
      scope: string,
      [@mel.optional]
      scoped: bool,
      [@mel.optional]
      scrolling: string,
      [@mel.optional]
      seed: string,
      [@mel.optional]
      selected: bool,
      [@mel.optional]
      shape: string,
      [@mel.optional]
      shapeRendering: string,
      [@mel.optional]
      size: int,
      [@mel.optional]
      sizes: string,
      [@mel.optional]
      slope: string,
      [@mel.optional]
      spacing: string,
      [@mel.optional]
      span: int,
      [@mel.optional]
      specularConstant: string,
      [@mel.optional]
      specularExponent: string,
      [@mel.optional]
      speed: string,
      [@mel.optional]
      spellCheck: bool,
      [@mel.optional]
      spreadMethod: string,
      [@mel.optional]
      src: string,
      [@mel.optional]
      srcDoc: string,
      [@mel.optional]
      srcLang: string,
      [@mel.optional]
      srcSet: string,
      [@mel.optional]
      start: int,
      [@mel.optional]
      startOffset: string,
      [@mel.optional]
      stdDeviation: string,
      [@mel.optional]
      stemh: string,
      [@mel.optional]
      stemv: string,
      [@mel.optional]
      step: float,
      [@mel.optional]
      stitchTiles: string,
      [@mel.optional]
      stopColor: string,
      [@mel.optional]
      stopOpacity: string,
      [@mel.optional]
      strikethroughPosition: string,
      [@mel.optional]
      strikethroughThickness: string,
      [@mel.optional]
      stroke: string,
      [@mel.optional]
      strokeDasharray: string,
      [@mel.optional]
      strokeDashoffset: string,
      [@mel.optional]
      strokeLinecap: string,
      [@mel.optional]
      strokeLinejoin: string,
      [@mel.optional]
      strokeMiterlimit: string,
      [@mel.optional]
      strokeOpacity: string,
      [@mel.optional]
      strokeWidth: string,
      [@mel.optional]
      style: ReactDOM.Style.t,
      [@mel.optional]
      summary: string,
      [@mel.optional]
      suppressContentEditableWarning: bool,
      [@mel.optional]
      surfaceScale: string,
      [@mel.optional]
      systemLanguage: string,
      [@mel.optional]
      tabIndex: int,
      [@mel.optional]
      tableValues: string,
      [@mel.optional]
      target: string,
      [@mel.optional]
      targetX: string,
      [@mel.optional]
      targetY: string,
      [@mel.optional]
      textAnchor: string,
      [@mel.optional]
      textDecoration: string,
      [@mel.optional]
      textLength: string,
      [@mel.optional]
      textRendering: string,
      [@mel.optional]
      title: string,
      [@mel.optional]
      to_: string,
      [@mel.optional]
      transform: string,
      [@mel.optional] [@mel.as "type"]
      type_: string,
      [@mel.optional]
      typeof: string,
      [@mel.optional]
      u1: string,
      [@mel.optional]
      u2: string,
      [@mel.optional]
      underlinePosition: string,
      [@mel.optional]
      underlineThickness: string,
      [@mel.optional]
      unicode: string,
      [@mel.optional]
      unicodeBidi: string,
      [@mel.optional]
      unicodeRange: string,
      [@mel.optional]
      unitsPerEm: string,
      [@mel.optional]
      useMap: string,
      [@mel.optional]
      vAlphabetic: string,
      [@mel.optional]
      value: string,
      [@mel.optional]
      values: string,
      [@mel.optional]
      vectorEffect: string,
      [@mel.optional]
      version: string,
      [@mel.optional]
      vertAdvX: string,
      [@mel.optional]
      vertAdvY: string,
      [@mel.optional]
      vertOriginX: string,
      [@mel.optional]
      vertOriginY: string,
      [@mel.optional]
      vHanging: string,
      [@mel.optional]
      vIdeographic: string,
      [@mel.optional]
      viewBox: string,
      [@mel.optional]
      viewTarget: string,
      [@mel.optional]
      visibility: string,
      [@mel.optional]
      vMathematical: string,
      [@mel.optional]
      vocab: string,
      [@mel.optional]
      width: string,
      [@mel.optional]
      widths: string,
      [@mel.optional]
      wordSpacing: string,
      [@mel.optional]
      wrap: string,
      [@mel.optional]
      writingMode: string,
      [@mel.optional]
      x: string,
      [@mel.optional]
      x1: string,
      [@mel.optional]
      x2: string,
      [@mel.optional]
      xChannelSelector: string,
      [@mel.optional]
      xHeight: string,
      [@mel.optional]
      xlinkActuate: string,
      [@mel.optional]
      xlinkArcrole: string,
      [@mel.optional]
      xlinkHref: string,
      [@mel.optional]
      xlinkRole: string,
      [@mel.optional]
      xlinkShow: string,
      [@mel.optional]
      xlinkTitle: string,
      [@mel.optional]
      xlinkType: string,
      [@mel.optional]
      xmlBase: string,
      [@mel.optional]
      xmlLang: string,
      [@mel.optional]
      xmlns: string,
      [@mel.optional]
      xmlnsXlink: string,
      [@mel.optional]
      xmlSpace: string,
      [@mel.optional]
      y: string,
      [@mel.optional]
      y1: string,
      [@mel.optional]
      y2: string,
      [@mel.optional]
      yChannelSelector: string,
      [@mel.optional]
      z: string,
      [@mel.optional]
      zoomAndPan: string,
      [@mel.optional]
      onAbort: ReactEvent.Media.t => unit,
      [@mel.optional]
      onAnimationEnd: ReactEvent.Animation.t => unit,
      [@mel.optional]
      onAnimationIteration: ReactEvent.Animation.t => unit,
      [@mel.optional]
      onAnimationStart: ReactEvent.Animation.t => unit,
      [@mel.optional]
      onBlur: ReactEvent.Focus.t => unit,
      [@mel.optional]
      onCanPlay: ReactEvent.Media.t => unit,
      [@mel.optional]
      onCanPlayThrough: ReactEvent.Media.t => unit,
      [@mel.optional]
      onChange: ReactEvent.Form.t => unit,
      [@mel.optional]
      onClick: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onCompositionEnd: ReactEvent.Composition.t => unit,
      [@mel.optional]
      onCompositionStart: ReactEvent.Composition.t => unit,
      [@mel.optional]
      onCompositionUpdate: ReactEvent.Composition.t => unit,
      [@mel.optional]
      onContextMenu: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onCopy: ReactEvent.Clipboard.t => unit,
      [@mel.optional]
      onCut: ReactEvent.Clipboard.t => unit,
      [@mel.optional]
      onDoubleClick: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onDrag: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onDragEnd: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onDragEnter: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onDragExit: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onDragLeave: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onDragOver: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onDragStart: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onDrop: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onDurationChange: ReactEvent.Media.t => unit,
      [@mel.optional]
      onEmptied: ReactEvent.Media.t => unit,
      [@mel.optional]
      onEncrypetd: ReactEvent.Media.t => unit,
      [@mel.optional]
      onEnded: ReactEvent.Media.t => unit,
      [@mel.optional]
      onError: ReactEvent.Media.t => unit,
      [@mel.optional]
      onFocus: ReactEvent.Focus.t => unit,
      [@mel.optional]
      onInput: ReactEvent.Form.t => unit,
      [@mel.optional]
      onKeyDown: ReactEvent.Keyboard.t => unit,
      [@mel.optional]
      onKeyPress: ReactEvent.Keyboard.t => unit,
      [@mel.optional]
      onKeyUp: ReactEvent.Keyboard.t => unit,
      [@mel.optional]
      onLoadedData: ReactEvent.Media.t => unit,
      [@mel.optional]
      onLoadedMetadata: ReactEvent.Media.t => unit,
      [@mel.optional]
      onLoadStart: ReactEvent.Media.t => unit,
      [@mel.optional]
      onMouseDown: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onMouseEnter: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onMouseLeave: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onMouseMove: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onMouseOut: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onMouseOver: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onMouseUp: ReactEvent.Mouse.t => unit,
      [@mel.optional]
      onPaste: ReactEvent.Clipboard.t => unit,
      [@mel.optional]
      onPause: ReactEvent.Media.t => unit,
      [@mel.optional]
      onPlay: ReactEvent.Media.t => unit,
      [@mel.optional]
      onPlaying: ReactEvent.Media.t => unit,
      [@mel.optional]
      onProgress: ReactEvent.Media.t => unit,
      [@mel.optional]
      onRateChange: ReactEvent.Media.t => unit,
      [@mel.optional]
      onScroll: ReactEvent.UI.t => unit,
      [@mel.optional]
      onSeeked: ReactEvent.Media.t => unit,
      [@mel.optional]
      onSeeking: ReactEvent.Media.t => unit,
      [@mel.optional]
      onSelect: ReactEvent.Selection.t => unit,
      [@mel.optional]
      onStalled: ReactEvent.Media.t => unit,
      [@mel.optional]
      onSubmit: ReactEvent.Form.t => unit,
      [@mel.optional]
      onSuspend: ReactEvent.Media.t => unit,
      [@mel.optional]
      onTimeUpdate: ReactEvent.Media.t => unit,
      [@mel.optional]
      onTouchCancel: ReactEvent.Touch.t => unit,
      [@mel.optional]
      onTouchEnd: ReactEvent.Touch.t => unit,
      [@mel.optional]
      onTouchMove: ReactEvent.Touch.t => unit,
      [@mel.optional]
      onTouchStart: ReactEvent.Touch.t => unit,
      [@mel.optional]
      onTransitionEnd: ReactEvent.Transition.t => unit,
      [@mel.optional]
      onVolumeChange: ReactEvent.Media.t => unit,
      [@mel.optional]
      onWaiting: ReactEvent.Media.t => unit,
      [@mel.optional]
      onWheel: ReactEvent.Wheel.t => unit,
    };
    [@mel.module "react"]
    external createVariadicElement: (string, Js.t({..})) => React.element =
      "createElement";
    let getOrEmpty = str =>
      switch (str) {
      | Some(str) => " " ++ str
      | None => ""
      };
    let deleteProp = [%raw "(newProps, key) => delete newProps[key]"];
    external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
      "Object.assign";
    let styles =
      CssJs.style([|
        CssJs.label("OneSingleProperty"),
        CssJs.display(`block),
      |]);
    let make = (props: makeProps) => {
      let className = styles ++ getOrEmpty(classNameGet(props));
      let stylesObject = {"className": className, "ref": innerRefGet(props)};
      let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
      ignore(deleteProp(. newProps, "innerRef"));
      createVariadicElement("div", newProps);
    };
  };
