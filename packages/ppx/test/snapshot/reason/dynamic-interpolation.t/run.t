  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module DynamicComponent = {
    [@res.optional]
    type props('var) = {
      [@res.optional]
      ref: ReactDOM.domRef,
      [@res.optional]
      children: React.element,
      [@res.optional]
      about: string,
      [@res.optional]
      accentHeight: string,
      [@res.optional]
      accept: string,
      [@res.optional]
      acceptCharset: string,
      [@res.optional]
      accessKey: string,
      [@res.optional]
      accumulate: string,
      [@res.optional]
      action: string,
      [@res.optional]
      additive: string,
      [@res.optional]
      alignmentBaseline: string,
      [@res.optional]
      allowFullScreen: bool,
      [@res.optional]
      allowReorder: string,
      [@res.optional]
      alphabetic: string,
      [@res.optional]
      alt: string,
      [@res.optional]
      amplitude: string,
      [@res.optional]
      arabicForm: string,
      [@res.optional] [@bs.as "aria-activedescendant"]
      ariaActivedescendant: string,
      [@res.optional] [@bs.as "aria-atomic"]
      ariaAtomic: bool,
      [@res.optional] [@bs.as "aria-busy"]
      ariaBusy: bool,
      [@res.optional] [@bs.as "aria-colcount"]
      ariaColcount: int,
      [@res.optional] [@bs.as "aria-colindex"]
      ariaColindex: int,
      [@res.optional] [@bs.as "aria-colspan"]
      ariaColspan: int,
      [@res.optional] [@bs.as "aria-controls"]
      ariaControls: string,
      [@res.optional] [@bs.as "aria-describedby"]
      ariaDescribedby: string,
      [@res.optional] [@bs.as "aria-details"]
      ariaDetails: string,
      [@res.optional] [@bs.as "aria-disabled"]
      ariaDisabled: bool,
      [@res.optional] [@bs.as "aria-errormessage"]
      ariaErrormessage: string,
      [@res.optional] [@bs.as "aria-expanded"]
      ariaExpanded: bool,
      [@res.optional] [@bs.as "aria-flowto"]
      ariaFlowto: string,
      [@res.optional] [@bs.as "aria-grabbed"]
      ariaGrabbed: bool,
      [@res.optional] [@bs.as "aria-hidden"]
      ariaHidden: bool,
      [@res.optional] [@bs.as "aria-keyshortcuts"]
      ariaKeyshortcuts: string,
      [@res.optional] [@bs.as "aria-label"]
      ariaLabel: string,
      [@res.optional] [@bs.as "aria-labelledby"]
      ariaLabelledby: string,
      [@res.optional] [@bs.as "aria-level"]
      ariaLevel: int,
      [@res.optional] [@bs.as "aria-modal"]
      ariaModal: bool,
      [@res.optional] [@bs.as "aria-multiline"]
      ariaMultiline: bool,
      [@res.optional] [@bs.as "aria-multiselectable"]
      ariaMultiselectable: bool,
      [@res.optional] [@bs.as "aria-owns"]
      ariaOwns: string,
      [@res.optional] [@bs.as "aria-placeholder"]
      ariaPlaceholder: string,
      [@res.optional] [@bs.as "aria-posinset"]
      ariaPosinset: int,
      [@res.optional] [@bs.as "aria-readonly"]
      ariaReadonly: bool,
      [@res.optional] [@bs.as "aria-relevant"]
      ariaRelevant: string,
      [@res.optional] [@bs.as "aria-required"]
      ariaRequired: bool,
      [@res.optional] [@bs.as "aria-roledescription"]
      ariaRoledescription: string,
      [@res.optional] [@bs.as "aria-rowcount"]
      ariaRowcount: int,
      [@res.optional] [@bs.as "aria-rowindex"]
      ariaRowindex: int,
      [@res.optional] [@bs.as "aria-rowspan"]
      ariaRowspan: int,
      [@res.optional] [@bs.as "aria-selected"]
      ariaSelected: bool,
      [@res.optional] [@bs.as "aria-setsize"]
      ariaSetsize: int,
      [@res.optional] [@bs.as "aria-sort"]
      ariaSort: string,
      [@res.optional] [@bs.as "aria-valuemax"]
      ariaValuemax: float,
      [@res.optional] [@bs.as "aria-valuemin"]
      ariaValuemin: float,
      [@res.optional] [@bs.as "aria-valuenow"]
      ariaValuenow: float,
      [@res.optional] [@bs.as "aria-valuetext"]
      ariaValuetext: string,
      [@res.optional]
      ascent: string,
      [@res.optional]
      async: bool,
      [@res.optional]
      attributeName: string,
      [@res.optional]
      attributeType: string,
      [@res.optional]
      autoComplete: string,
      [@res.optional]
      autoFocus: bool,
      [@res.optional]
      autoPlay: bool,
      [@res.optional]
      autoReverse: string,
      [@res.optional]
      azimuth: string,
      [@res.optional]
      baseFrequency: string,
      [@res.optional]
      baselineShift: string,
      [@res.optional]
      baseProfile: string,
      [@res.optional]
      bbox: string,
      [@res.optional]
      begin_: string,
      [@res.optional]
      bias: string,
      [@res.optional]
      by: string,
      [@res.optional]
      calcMode: string,
      [@res.optional]
      capHeight: string,
      [@res.optional]
      challenge: string,
      [@res.optional]
      charSet: string,
      [@res.optional]
      checked: bool,
      [@res.optional]
      cite: string,
      [@res.optional]
      className: string,
      [@res.optional]
      clip: string,
      [@res.optional]
      clipPath: string,
      [@res.optional]
      clipPathUnits: string,
      [@res.optional]
      clipRule: string,
      [@res.optional]
      colorInterpolation: string,
      [@res.optional]
      colorInterpolationFilters: string,
      [@res.optional]
      colorProfile: string,
      [@res.optional]
      colorRendering: string,
      [@res.optional]
      cols: int,
      [@res.optional]
      colSpan: int,
      [@res.optional]
      content: string,
      [@res.optional]
      contentEditable: bool,
      [@res.optional]
      contentScriptType: string,
      [@res.optional]
      contentStyleType: string,
      [@res.optional]
      contextMenu: string,
      [@res.optional]
      controls: bool,
      [@res.optional]
      coords: string,
      [@res.optional]
      crossorigin: bool,
      [@res.optional]
      cursor: string,
      [@res.optional]
      cx: string,
      [@res.optional]
      cy: string,
      [@res.optional]
      d: string,
      [@res.optional]
      data: string,
      [@res.optional]
      datatype: string,
      [@res.optional]
      dateTime: string,
      [@res.optional]
      decelerate: string,
      [@res.optional]
      default: bool,
      [@res.optional]
      defaultChecked: bool,
      [@res.optional]
      defaultValue: string,
      [@res.optional]
      defer: bool,
      [@res.optional]
      descent: string,
      [@res.optional]
      diffuseConstant: string,
      [@res.optional]
      dir: string,
      [@res.optional]
      direction: string,
      [@res.optional]
      disabled: bool,
      [@res.optional]
      display: string,
      [@res.optional]
      divisor: string,
      [@res.optional]
      dominantBaseline: string,
      [@res.optional]
      download: string,
      [@res.optional]
      draggable: bool,
      [@res.optional]
      dur: string,
      [@res.optional]
      dx: string,
      [@res.optional]
      dy: string,
      [@res.optional]
      edgeMode: string,
      [@res.optional]
      elevation: string,
      [@res.optional]
      enableBackground: string,
      [@res.optional]
      encType: string,
      [@res.optional]
      end_: string,
      [@res.optional]
      exponent: string,
      [@res.optional]
      externalResourcesRequired: string,
      [@res.optional]
      fill: string,
      [@res.optional]
      fillOpacity: string,
      [@res.optional]
      fillRule: string,
      [@res.optional]
      filter: string,
      [@res.optional]
      filterRes: string,
      [@res.optional]
      filterUnits: string,
      [@res.optional]
      floodColor: string,
      [@res.optional]
      floodOpacity: string,
      [@res.optional]
      focusable: string,
      [@res.optional]
      fomat: string,
      [@res.optional]
      fontFamily: string,
      [@res.optional]
      fontSize: string,
      [@res.optional]
      fontSizeAdjust: string,
      [@res.optional]
      fontStretch: string,
      [@res.optional]
      fontStyle: string,
      [@res.optional]
      fontVariant: string,
      [@res.optional]
      fontWeight: string,
      [@res.optional]
      form: string,
      [@res.optional]
      formAction: string,
      [@res.optional]
      formMethod: string,
      [@res.optional]
      formTarget: string,
      [@res.optional]
      from: string,
      [@res.optional]
      fx: string,
      [@res.optional]
      fy: string,
      [@res.optional]
      g1: string,
      [@res.optional]
      g2: string,
      [@res.optional]
      glyphName: string,
      [@res.optional]
      glyphOrientationHorizontal: string,
      [@res.optional]
      glyphOrientationVertical: string,
      [@res.optional]
      glyphRef: string,
      [@res.optional]
      gradientTransform: string,
      [@res.optional]
      gradientUnits: string,
      [@res.optional]
      hanging: string,
      [@res.optional]
      headers: string,
      [@res.optional]
      height: string,
      [@res.optional]
      hidden: bool,
      [@res.optional]
      high: int,
      [@res.optional]
      horizAdvX: string,
      [@res.optional]
      horizOriginX: string,
      [@res.optional]
      href: string,
      [@res.optional]
      hrefLang: string,
      [@res.optional]
      htmlFor: string,
      [@res.optional]
      httpEquiv: string,
      [@res.optional]
      icon: string,
      [@res.optional]
      id: string,
      [@res.optional]
      ideographic: string,
      [@res.optional]
      imageRendering: string,
      [@res.optional]
      in_: string,
      [@res.optional]
      in2: string,
      [@res.optional]
      inlist: string,
      [@res.optional]
      inputMode: string,
      [@res.optional]
      integrity: string,
      [@res.optional]
      intercept: string,
      [@res.optional]
      itemID: string,
      [@res.optional]
      itemProp: string,
      [@res.optional]
      itemRef: string,
      [@res.optional]
      itemScope: bool,
      [@res.optional]
      itemType: string,
      [@res.optional]
      k: string,
      [@res.optional]
      k1: string,
      [@res.optional]
      k2: string,
      [@res.optional]
      k3: string,
      [@res.optional]
      k4: string,
      [@res.optional]
      kernelMatrix: string,
      [@res.optional]
      kernelUnitLength: string,
      [@res.optional]
      kerning: string,
      [@res.optional]
      key: string,
      [@res.optional]
      keyPoints: string,
      [@res.optional]
      keySplines: string,
      [@res.optional]
      keyTimes: string,
      [@res.optional]
      keyType: string,
      [@res.optional]
      kind: string,
      [@res.optional]
      label: string,
      [@res.optional]
      lang: string,
      [@res.optional]
      lengthAdjust: string,
      [@res.optional]
      letterSpacing: string,
      [@res.optional]
      lightingColor: string,
      [@res.optional]
      limitingConeAngle: string,
      [@res.optional]
      list: string,
      [@res.optional]
      local: string,
      [@res.optional]
      loop: bool,
      [@res.optional]
      low: int,
      [@res.optional]
      manifest: string,
      [@res.optional]
      markerEnd: string,
      [@res.optional]
      markerHeight: string,
      [@res.optional]
      markerMid: string,
      [@res.optional]
      markerStart: string,
      [@res.optional]
      markerUnits: string,
      [@res.optional]
      markerWidth: string,
      [@res.optional]
      mask: string,
      [@res.optional]
      maskContentUnits: string,
      [@res.optional]
      maskUnits: string,
      [@res.optional]
      mathematical: string,
      [@res.optional]
      max: string,
      [@res.optional]
      maxLength: int,
      [@res.optional]
      media: string,
      [@res.optional]
      mediaGroup: string,
      [@res.optional]
      min: int,
      [@res.optional]
      minLength: int,
      [@res.optional]
      mode: string,
      [@res.optional]
      multiple: bool,
      [@res.optional]
      muted: bool,
      [@res.optional]
      name: string,
      [@res.optional]
      nonce: string,
      [@res.optional]
      noValidate: bool,
      [@res.optional]
      numOctaves: string,
      [@res.optional]
      offset: string,
      [@res.optional]
      opacity: string,
      [@res.optional]
      open_: bool,
      [@res.optional]
      operator: string,
      [@res.optional]
      optimum: int,
      [@res.optional]
      order: string,
      [@res.optional]
      orient: string,
      [@res.optional]
      orientation: string,
      [@res.optional]
      origin: string,
      [@res.optional]
      overflow: string,
      [@res.optional]
      overflowX: string,
      [@res.optional]
      overflowY: string,
      [@res.optional]
      overlinePosition: string,
      [@res.optional]
      overlineThickness: string,
      [@res.optional]
      paintOrder: string,
      [@res.optional]
      panose1: string,
      [@res.optional]
      pathLength: string,
      [@res.optional]
      pattern: string,
      [@res.optional]
      patternContentUnits: string,
      [@res.optional]
      patternTransform: string,
      [@res.optional]
      patternUnits: string,
      [@res.optional]
      placeholder: string,
      [@res.optional]
      pointerEvents: string,
      [@res.optional]
      points: string,
      [@res.optional]
      pointsAtX: string,
      [@res.optional]
      pointsAtY: string,
      [@res.optional]
      pointsAtZ: string,
      [@res.optional]
      poster: string,
      [@res.optional]
      prefix: string,
      [@res.optional]
      preload: string,
      [@res.optional]
      preserveAlpha: string,
      [@res.optional]
      preserveAspectRatio: string,
      [@res.optional]
      primitiveUnits: string,
      [@res.optional]
      property: string,
      [@res.optional]
      r: string,
      [@res.optional]
      radioGroup: string,
      [@res.optional]
      radius: string,
      [@res.optional]
      readOnly: bool,
      [@res.optional]
      refX: string,
      [@res.optional]
      refY: string,
      [@res.optional]
      rel: string,
      [@res.optional]
      renderingIntent: string,
      [@res.optional]
      repeatCount: string,
      [@res.optional]
      repeatDur: string,
      [@res.optional]
      required: bool,
      [@res.optional]
      requiredExtensions: string,
      [@res.optional]
      requiredFeatures: string,
      [@res.optional]
      resource: string,
      [@res.optional]
      restart: string,
      [@res.optional]
      result: string,
      [@res.optional]
      reversed: bool,
      [@res.optional]
      role: string,
      [@res.optional]
      rotate: string,
      [@res.optional]
      rows: int,
      [@res.optional]
      rowSpan: int,
      [@res.optional]
      rx: string,
      [@res.optional]
      ry: string,
      [@res.optional]
      sandbox: string,
      [@res.optional]
      scale: string,
      [@res.optional]
      scope: string,
      [@res.optional]
      scoped: bool,
      [@res.optional]
      scrolling: string,
      [@res.optional]
      seed: string,
      [@res.optional]
      selected: bool,
      [@res.optional]
      shape: string,
      [@res.optional]
      shapeRendering: string,
      [@res.optional]
      size: int,
      [@res.optional]
      sizes: string,
      [@res.optional]
      slope: string,
      [@res.optional]
      spacing: string,
      [@res.optional]
      span: int,
      [@res.optional]
      specularConstant: string,
      [@res.optional]
      specularExponent: string,
      [@res.optional]
      speed: string,
      [@res.optional]
      spellCheck: bool,
      [@res.optional]
      spreadMethod: string,
      [@res.optional]
      src: string,
      [@res.optional]
      srcDoc: string,
      [@res.optional]
      srcLang: string,
      [@res.optional]
      srcSet: string,
      [@res.optional]
      start: int,
      [@res.optional]
      startOffset: string,
      [@res.optional]
      stdDeviation: string,
      [@res.optional]
      stemh: string,
      [@res.optional]
      stemv: string,
      [@res.optional]
      step: float,
      [@res.optional]
      stitchTiles: string,
      [@res.optional]
      stopColor: string,
      [@res.optional]
      stopOpacity: string,
      [@res.optional]
      strikethroughPosition: string,
      [@res.optional]
      strikethroughThickness: string,
      [@res.optional]
      stroke: string,
      [@res.optional]
      strokeDasharray: string,
      [@res.optional]
      strokeDashoffset: string,
      [@res.optional]
      strokeLinecap: string,
      [@res.optional]
      strokeLinejoin: string,
      [@res.optional]
      strokeMiterlimit: string,
      [@res.optional]
      strokeOpacity: string,
      [@res.optional]
      strokeWidth: string,
      [@res.optional]
      style: ReactDOM.Style.t,
      [@res.optional]
      summary: string,
      [@res.optional]
      suppressContentEditableWarning: bool,
      [@res.optional]
      surfaceScale: string,
      [@res.optional]
      systemLanguage: string,
      [@res.optional]
      tabIndex: int,
      [@res.optional]
      tableValues: string,
      [@res.optional]
      target: string,
      [@res.optional]
      targetX: string,
      [@res.optional]
      targetY: string,
      [@res.optional]
      textAnchor: string,
      [@res.optional]
      textDecoration: string,
      [@res.optional]
      textLength: string,
      [@res.optional]
      textRendering: string,
      [@res.optional]
      title: string,
      [@res.optional]
      to_: string,
      [@res.optional]
      transform: string,
      [@res.optional] [@bs.as "type"]
      type_: string,
      [@res.optional]
      typeof: string,
      [@res.optional]
      u1: string,
      [@res.optional]
      u2: string,
      [@res.optional]
      underlinePosition: string,
      [@res.optional]
      underlineThickness: string,
      [@res.optional]
      unicode: string,
      [@res.optional]
      unicodeBidi: string,
      [@res.optional]
      unicodeRange: string,
      [@res.optional]
      unitsPerEm: string,
      [@res.optional]
      useMap: string,
      [@res.optional]
      vAlphabetic: string,
      [@res.optional]
      value: string,
      [@res.optional]
      values: string,
      [@res.optional]
      vectorEffect: string,
      [@res.optional]
      version: string,
      [@res.optional]
      vertAdvX: string,
      [@res.optional]
      vertAdvY: string,
      [@res.optional]
      vertOriginX: string,
      [@res.optional]
      vertOriginY: string,
      [@res.optional]
      vHanging: string,
      [@res.optional]
      vIdeographic: string,
      [@res.optional]
      viewBox: string,
      [@res.optional]
      viewTarget: string,
      [@res.optional]
      visibility: string,
      [@res.optional]
      vMathematical: string,
      [@res.optional]
      vocab: string,
      [@res.optional]
      width: string,
      [@res.optional]
      widths: string,
      [@res.optional]
      wordSpacing: string,
      [@res.optional]
      wrap: string,
      [@res.optional]
      writingMode: string,
      [@res.optional]
      x: string,
      [@res.optional]
      x1: string,
      [@res.optional]
      x2: string,
      [@res.optional]
      xChannelSelector: string,
      [@res.optional]
      xHeight: string,
      [@res.optional]
      xlinkActuate: string,
      [@res.optional]
      xlinkArcrole: string,
      [@res.optional]
      xlinkHref: string,
      [@res.optional]
      xlinkRole: string,
      [@res.optional]
      xlinkShow: string,
      [@res.optional]
      xlinkTitle: string,
      [@res.optional]
      xlinkType: string,
      [@res.optional]
      xmlBase: string,
      [@res.optional]
      xmlLang: string,
      [@res.optional]
      xmlns: string,
      [@res.optional]
      xmlnsXlink: string,
      [@res.optional]
      xmlSpace: string,
      [@res.optional]
      y: string,
      [@res.optional]
      y1: string,
      [@res.optional]
      y2: string,
      [@res.optional]
      yChannelSelector: string,
      [@res.optional]
      z: string,
      [@res.optional]
      zoomAndPan: string,
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
