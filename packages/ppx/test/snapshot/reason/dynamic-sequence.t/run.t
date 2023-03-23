  $ refmt --parse re --print ml input.re > output.ml
  $ standalone --impl output.ml -o output.ml
  $ refmt --parse ml --print re output.ml
  module SequenceDynamicComponent = {
    [@ns.optional]
    type props('size) = {
      [@ns.optional]
      ref: ReactDOM.domRef,
      [@ns.optional]
      children: React.element,
      [@ns.optional]
      about: string,
      [@ns.optional]
      accentHeight: string,
      [@ns.optional]
      accept: string,
      [@ns.optional]
      acceptCharset: string,
      [@ns.optional]
      accessKey: string,
      [@ns.optional]
      accumulate: string,
      [@ns.optional]
      action: string,
      [@ns.optional]
      additive: string,
      [@ns.optional]
      alignmentBaseline: string,
      [@ns.optional]
      allowFullScreen: bool,
      [@ns.optional]
      allowReorder: string,
      [@ns.optional]
      alphabetic: string,
      [@ns.optional]
      alt: string,
      [@ns.optional]
      amplitude: string,
      [@ns.optional]
      arabicForm: string,
      [@ns.optional] [@bs.as "aria-activedescendant"]
      ariaActivedescendant: string,
      [@ns.optional] [@bs.as "aria-atomic"]
      ariaAtomic: bool,
      [@ns.optional] [@bs.as "aria-busy"]
      ariaBusy: bool,
      [@ns.optional] [@bs.as "aria-colcount"]
      ariaColcount: int,
      [@ns.optional] [@bs.as "aria-colindex"]
      ariaColindex: int,
      [@ns.optional] [@bs.as "aria-colspan"]
      ariaColspan: int,
      [@ns.optional] [@bs.as "aria-controls"]
      ariaControls: string,
      [@ns.optional] [@bs.as "aria-describedby"]
      ariaDescribedby: string,
      [@ns.optional] [@bs.as "aria-details"]
      ariaDetails: string,
      [@ns.optional] [@bs.as "aria-disabled"]
      ariaDisabled: bool,
      [@ns.optional] [@bs.as "aria-errormessage"]
      ariaErrormessage: string,
      [@ns.optional] [@bs.as "aria-expanded"]
      ariaExpanded: bool,
      [@ns.optional] [@bs.as "aria-flowto"]
      ariaFlowto: string,
      [@ns.optional] [@bs.as "aria-grabbed"]
      ariaGrabbed: bool,
      [@ns.optional] [@bs.as "aria-hidden"]
      ariaHidden: bool,
      [@ns.optional] [@bs.as "aria-keyshortcuts"]
      ariaKeyshortcuts: string,
      [@ns.optional] [@bs.as "aria-label"]
      ariaLabel: string,
      [@ns.optional] [@bs.as "aria-labelledby"]
      ariaLabelledby: string,
      [@ns.optional] [@bs.as "aria-level"]
      ariaLevel: int,
      [@ns.optional] [@bs.as "aria-modal"]
      ariaModal: bool,
      [@ns.optional] [@bs.as "aria-multiline"]
      ariaMultiline: bool,
      [@ns.optional] [@bs.as "aria-multiselectable"]
      ariaMultiselectable: bool,
      [@ns.optional] [@bs.as "aria-owns"]
      ariaOwns: string,
      [@ns.optional] [@bs.as "aria-placeholder"]
      ariaPlaceholder: string,
      [@ns.optional] [@bs.as "aria-posinset"]
      ariaPosinset: int,
      [@ns.optional] [@bs.as "aria-readonly"]
      ariaReadonly: bool,
      [@ns.optional] [@bs.as "aria-relevant"]
      ariaRelevant: string,
      [@ns.optional] [@bs.as "aria-required"]
      ariaRequired: bool,
      [@ns.optional] [@bs.as "aria-roledescription"]
      ariaRoledescription: string,
      [@ns.optional] [@bs.as "aria-rowcount"]
      ariaRowcount: int,
      [@ns.optional] [@bs.as "aria-rowindex"]
      ariaRowindex: int,
      [@ns.optional] [@bs.as "aria-rowspan"]
      ariaRowspan: int,
      [@ns.optional] [@bs.as "aria-selected"]
      ariaSelected: bool,
      [@ns.optional] [@bs.as "aria-setsize"]
      ariaSetsize: int,
      [@ns.optional] [@bs.as "aria-sort"]
      ariaSort: string,
      [@ns.optional] [@bs.as "aria-valuemax"]
      ariaValuemax: float,
      [@ns.optional] [@bs.as "aria-valuemin"]
      ariaValuemin: float,
      [@ns.optional] [@bs.as "aria-valuenow"]
      ariaValuenow: float,
      [@ns.optional] [@bs.as "aria-valuetext"]
      ariaValuetext: string,
      [@ns.optional]
      ascent: string,
      [@ns.optional]
      async: bool,
      [@ns.optional]
      attributeName: string,
      [@ns.optional]
      attributeType: string,
      [@ns.optional]
      autoComplete: string,
      [@ns.optional]
      autoFocus: bool,
      [@ns.optional]
      autoPlay: bool,
      [@ns.optional]
      autoReverse: string,
      [@ns.optional]
      azimuth: string,
      [@ns.optional]
      baseFrequency: string,
      [@ns.optional]
      baselineShift: string,
      [@ns.optional]
      baseProfile: string,
      [@ns.optional]
      bbox: string,
      [@ns.optional]
      begin_: string,
      [@ns.optional]
      bias: string,
      [@ns.optional]
      by: string,
      [@ns.optional]
      calcMode: string,
      [@ns.optional]
      capHeight: string,
      [@ns.optional]
      challenge: string,
      [@ns.optional]
      charSet: string,
      [@ns.optional]
      checked: bool,
      [@ns.optional]
      cite: string,
      [@ns.optional]
      className: string,
      [@ns.optional]
      clip: string,
      [@ns.optional]
      clipPath: string,
      [@ns.optional]
      clipPathUnits: string,
      [@ns.optional]
      clipRule: string,
      [@ns.optional]
      colorInterpolation: string,
      [@ns.optional]
      colorInterpolationFilters: string,
      [@ns.optional]
      colorProfile: string,
      [@ns.optional]
      colorRendering: string,
      [@ns.optional]
      cols: int,
      [@ns.optional]
      colSpan: int,
      [@ns.optional]
      content: string,
      [@ns.optional]
      contentEditable: bool,
      [@ns.optional]
      contentScriptType: string,
      [@ns.optional]
      contentStyleType: string,
      [@ns.optional]
      contextMenu: string,
      [@ns.optional]
      controls: bool,
      [@ns.optional]
      coords: string,
      [@ns.optional]
      crossorigin: bool,
      [@ns.optional]
      cursor: string,
      [@ns.optional]
      cx: string,
      [@ns.optional]
      cy: string,
      [@ns.optional]
      d: string,
      [@ns.optional]
      data: string,
      [@ns.optional]
      datatype: string,
      [@ns.optional]
      dateTime: string,
      [@ns.optional]
      decelerate: string,
      [@ns.optional]
      default: bool,
      [@ns.optional]
      defaultChecked: bool,
      [@ns.optional]
      defaultValue: string,
      [@ns.optional]
      defer: bool,
      [@ns.optional]
      descent: string,
      [@ns.optional]
      diffuseConstant: string,
      [@ns.optional]
      dir: string,
      [@ns.optional]
      direction: string,
      [@ns.optional]
      disabled: bool,
      [@ns.optional]
      display: string,
      [@ns.optional]
      divisor: string,
      [@ns.optional]
      dominantBaseline: string,
      [@ns.optional]
      download: string,
      [@ns.optional]
      draggable: bool,
      [@ns.optional]
      dur: string,
      [@ns.optional]
      dx: string,
      [@ns.optional]
      dy: string,
      [@ns.optional]
      edgeMode: string,
      [@ns.optional]
      elevation: string,
      [@ns.optional]
      enableBackground: string,
      [@ns.optional]
      encType: string,
      [@ns.optional]
      end_: string,
      [@ns.optional]
      exponent: string,
      [@ns.optional]
      externalResourcesRequired: string,
      [@ns.optional]
      fill: string,
      [@ns.optional]
      fillOpacity: string,
      [@ns.optional]
      fillRule: string,
      [@ns.optional]
      filter: string,
      [@ns.optional]
      filterRes: string,
      [@ns.optional]
      filterUnits: string,
      [@ns.optional]
      floodColor: string,
      [@ns.optional]
      floodOpacity: string,
      [@ns.optional]
      focusable: string,
      [@ns.optional]
      fomat: string,
      [@ns.optional]
      fontFamily: string,
      [@ns.optional]
      fontSize: string,
      [@ns.optional]
      fontSizeAdjust: string,
      [@ns.optional]
      fontStretch: string,
      [@ns.optional]
      fontStyle: string,
      [@ns.optional]
      fontVariant: string,
      [@ns.optional]
      fontWeight: string,
      [@ns.optional]
      form: string,
      [@ns.optional]
      formAction: string,
      [@ns.optional]
      formMethod: string,
      [@ns.optional]
      formTarget: string,
      [@ns.optional]
      from: string,
      [@ns.optional]
      fx: string,
      [@ns.optional]
      fy: string,
      [@ns.optional]
      g1: string,
      [@ns.optional]
      g2: string,
      [@ns.optional]
      glyphName: string,
      [@ns.optional]
      glyphOrientationHorizontal: string,
      [@ns.optional]
      glyphOrientationVertical: string,
      [@ns.optional]
      glyphRef: string,
      [@ns.optional]
      gradientTransform: string,
      [@ns.optional]
      gradientUnits: string,
      [@ns.optional]
      hanging: string,
      [@ns.optional]
      headers: string,
      [@ns.optional]
      height: string,
      [@ns.optional]
      hidden: bool,
      [@ns.optional]
      high: int,
      [@ns.optional]
      horizAdvX: string,
      [@ns.optional]
      horizOriginX: string,
      [@ns.optional]
      href: string,
      [@ns.optional]
      hrefLang: string,
      [@ns.optional]
      htmlFor: string,
      [@ns.optional]
      httpEquiv: string,
      [@ns.optional]
      icon: string,
      [@ns.optional]
      id: string,
      [@ns.optional]
      ideographic: string,
      [@ns.optional]
      imageRendering: string,
      [@ns.optional]
      in_: string,
      [@ns.optional]
      in2: string,
      [@ns.optional]
      inlist: string,
      [@ns.optional]
      inputMode: string,
      [@ns.optional]
      integrity: string,
      [@ns.optional]
      intercept: string,
      [@ns.optional]
      itemID: string,
      [@ns.optional]
      itemProp: string,
      [@ns.optional]
      itemRef: string,
      [@ns.optional]
      itemScope: bool,
      [@ns.optional]
      itemType: string,
      [@ns.optional]
      k: string,
      [@ns.optional]
      k1: string,
      [@ns.optional]
      k2: string,
      [@ns.optional]
      k3: string,
      [@ns.optional]
      k4: string,
      [@ns.optional]
      kernelMatrix: string,
      [@ns.optional]
      kernelUnitLength: string,
      [@ns.optional]
      kerning: string,
      [@ns.optional]
      key: string,
      [@ns.optional]
      keyPoints: string,
      [@ns.optional]
      keySplines: string,
      [@ns.optional]
      keyTimes: string,
      [@ns.optional]
      keyType: string,
      [@ns.optional]
      kind: string,
      [@ns.optional]
      label: string,
      [@ns.optional]
      lang: string,
      [@ns.optional]
      lengthAdjust: string,
      [@ns.optional]
      letterSpacing: string,
      [@ns.optional]
      lightingColor: string,
      [@ns.optional]
      limitingConeAngle: string,
      [@ns.optional]
      list: string,
      [@ns.optional]
      local: string,
      [@ns.optional]
      loop: bool,
      [@ns.optional]
      low: int,
      [@ns.optional]
      manifest: string,
      [@ns.optional]
      markerEnd: string,
      [@ns.optional]
      markerHeight: string,
      [@ns.optional]
      markerMid: string,
      [@ns.optional]
      markerStart: string,
      [@ns.optional]
      markerUnits: string,
      [@ns.optional]
      markerWidth: string,
      [@ns.optional]
      mask: string,
      [@ns.optional]
      maskContentUnits: string,
      [@ns.optional]
      maskUnits: string,
      [@ns.optional]
      mathematical: string,
      [@ns.optional]
      max: string,
      [@ns.optional]
      maxLength: int,
      [@ns.optional]
      media: string,
      [@ns.optional]
      mediaGroup: string,
      [@ns.optional]
      min: int,
      [@ns.optional]
      minLength: int,
      [@ns.optional]
      mode: string,
      [@ns.optional]
      multiple: bool,
      [@ns.optional]
      muted: bool,
      [@ns.optional]
      name: string,
      [@ns.optional]
      nonce: string,
      [@ns.optional]
      noValidate: bool,
      [@ns.optional]
      numOctaves: string,
      [@ns.optional]
      offset: string,
      [@ns.optional]
      opacity: string,
      [@ns.optional]
      open_: bool,
      [@ns.optional]
      operator: string,
      [@ns.optional]
      optimum: int,
      [@ns.optional]
      order: string,
      [@ns.optional]
      orient: string,
      [@ns.optional]
      orientation: string,
      [@ns.optional]
      origin: string,
      [@ns.optional]
      overflow: string,
      [@ns.optional]
      overflowX: string,
      [@ns.optional]
      overflowY: string,
      [@ns.optional]
      overlinePosition: string,
      [@ns.optional]
      overlineThickness: string,
      [@ns.optional]
      paintOrder: string,
      [@ns.optional]
      panose1: string,
      [@ns.optional]
      pathLength: string,
      [@ns.optional]
      pattern: string,
      [@ns.optional]
      patternContentUnits: string,
      [@ns.optional]
      patternTransform: string,
      [@ns.optional]
      patternUnits: string,
      [@ns.optional]
      placeholder: string,
      [@ns.optional]
      pointerEvents: string,
      [@ns.optional]
      points: string,
      [@ns.optional]
      pointsAtX: string,
      [@ns.optional]
      pointsAtY: string,
      [@ns.optional]
      pointsAtZ: string,
      [@ns.optional]
      poster: string,
      [@ns.optional]
      prefix: string,
      [@ns.optional]
      preload: string,
      [@ns.optional]
      preserveAlpha: string,
      [@ns.optional]
      preserveAspectRatio: string,
      [@ns.optional]
      primitiveUnits: string,
      [@ns.optional]
      property: string,
      [@ns.optional]
      r: string,
      [@ns.optional]
      radioGroup: string,
      [@ns.optional]
      radius: string,
      [@ns.optional]
      readOnly: bool,
      [@ns.optional]
      refX: string,
      [@ns.optional]
      refY: string,
      [@ns.optional]
      rel: string,
      [@ns.optional]
      renderingIntent: string,
      [@ns.optional]
      repeatCount: string,
      [@ns.optional]
      repeatDur: string,
      [@ns.optional]
      required: bool,
      [@ns.optional]
      requiredExtensions: string,
      [@ns.optional]
      requiredFeatures: string,
      [@ns.optional]
      resource: string,
      [@ns.optional]
      restart: string,
      [@ns.optional]
      result: string,
      [@ns.optional]
      reversed: bool,
      [@ns.optional]
      role: string,
      [@ns.optional]
      rotate: string,
      [@ns.optional]
      rows: int,
      [@ns.optional]
      rowSpan: int,
      [@ns.optional]
      rx: string,
      [@ns.optional]
      ry: string,
      [@ns.optional]
      sandbox: string,
      [@ns.optional]
      scale: string,
      [@ns.optional]
      scope: string,
      [@ns.optional]
      scoped: bool,
      [@ns.optional]
      scrolling: string,
      [@ns.optional]
      seed: string,
      [@ns.optional]
      selected: bool,
      [@ns.optional]
      shape: string,
      [@ns.optional]
      shapeRendering: string,
      [@ns.optional]
      sizes: string,
      [@ns.optional]
      slope: string,
      [@ns.optional]
      spacing: string,
      [@ns.optional]
      span: int,
      [@ns.optional]
      specularConstant: string,
      [@ns.optional]
      specularExponent: string,
      [@ns.optional]
      speed: string,
      [@ns.optional]
      spellCheck: bool,
      [@ns.optional]
      spreadMethod: string,
      [@ns.optional]
      src: string,
      [@ns.optional]
      srcDoc: string,
      [@ns.optional]
      srcLang: string,
      [@ns.optional]
      srcSet: string,
      [@ns.optional]
      start: int,
      [@ns.optional]
      startOffset: string,
      [@ns.optional]
      stdDeviation: string,
      [@ns.optional]
      stemh: string,
      [@ns.optional]
      stemv: string,
      [@ns.optional]
      step: float,
      [@ns.optional]
      stitchTiles: string,
      [@ns.optional]
      stopColor: string,
      [@ns.optional]
      stopOpacity: string,
      [@ns.optional]
      strikethroughPosition: string,
      [@ns.optional]
      strikethroughThickness: string,
      [@ns.optional]
      stroke: string,
      [@ns.optional]
      strokeDasharray: string,
      [@ns.optional]
      strokeDashoffset: string,
      [@ns.optional]
      strokeLinecap: string,
      [@ns.optional]
      strokeLinejoin: string,
      [@ns.optional]
      strokeMiterlimit: string,
      [@ns.optional]
      strokeOpacity: string,
      [@ns.optional]
      strokeWidth: string,
      [@ns.optional]
      style: ReactDOM.Style.t,
      [@ns.optional]
      summary: string,
      [@ns.optional]
      suppressContentEditableWarning: bool,
      [@ns.optional]
      surfaceScale: string,
      [@ns.optional]
      systemLanguage: string,
      [@ns.optional]
      tabIndex: int,
      [@ns.optional]
      tableValues: string,
      [@ns.optional]
      target: string,
      [@ns.optional]
      targetX: string,
      [@ns.optional]
      targetY: string,
      [@ns.optional]
      textAnchor: string,
      [@ns.optional]
      textDecoration: string,
      [@ns.optional]
      textLength: string,
      [@ns.optional]
      textRendering: string,
      [@ns.optional]
      title: string,
      [@ns.optional]
      to_: string,
      [@ns.optional]
      transform: string,
      [@ns.optional] [@bs.as "type"]
      type_: string,
      [@ns.optional]
      typeof: string,
      [@ns.optional]
      u1: string,
      [@ns.optional]
      u2: string,
      [@ns.optional]
      underlinePosition: string,
      [@ns.optional]
      underlineThickness: string,
      [@ns.optional]
      unicode: string,
      [@ns.optional]
      unicodeBidi: string,
      [@ns.optional]
      unicodeRange: string,
      [@ns.optional]
      unitsPerEm: string,
      [@ns.optional]
      useMap: string,
      [@ns.optional]
      vAlphabetic: string,
      [@ns.optional]
      value: string,
      [@ns.optional]
      values: string,
      [@ns.optional]
      vectorEffect: string,
      [@ns.optional]
      version: string,
      [@ns.optional]
      vertAdvX: string,
      [@ns.optional]
      vertAdvY: string,
      [@ns.optional]
      vertOriginX: string,
      [@ns.optional]
      vertOriginY: string,
      [@ns.optional]
      vHanging: string,
      [@ns.optional]
      vIdeographic: string,
      [@ns.optional]
      viewBox: string,
      [@ns.optional]
      viewTarget: string,
      [@ns.optional]
      visibility: string,
      [@ns.optional]
      vMathematical: string,
      [@ns.optional]
      vocab: string,
      [@ns.optional]
      width: string,
      [@ns.optional]
      widths: string,
      [@ns.optional]
      wordSpacing: string,
      [@ns.optional]
      wrap: string,
      [@ns.optional]
      writingMode: string,
      [@ns.optional]
      x: string,
      [@ns.optional]
      x1: string,
      [@ns.optional]
      x2: string,
      [@ns.optional]
      xChannelSelector: string,
      [@ns.optional]
      xHeight: string,
      [@ns.optional]
      xlinkActuate: string,
      [@ns.optional]
      xlinkArcrole: string,
      [@ns.optional]
      xlinkHref: string,
      [@ns.optional]
      xlinkRole: string,
      [@ns.optional]
      xlinkShow: string,
      [@ns.optional]
      xlinkTitle: string,
      [@ns.optional]
      xlinkType: string,
      [@ns.optional]
      xmlBase: string,
      [@ns.optional]
      xmlLang: string,
      [@ns.optional]
      xmlns: string,
      [@ns.optional]
      xmlnsXlink: string,
      [@ns.optional]
      xmlSpace: string,
      [@ns.optional]
      y: string,
      [@ns.optional]
      y1: string,
      [@ns.optional]
      y2: string,
      [@ns.optional]
      yChannelSelector: string,
      [@ns.optional]
      z: string,
      [@ns.optional]
      zoomAndPan: string,
      [@ns.optional]
      onAbort: ReactEvent.Media.t => unit,
      [@ns.optional]
      onAnimationEnd: ReactEvent.Animation.t => unit,
      [@ns.optional]
      onAnimationIteration: ReactEvent.Animation.t => unit,
      [@ns.optional]
      onAnimationStart: ReactEvent.Animation.t => unit,
      [@ns.optional]
      onBlur: ReactEvent.Focus.t => unit,
      [@ns.optional]
      onCanPlay: ReactEvent.Media.t => unit,
      [@ns.optional]
      onCanPlayThrough: ReactEvent.Media.t => unit,
      [@ns.optional]
      onChange: ReactEvent.Form.t => unit,
      [@ns.optional]
      onClick: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onCompositionEnd: ReactEvent.Composition.t => unit,
      [@ns.optional]
      onCompositionStart: ReactEvent.Composition.t => unit,
      [@ns.optional]
      onCompositionUpdate: ReactEvent.Composition.t => unit,
      [@ns.optional]
      onContextMenu: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onCopy: ReactEvent.Clipboard.t => unit,
      [@ns.optional]
      onCut: ReactEvent.Clipboard.t => unit,
      [@ns.optional]
      onDoubleClick: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDrag: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragEnd: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragEnter: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragExit: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragLeave: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragOver: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragStart: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDrop: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDurationChange: ReactEvent.Media.t => unit,
      [@ns.optional]
      onEmptied: ReactEvent.Media.t => unit,
      [@ns.optional]
      onEncrypetd: ReactEvent.Media.t => unit,
      [@ns.optional]
      onEnded: ReactEvent.Media.t => unit,
      [@ns.optional]
      onError: ReactEvent.Media.t => unit,
      [@ns.optional]
      onFocus: ReactEvent.Focus.t => unit,
      [@ns.optional]
      onInput: ReactEvent.Form.t => unit,
      [@ns.optional]
      onKeyDown: ReactEvent.Keyboard.t => unit,
      [@ns.optional]
      onKeyPress: ReactEvent.Keyboard.t => unit,
      [@ns.optional]
      onKeyUp: ReactEvent.Keyboard.t => unit,
      [@ns.optional]
      onLoadedData: ReactEvent.Media.t => unit,
      [@ns.optional]
      onLoadedMetadata: ReactEvent.Media.t => unit,
      [@ns.optional]
      onLoadStart: ReactEvent.Media.t => unit,
      [@ns.optional]
      onMouseDown: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseEnter: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseLeave: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseMove: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseOut: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseOver: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseUp: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onPaste: ReactEvent.Clipboard.t => unit,
      [@ns.optional]
      onPause: ReactEvent.Media.t => unit,
      [@ns.optional]
      onPlay: ReactEvent.Media.t => unit,
      [@ns.optional]
      onPlaying: ReactEvent.Media.t => unit,
      [@ns.optional]
      onProgress: ReactEvent.Media.t => unit,
      [@ns.optional]
      onRateChange: ReactEvent.Media.t => unit,
      [@ns.optional]
      onScroll: ReactEvent.UI.t => unit,
      [@ns.optional]
      onSeeked: ReactEvent.Media.t => unit,
      [@ns.optional]
      onSeeking: ReactEvent.Media.t => unit,
      [@ns.optional]
      onSelect: ReactEvent.Selection.t => unit,
      [@ns.optional]
      onStalled: ReactEvent.Media.t => unit,
      [@ns.optional]
      onSubmit: ReactEvent.Form.t => unit,
      [@ns.optional]
      onSuspend: ReactEvent.Media.t => unit,
      [@ns.optional]
      onTimeUpdate: ReactEvent.Media.t => unit,
      [@ns.optional]
      onTouchCancel: ReactEvent.Touch.t => unit,
      [@ns.optional]
      onTouchEnd: ReactEvent.Touch.t => unit,
      [@ns.optional]
      onTouchMove: ReactEvent.Touch.t => unit,
      [@ns.optional]
      onTouchStart: ReactEvent.Touch.t => unit,
      [@ns.optional]
      onTransitionEnd: ReactEvent.Transition.t => unit,
      [@ns.optional]
      onVolumeChange: ReactEvent.Media.t => unit,
      [@ns.optional]
      onWaiting: ReactEvent.Media.t => unit,
      [@ns.optional]
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
      let className = styles(~size=props.size, ());
      let stylesObject = {"className": className, "ref": props.ref};
      let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
      ignore(deleteProp(newProps, "size"));
      createVariadicElement("div", newProps);
    };
  };
  module DynamicComponentWithSequence = {
    [@ns.optional]
    type props('variant) = {
      [@ns.optional]
      ref: ReactDOM.domRef,
      [@ns.optional]
      children: React.element,
      [@ns.optional]
      about: string,
      [@ns.optional]
      accentHeight: string,
      [@ns.optional]
      accept: string,
      [@ns.optional]
      acceptCharset: string,
      [@ns.optional]
      accessKey: string,
      [@ns.optional]
      accumulate: string,
      [@ns.optional]
      action: string,
      [@ns.optional]
      additive: string,
      [@ns.optional]
      alignmentBaseline: string,
      [@ns.optional]
      allowFullScreen: bool,
      [@ns.optional]
      allowReorder: string,
      [@ns.optional]
      alphabetic: string,
      [@ns.optional]
      alt: string,
      [@ns.optional]
      amplitude: string,
      [@ns.optional]
      arabicForm: string,
      [@ns.optional] [@bs.as "aria-activedescendant"]
      ariaActivedescendant: string,
      [@ns.optional] [@bs.as "aria-atomic"]
      ariaAtomic: bool,
      [@ns.optional] [@bs.as "aria-busy"]
      ariaBusy: bool,
      [@ns.optional] [@bs.as "aria-colcount"]
      ariaColcount: int,
      [@ns.optional] [@bs.as "aria-colindex"]
      ariaColindex: int,
      [@ns.optional] [@bs.as "aria-colspan"]
      ariaColspan: int,
      [@ns.optional] [@bs.as "aria-controls"]
      ariaControls: string,
      [@ns.optional] [@bs.as "aria-describedby"]
      ariaDescribedby: string,
      [@ns.optional] [@bs.as "aria-details"]
      ariaDetails: string,
      [@ns.optional] [@bs.as "aria-disabled"]
      ariaDisabled: bool,
      [@ns.optional] [@bs.as "aria-errormessage"]
      ariaErrormessage: string,
      [@ns.optional] [@bs.as "aria-expanded"]
      ariaExpanded: bool,
      [@ns.optional] [@bs.as "aria-flowto"]
      ariaFlowto: string,
      [@ns.optional] [@bs.as "aria-grabbed"]
      ariaGrabbed: bool,
      [@ns.optional] [@bs.as "aria-hidden"]
      ariaHidden: bool,
      [@ns.optional] [@bs.as "aria-keyshortcuts"]
      ariaKeyshortcuts: string,
      [@ns.optional] [@bs.as "aria-label"]
      ariaLabel: string,
      [@ns.optional] [@bs.as "aria-labelledby"]
      ariaLabelledby: string,
      [@ns.optional] [@bs.as "aria-level"]
      ariaLevel: int,
      [@ns.optional] [@bs.as "aria-modal"]
      ariaModal: bool,
      [@ns.optional] [@bs.as "aria-multiline"]
      ariaMultiline: bool,
      [@ns.optional] [@bs.as "aria-multiselectable"]
      ariaMultiselectable: bool,
      [@ns.optional] [@bs.as "aria-owns"]
      ariaOwns: string,
      [@ns.optional] [@bs.as "aria-placeholder"]
      ariaPlaceholder: string,
      [@ns.optional] [@bs.as "aria-posinset"]
      ariaPosinset: int,
      [@ns.optional] [@bs.as "aria-readonly"]
      ariaReadonly: bool,
      [@ns.optional] [@bs.as "aria-relevant"]
      ariaRelevant: string,
      [@ns.optional] [@bs.as "aria-required"]
      ariaRequired: bool,
      [@ns.optional] [@bs.as "aria-roledescription"]
      ariaRoledescription: string,
      [@ns.optional] [@bs.as "aria-rowcount"]
      ariaRowcount: int,
      [@ns.optional] [@bs.as "aria-rowindex"]
      ariaRowindex: int,
      [@ns.optional] [@bs.as "aria-rowspan"]
      ariaRowspan: int,
      [@ns.optional] [@bs.as "aria-selected"]
      ariaSelected: bool,
      [@ns.optional] [@bs.as "aria-setsize"]
      ariaSetsize: int,
      [@ns.optional] [@bs.as "aria-sort"]
      ariaSort: string,
      [@ns.optional] [@bs.as "aria-valuemax"]
      ariaValuemax: float,
      [@ns.optional] [@bs.as "aria-valuemin"]
      ariaValuemin: float,
      [@ns.optional] [@bs.as "aria-valuenow"]
      ariaValuenow: float,
      [@ns.optional] [@bs.as "aria-valuetext"]
      ariaValuetext: string,
      [@ns.optional]
      ascent: string,
      [@ns.optional]
      async: bool,
      [@ns.optional]
      attributeName: string,
      [@ns.optional]
      attributeType: string,
      [@ns.optional]
      autoComplete: string,
      [@ns.optional]
      autoFocus: bool,
      [@ns.optional]
      autoPlay: bool,
      [@ns.optional]
      autoReverse: string,
      [@ns.optional]
      azimuth: string,
      [@ns.optional]
      baseFrequency: string,
      [@ns.optional]
      baselineShift: string,
      [@ns.optional]
      baseProfile: string,
      [@ns.optional]
      bbox: string,
      [@ns.optional]
      begin_: string,
      [@ns.optional]
      bias: string,
      [@ns.optional]
      by: string,
      [@ns.optional]
      calcMode: string,
      [@ns.optional]
      capHeight: string,
      [@ns.optional]
      challenge: string,
      [@ns.optional]
      charSet: string,
      [@ns.optional]
      checked: bool,
      [@ns.optional]
      cite: string,
      [@ns.optional]
      className: string,
      [@ns.optional]
      clip: string,
      [@ns.optional]
      clipPath: string,
      [@ns.optional]
      clipPathUnits: string,
      [@ns.optional]
      clipRule: string,
      [@ns.optional]
      colorInterpolation: string,
      [@ns.optional]
      colorInterpolationFilters: string,
      [@ns.optional]
      colorProfile: string,
      [@ns.optional]
      colorRendering: string,
      [@ns.optional]
      cols: int,
      [@ns.optional]
      colSpan: int,
      [@ns.optional]
      content: string,
      [@ns.optional]
      contentEditable: bool,
      [@ns.optional]
      contentScriptType: string,
      [@ns.optional]
      contentStyleType: string,
      [@ns.optional]
      contextMenu: string,
      [@ns.optional]
      controls: bool,
      [@ns.optional]
      coords: string,
      [@ns.optional]
      crossorigin: bool,
      [@ns.optional]
      cursor: string,
      [@ns.optional]
      cx: string,
      [@ns.optional]
      cy: string,
      [@ns.optional]
      d: string,
      [@ns.optional]
      data: string,
      [@ns.optional]
      datatype: string,
      [@ns.optional]
      dateTime: string,
      [@ns.optional]
      decelerate: string,
      [@ns.optional]
      default: bool,
      [@ns.optional]
      defaultChecked: bool,
      [@ns.optional]
      defaultValue: string,
      [@ns.optional]
      defer: bool,
      [@ns.optional]
      descent: string,
      [@ns.optional]
      diffuseConstant: string,
      [@ns.optional]
      dir: string,
      [@ns.optional]
      direction: string,
      [@ns.optional]
      disabled: bool,
      [@ns.optional]
      display: string,
      [@ns.optional]
      divisor: string,
      [@ns.optional]
      dominantBaseline: string,
      [@ns.optional]
      download: string,
      [@ns.optional]
      draggable: bool,
      [@ns.optional]
      dur: string,
      [@ns.optional]
      dx: string,
      [@ns.optional]
      dy: string,
      [@ns.optional]
      edgeMode: string,
      [@ns.optional]
      elevation: string,
      [@ns.optional]
      enableBackground: string,
      [@ns.optional]
      encType: string,
      [@ns.optional]
      end_: string,
      [@ns.optional]
      exponent: string,
      [@ns.optional]
      externalResourcesRequired: string,
      [@ns.optional]
      fill: string,
      [@ns.optional]
      fillOpacity: string,
      [@ns.optional]
      fillRule: string,
      [@ns.optional]
      filter: string,
      [@ns.optional]
      filterRes: string,
      [@ns.optional]
      filterUnits: string,
      [@ns.optional]
      floodColor: string,
      [@ns.optional]
      floodOpacity: string,
      [@ns.optional]
      focusable: string,
      [@ns.optional]
      fomat: string,
      [@ns.optional]
      fontFamily: string,
      [@ns.optional]
      fontSize: string,
      [@ns.optional]
      fontSizeAdjust: string,
      [@ns.optional]
      fontStretch: string,
      [@ns.optional]
      fontStyle: string,
      [@ns.optional]
      fontVariant: string,
      [@ns.optional]
      fontWeight: string,
      [@ns.optional]
      form: string,
      [@ns.optional]
      formAction: string,
      [@ns.optional]
      formMethod: string,
      [@ns.optional]
      formTarget: string,
      [@ns.optional]
      from: string,
      [@ns.optional]
      fx: string,
      [@ns.optional]
      fy: string,
      [@ns.optional]
      g1: string,
      [@ns.optional]
      g2: string,
      [@ns.optional]
      glyphName: string,
      [@ns.optional]
      glyphOrientationHorizontal: string,
      [@ns.optional]
      glyphOrientationVertical: string,
      [@ns.optional]
      glyphRef: string,
      [@ns.optional]
      gradientTransform: string,
      [@ns.optional]
      gradientUnits: string,
      [@ns.optional]
      hanging: string,
      [@ns.optional]
      headers: string,
      [@ns.optional]
      height: string,
      [@ns.optional]
      hidden: bool,
      [@ns.optional]
      high: int,
      [@ns.optional]
      horizAdvX: string,
      [@ns.optional]
      horizOriginX: string,
      [@ns.optional]
      href: string,
      [@ns.optional]
      hrefLang: string,
      [@ns.optional]
      htmlFor: string,
      [@ns.optional]
      httpEquiv: string,
      [@ns.optional]
      icon: string,
      [@ns.optional]
      id: string,
      [@ns.optional]
      ideographic: string,
      [@ns.optional]
      imageRendering: string,
      [@ns.optional]
      in_: string,
      [@ns.optional]
      in2: string,
      [@ns.optional]
      inlist: string,
      [@ns.optional]
      inputMode: string,
      [@ns.optional]
      integrity: string,
      [@ns.optional]
      intercept: string,
      [@ns.optional]
      itemID: string,
      [@ns.optional]
      itemProp: string,
      [@ns.optional]
      itemRef: string,
      [@ns.optional]
      itemScope: bool,
      [@ns.optional]
      itemType: string,
      [@ns.optional]
      k: string,
      [@ns.optional]
      k1: string,
      [@ns.optional]
      k2: string,
      [@ns.optional]
      k3: string,
      [@ns.optional]
      k4: string,
      [@ns.optional]
      kernelMatrix: string,
      [@ns.optional]
      kernelUnitLength: string,
      [@ns.optional]
      kerning: string,
      [@ns.optional]
      key: string,
      [@ns.optional]
      keyPoints: string,
      [@ns.optional]
      keySplines: string,
      [@ns.optional]
      keyTimes: string,
      [@ns.optional]
      keyType: string,
      [@ns.optional]
      kind: string,
      [@ns.optional]
      label: string,
      [@ns.optional]
      lang: string,
      [@ns.optional]
      lengthAdjust: string,
      [@ns.optional]
      letterSpacing: string,
      [@ns.optional]
      lightingColor: string,
      [@ns.optional]
      limitingConeAngle: string,
      [@ns.optional]
      list: string,
      [@ns.optional]
      local: string,
      [@ns.optional]
      loop: bool,
      [@ns.optional]
      low: int,
      [@ns.optional]
      manifest: string,
      [@ns.optional]
      markerEnd: string,
      [@ns.optional]
      markerHeight: string,
      [@ns.optional]
      markerMid: string,
      [@ns.optional]
      markerStart: string,
      [@ns.optional]
      markerUnits: string,
      [@ns.optional]
      markerWidth: string,
      [@ns.optional]
      mask: string,
      [@ns.optional]
      maskContentUnits: string,
      [@ns.optional]
      maskUnits: string,
      [@ns.optional]
      mathematical: string,
      [@ns.optional]
      max: string,
      [@ns.optional]
      maxLength: int,
      [@ns.optional]
      media: string,
      [@ns.optional]
      mediaGroup: string,
      [@ns.optional]
      min: int,
      [@ns.optional]
      minLength: int,
      [@ns.optional]
      mode: string,
      [@ns.optional]
      multiple: bool,
      [@ns.optional]
      muted: bool,
      [@ns.optional]
      name: string,
      [@ns.optional]
      nonce: string,
      [@ns.optional]
      noValidate: bool,
      [@ns.optional]
      numOctaves: string,
      [@ns.optional]
      offset: string,
      [@ns.optional]
      opacity: string,
      [@ns.optional]
      open_: bool,
      [@ns.optional]
      operator: string,
      [@ns.optional]
      optimum: int,
      [@ns.optional]
      order: string,
      [@ns.optional]
      orient: string,
      [@ns.optional]
      orientation: string,
      [@ns.optional]
      origin: string,
      [@ns.optional]
      overflow: string,
      [@ns.optional]
      overflowX: string,
      [@ns.optional]
      overflowY: string,
      [@ns.optional]
      overlinePosition: string,
      [@ns.optional]
      overlineThickness: string,
      [@ns.optional]
      paintOrder: string,
      [@ns.optional]
      panose1: string,
      [@ns.optional]
      pathLength: string,
      [@ns.optional]
      pattern: string,
      [@ns.optional]
      patternContentUnits: string,
      [@ns.optional]
      patternTransform: string,
      [@ns.optional]
      patternUnits: string,
      [@ns.optional]
      placeholder: string,
      [@ns.optional]
      pointerEvents: string,
      [@ns.optional]
      points: string,
      [@ns.optional]
      pointsAtX: string,
      [@ns.optional]
      pointsAtY: string,
      [@ns.optional]
      pointsAtZ: string,
      [@ns.optional]
      poster: string,
      [@ns.optional]
      prefix: string,
      [@ns.optional]
      preload: string,
      [@ns.optional]
      preserveAlpha: string,
      [@ns.optional]
      preserveAspectRatio: string,
      [@ns.optional]
      primitiveUnits: string,
      [@ns.optional]
      property: string,
      [@ns.optional]
      r: string,
      [@ns.optional]
      radioGroup: string,
      [@ns.optional]
      radius: string,
      [@ns.optional]
      readOnly: bool,
      [@ns.optional]
      refX: string,
      [@ns.optional]
      refY: string,
      [@ns.optional]
      rel: string,
      [@ns.optional]
      renderingIntent: string,
      [@ns.optional]
      repeatCount: string,
      [@ns.optional]
      repeatDur: string,
      [@ns.optional]
      required: bool,
      [@ns.optional]
      requiredExtensions: string,
      [@ns.optional]
      requiredFeatures: string,
      [@ns.optional]
      resource: string,
      [@ns.optional]
      restart: string,
      [@ns.optional]
      result: string,
      [@ns.optional]
      reversed: bool,
      [@ns.optional]
      role: string,
      [@ns.optional]
      rotate: string,
      [@ns.optional]
      rows: int,
      [@ns.optional]
      rowSpan: int,
      [@ns.optional]
      rx: string,
      [@ns.optional]
      ry: string,
      [@ns.optional]
      sandbox: string,
      [@ns.optional]
      scale: string,
      [@ns.optional]
      scope: string,
      [@ns.optional]
      scoped: bool,
      [@ns.optional]
      scrolling: string,
      [@ns.optional]
      seed: string,
      [@ns.optional]
      selected: bool,
      [@ns.optional]
      shape: string,
      [@ns.optional]
      shapeRendering: string,
      [@ns.optional]
      size: int,
      [@ns.optional]
      sizes: string,
      [@ns.optional]
      slope: string,
      [@ns.optional]
      spacing: string,
      [@ns.optional]
      span: int,
      [@ns.optional]
      specularConstant: string,
      [@ns.optional]
      specularExponent: string,
      [@ns.optional]
      speed: string,
      [@ns.optional]
      spellCheck: bool,
      [@ns.optional]
      spreadMethod: string,
      [@ns.optional]
      src: string,
      [@ns.optional]
      srcDoc: string,
      [@ns.optional]
      srcLang: string,
      [@ns.optional]
      srcSet: string,
      [@ns.optional]
      start: int,
      [@ns.optional]
      startOffset: string,
      [@ns.optional]
      stdDeviation: string,
      [@ns.optional]
      stemh: string,
      [@ns.optional]
      stemv: string,
      [@ns.optional]
      step: float,
      [@ns.optional]
      stitchTiles: string,
      [@ns.optional]
      stopColor: string,
      [@ns.optional]
      stopOpacity: string,
      [@ns.optional]
      strikethroughPosition: string,
      [@ns.optional]
      strikethroughThickness: string,
      [@ns.optional]
      stroke: string,
      [@ns.optional]
      strokeDasharray: string,
      [@ns.optional]
      strokeDashoffset: string,
      [@ns.optional]
      strokeLinecap: string,
      [@ns.optional]
      strokeLinejoin: string,
      [@ns.optional]
      strokeMiterlimit: string,
      [@ns.optional]
      strokeOpacity: string,
      [@ns.optional]
      strokeWidth: string,
      [@ns.optional]
      style: ReactDOM.Style.t,
      [@ns.optional]
      summary: string,
      [@ns.optional]
      suppressContentEditableWarning: bool,
      [@ns.optional]
      surfaceScale: string,
      [@ns.optional]
      systemLanguage: string,
      [@ns.optional]
      tabIndex: int,
      [@ns.optional]
      tableValues: string,
      [@ns.optional]
      target: string,
      [@ns.optional]
      targetX: string,
      [@ns.optional]
      targetY: string,
      [@ns.optional]
      textAnchor: string,
      [@ns.optional]
      textDecoration: string,
      [@ns.optional]
      textLength: string,
      [@ns.optional]
      textRendering: string,
      [@ns.optional]
      title: string,
      [@ns.optional]
      to_: string,
      [@ns.optional]
      transform: string,
      [@ns.optional] [@bs.as "type"]
      type_: string,
      [@ns.optional]
      typeof: string,
      [@ns.optional]
      u1: string,
      [@ns.optional]
      u2: string,
      [@ns.optional]
      underlinePosition: string,
      [@ns.optional]
      underlineThickness: string,
      [@ns.optional]
      unicode: string,
      [@ns.optional]
      unicodeBidi: string,
      [@ns.optional]
      unicodeRange: string,
      [@ns.optional]
      unitsPerEm: string,
      [@ns.optional]
      useMap: string,
      [@ns.optional]
      vAlphabetic: string,
      [@ns.optional]
      value: string,
      [@ns.optional]
      values: string,
      [@ns.optional]
      vectorEffect: string,
      [@ns.optional]
      version: string,
      [@ns.optional]
      vertAdvX: string,
      [@ns.optional]
      vertAdvY: string,
      [@ns.optional]
      vertOriginX: string,
      [@ns.optional]
      vertOriginY: string,
      [@ns.optional]
      vHanging: string,
      [@ns.optional]
      vIdeographic: string,
      [@ns.optional]
      viewBox: string,
      [@ns.optional]
      viewTarget: string,
      [@ns.optional]
      visibility: string,
      [@ns.optional]
      vMathematical: string,
      [@ns.optional]
      vocab: string,
      [@ns.optional]
      width: string,
      [@ns.optional]
      widths: string,
      [@ns.optional]
      wordSpacing: string,
      [@ns.optional]
      wrap: string,
      [@ns.optional]
      writingMode: string,
      [@ns.optional]
      x: string,
      [@ns.optional]
      x1: string,
      [@ns.optional]
      x2: string,
      [@ns.optional]
      xChannelSelector: string,
      [@ns.optional]
      xHeight: string,
      [@ns.optional]
      xlinkActuate: string,
      [@ns.optional]
      xlinkArcrole: string,
      [@ns.optional]
      xlinkHref: string,
      [@ns.optional]
      xlinkRole: string,
      [@ns.optional]
      xlinkShow: string,
      [@ns.optional]
      xlinkTitle: string,
      [@ns.optional]
      xlinkType: string,
      [@ns.optional]
      xmlBase: string,
      [@ns.optional]
      xmlLang: string,
      [@ns.optional]
      xmlns: string,
      [@ns.optional]
      xmlnsXlink: string,
      [@ns.optional]
      xmlSpace: string,
      [@ns.optional]
      y: string,
      [@ns.optional]
      y1: string,
      [@ns.optional]
      y2: string,
      [@ns.optional]
      yChannelSelector: string,
      [@ns.optional]
      z: string,
      [@ns.optional]
      zoomAndPan: string,
      [@ns.optional]
      onAbort: ReactEvent.Media.t => unit,
      [@ns.optional]
      onAnimationEnd: ReactEvent.Animation.t => unit,
      [@ns.optional]
      onAnimationIteration: ReactEvent.Animation.t => unit,
      [@ns.optional]
      onAnimationStart: ReactEvent.Animation.t => unit,
      [@ns.optional]
      onBlur: ReactEvent.Focus.t => unit,
      [@ns.optional]
      onCanPlay: ReactEvent.Media.t => unit,
      [@ns.optional]
      onCanPlayThrough: ReactEvent.Media.t => unit,
      [@ns.optional]
      onChange: ReactEvent.Form.t => unit,
      [@ns.optional]
      onClick: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onCompositionEnd: ReactEvent.Composition.t => unit,
      [@ns.optional]
      onCompositionStart: ReactEvent.Composition.t => unit,
      [@ns.optional]
      onCompositionUpdate: ReactEvent.Composition.t => unit,
      [@ns.optional]
      onContextMenu: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onCopy: ReactEvent.Clipboard.t => unit,
      [@ns.optional]
      onCut: ReactEvent.Clipboard.t => unit,
      [@ns.optional]
      onDoubleClick: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDrag: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragEnd: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragEnter: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragExit: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragLeave: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragOver: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDragStart: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDrop: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onDurationChange: ReactEvent.Media.t => unit,
      [@ns.optional]
      onEmptied: ReactEvent.Media.t => unit,
      [@ns.optional]
      onEncrypetd: ReactEvent.Media.t => unit,
      [@ns.optional]
      onEnded: ReactEvent.Media.t => unit,
      [@ns.optional]
      onError: ReactEvent.Media.t => unit,
      [@ns.optional]
      onFocus: ReactEvent.Focus.t => unit,
      [@ns.optional]
      onInput: ReactEvent.Form.t => unit,
      [@ns.optional]
      onKeyDown: ReactEvent.Keyboard.t => unit,
      [@ns.optional]
      onKeyPress: ReactEvent.Keyboard.t => unit,
      [@ns.optional]
      onKeyUp: ReactEvent.Keyboard.t => unit,
      [@ns.optional]
      onLoadedData: ReactEvent.Media.t => unit,
      [@ns.optional]
      onLoadedMetadata: ReactEvent.Media.t => unit,
      [@ns.optional]
      onLoadStart: ReactEvent.Media.t => unit,
      [@ns.optional]
      onMouseDown: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseEnter: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseLeave: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseMove: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseOut: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseOver: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onMouseUp: ReactEvent.Mouse.t => unit,
      [@ns.optional]
      onPaste: ReactEvent.Clipboard.t => unit,
      [@ns.optional]
      onPause: ReactEvent.Media.t => unit,
      [@ns.optional]
      onPlay: ReactEvent.Media.t => unit,
      [@ns.optional]
      onPlaying: ReactEvent.Media.t => unit,
      [@ns.optional]
      onProgress: ReactEvent.Media.t => unit,
      [@ns.optional]
      onRateChange: ReactEvent.Media.t => unit,
      [@ns.optional]
      onScroll: ReactEvent.UI.t => unit,
      [@ns.optional]
      onSeeked: ReactEvent.Media.t => unit,
      [@ns.optional]
      onSeeking: ReactEvent.Media.t => unit,
      [@ns.optional]
      onSelect: ReactEvent.Selection.t => unit,
      [@ns.optional]
      onStalled: ReactEvent.Media.t => unit,
      [@ns.optional]
      onSubmit: ReactEvent.Form.t => unit,
      [@ns.optional]
      onSuspend: ReactEvent.Media.t => unit,
      [@ns.optional]
      onTimeUpdate: ReactEvent.Media.t => unit,
      [@ns.optional]
      onTouchCancel: ReactEvent.Touch.t => unit,
      [@ns.optional]
      onTouchEnd: ReactEvent.Touch.t => unit,
      [@ns.optional]
      onTouchMove: ReactEvent.Touch.t => unit,
      [@ns.optional]
      onTouchStart: ReactEvent.Touch.t => unit,
      [@ns.optional]
      onTransitionEnd: ReactEvent.Transition.t => unit,
      [@ns.optional]
      onVolumeChange: ReactEvent.Media.t => unit,
      [@ns.optional]
      onWaiting: ReactEvent.Media.t => unit,
      [@ns.optional]
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
      let className = styles(~variant=props.variant, ());
      let stylesObject = {"className": className, "ref": props.ref};
      let newProps = assign2(Js.Obj.empty(), Obj.magic(props), stylesObject);
      ignore(deleteProp(newProps, "variant"));
      createVariadicElement("button", newProps);
    };
  };