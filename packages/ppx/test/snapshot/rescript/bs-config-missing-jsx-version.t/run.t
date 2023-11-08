  $ npx bsc -ppx "rewriter" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res
  module ArrayDynamicComponent =
    struct
      type 'var makeProps =
        {
        innerRef: ReactDOM.domRef option [@mel.optional ];
        children: React.element option [@mel.optional ];
        about: string option [@mel.optional ];
        accentHeight: string option [@mel.optional ];
        accept: string option [@mel.optional ];
        acceptCharset: string option [@mel.optional ];
        accessKey: string option [@mel.optional ];
        accumulate: string option [@mel.optional ];
        action: string option [@mel.optional ];
        additive: string option [@mel.optional ];
        alignmentBaseline: string option [@mel.optional ];
        allowFullScreen: bool option [@mel.optional ];
        allowReorder: string option [@mel.optional ];
        alphabetic: string option [@mel.optional ];
        alt: string option [@mel.optional ];
        amplitude: string option [@mel.optional ];
        arabicForm: string option [@mel.optional ];
        ariaActivedescendant: string option
          [@mel.optional ][@mel.as "aria-activedescendant"];
        ariaAtomic: bool option [@mel.optional ][@mel.as "aria-atomic"];
        ariaBusy: bool option [@mel.optional ][@mel.as "aria-busy"];
        ariaColcount: int option [@mel.optional ][@mel.as "aria-colcount"];
        ariaColindex: int option [@mel.optional ][@mel.as "aria-colindex"];
        ariaColspan: int option [@mel.optional ][@mel.as "aria-colspan"];
        ariaControls: string option [@mel.optional ][@mel.as "aria-controls"];
        ariaDescribedby: string option
          [@mel.optional ][@mel.as "aria-describedby"];
        ariaDetails: string option [@mel.optional ][@mel.as "aria-details"];
        ariaDisabled: bool option [@mel.optional ][@mel.as "aria-disabled"];
        ariaErrormessage: string option
          [@mel.optional ][@mel.as "aria-errormessage"];
        ariaExpanded: bool option [@mel.optional ][@mel.as "aria-expanded"];
        ariaFlowto: string option [@mel.optional ][@mel.as "aria-flowto"];
        ariaGrabbed: bool option [@mel.optional ][@mel.as "aria-grabbed"];
        ariaHidden: bool option [@mel.optional ][@mel.as "aria-hidden"];
        ariaKeyshortcuts: string option
          [@mel.optional ][@mel.as "aria-keyshortcuts"];
        ariaLabel: string option [@mel.optional ][@mel.as "aria-label"];
        ariaLabelledby: string option
          [@mel.optional ][@mel.as "aria-labelledby"];
        ariaLevel: int option [@mel.optional ][@mel.as "aria-level"];
        ariaModal: bool option [@mel.optional ][@mel.as "aria-modal"];
        ariaMultiline: bool option [@mel.optional ][@mel.as "aria-multiline"];
        ariaMultiselectable: bool option
          [@mel.optional ][@mel.as "aria-multiselectable"];
        ariaOwns: string option [@mel.optional ][@mel.as "aria-owns"];
        ariaPlaceholder: string option
          [@mel.optional ][@mel.as "aria-placeholder"];
        ariaPosinset: int option [@mel.optional ][@mel.as "aria-posinset"];
        ariaReadonly: bool option [@mel.optional ][@mel.as "aria-readonly"];
        ariaRelevant: string option [@mel.optional ][@mel.as "aria-relevant"];
        ariaRequired: bool option [@mel.optional ][@mel.as "aria-required"];
        ariaRoledescription: string option
          [@mel.optional ][@mel.as "aria-roledescription"];
        ariaRowcount: int option [@mel.optional ][@mel.as "aria-rowcount"];
        ariaRowindex: int option [@mel.optional ][@mel.as "aria-rowindex"];
        ariaRowspan: int option [@mel.optional ][@mel.as "aria-rowspan"];
        ariaSelected: bool option [@mel.optional ][@mel.as "aria-selected"];
        ariaSetsize: int option [@mel.optional ][@mel.as "aria-setsize"];
        ariaSort: string option [@mel.optional ][@mel.as "aria-sort"];
        ariaValuemax: float option [@mel.optional ][@mel.as "aria-valuemax"];
        ariaValuemin: float option [@mel.optional ][@mel.as "aria-valuemin"];
        ariaValuenow: float option [@mel.optional ][@mel.as "aria-valuenow"];
        ariaValuetext: string option [@mel.optional ][@mel.as "aria-valuetext"];
        ascent: string option [@mel.optional ];
        async: bool option [@mel.optional ];
        attributeName: string option [@mel.optional ];
        attributeType: string option [@mel.optional ];
        autoComplete: string option [@mel.optional ];
        autoFocus: bool option [@mel.optional ];
        autoPlay: bool option [@mel.optional ];
        autoReverse: string option [@mel.optional ];
        azimuth: string option [@mel.optional ];
        baseFrequency: string option [@mel.optional ];
        baselineShift: string option [@mel.optional ];
        baseProfile: string option [@mel.optional ];
        bbox: string option [@mel.optional ];
        begin_: string option [@mel.optional ];
        bias: string option [@mel.optional ];
        by: string option [@mel.optional ];
        calcMode: string option [@mel.optional ];
        capHeight: string option [@mel.optional ];
        challenge: string option [@mel.optional ];
        charSet: string option [@mel.optional ];
        checked: bool option [@mel.optional ];
        cite: string option [@mel.optional ];
        className: string option [@mel.optional ];
        clip: string option [@mel.optional ];
        clipPath: string option [@mel.optional ];
        clipPathUnits: string option [@mel.optional ];
        clipRule: string option [@mel.optional ];
        colorInterpolation: string option [@mel.optional ];
        colorInterpolationFilters: string option [@mel.optional ];
        colorProfile: string option [@mel.optional ];
        colorRendering: string option [@mel.optional ];
        cols: int option [@mel.optional ];
        colSpan: int option [@mel.optional ];
        content: string option [@mel.optional ];
        contentEditable: bool option [@mel.optional ];
        contentScriptType: string option [@mel.optional ];
        contentStyleType: string option [@mel.optional ];
        contextMenu: string option [@mel.optional ];
        controls: bool option [@mel.optional ];
        coords: string option [@mel.optional ];
        crossorigin: bool option [@mel.optional ];
        cursor: string option [@mel.optional ];
        cx: string option [@mel.optional ];
        cy: string option [@mel.optional ];
        d: string option [@mel.optional ];
        data: string option [@mel.optional ];
        datatype: string option [@mel.optional ];
        dateTime: string option [@mel.optional ];
        decelerate: string option [@mel.optional ];
        default: bool option [@mel.optional ];
        defaultChecked: bool option [@mel.optional ];
        defaultValue: string option [@mel.optional ];
        defer: bool option [@mel.optional ];
        descent: string option [@mel.optional ];
        diffuseConstant: string option [@mel.optional ];
        dir: string option [@mel.optional ];
        direction: string option [@mel.optional ];
        disabled: bool option [@mel.optional ];
        display: string option [@mel.optional ];
        divisor: string option [@mel.optional ];
        dominantBaseline: string option [@mel.optional ];
        download: string option [@mel.optional ];
        draggable: bool option [@mel.optional ];
        dur: string option [@mel.optional ];
        dx: string option [@mel.optional ];
        dy: string option [@mel.optional ];
        edgeMode: string option [@mel.optional ];
        elevation: string option [@mel.optional ];
        enableBackground: string option [@mel.optional ];
        encType: string option [@mel.optional ];
        end_: string option [@mel.optional ];
        exponent: string option [@mel.optional ];
        externalResourcesRequired: string option [@mel.optional ];
        fill: string option [@mel.optional ];
        fillOpacity: string option [@mel.optional ];
        fillRule: string option [@mel.optional ];
        filter: string option [@mel.optional ];
        filterRes: string option [@mel.optional ];
        filterUnits: string option [@mel.optional ];
        floodColor: string option [@mel.optional ];
        floodOpacity: string option [@mel.optional ];
        focusable: string option [@mel.optional ];
        fomat: string option [@mel.optional ];
        fontFamily: string option [@mel.optional ];
        fontSize: string option [@mel.optional ];
        fontSizeAdjust: string option [@mel.optional ];
        fontStretch: string option [@mel.optional ];
        fontStyle: string option [@mel.optional ];
        fontVariant: string option [@mel.optional ];
        fontWeight: string option [@mel.optional ];
        form: string option [@mel.optional ];
        formAction: string option [@mel.optional ];
        formMethod: string option [@mel.optional ];
        formTarget: string option [@mel.optional ];
        from: string option [@mel.optional ];
        fx: string option [@mel.optional ];
        fy: string option [@mel.optional ];
        g1: string option [@mel.optional ];
        g2: string option [@mel.optional ];
        glyphName: string option [@mel.optional ];
        glyphOrientationHorizontal: string option [@mel.optional ];
        glyphOrientationVertical: string option [@mel.optional ];
        glyphRef: string option [@mel.optional ];
        gradientTransform: string option [@mel.optional ];
        gradientUnits: string option [@mel.optional ];
        hanging: string option [@mel.optional ];
        headers: string option [@mel.optional ];
        height: string option [@mel.optional ];
        hidden: bool option [@mel.optional ];
        high: int option [@mel.optional ];
        horizAdvX: string option [@mel.optional ];
        horizOriginX: string option [@mel.optional ];
        href: string option [@mel.optional ];
        hrefLang: string option [@mel.optional ];
        htmlFor: string option [@mel.optional ];
        httpEquiv: string option [@mel.optional ];
        icon: string option [@mel.optional ];
        id: string option [@mel.optional ];
        ideographic: string option [@mel.optional ];
        imageRendering: string option [@mel.optional ];
        in_: string option [@mel.optional ];
        in2: string option [@mel.optional ];
        inlist: string option [@mel.optional ];
        inputMode: string option [@mel.optional ];
        integrity: string option [@mel.optional ];
        intercept: string option [@mel.optional ];
        itemID: string option [@mel.optional ];
        itemProp: string option [@mel.optional ];
        itemRef: string option [@mel.optional ];
        itemScope: bool option [@mel.optional ];
        itemType: string option [@mel.optional ];
        k: string option [@mel.optional ];
        k1: string option [@mel.optional ];
        k2: string option [@mel.optional ];
        k3: string option [@mel.optional ];
        k4: string option [@mel.optional ];
        kernelMatrix: string option [@mel.optional ];
        kernelUnitLength: string option [@mel.optional ];
        kerning: string option [@mel.optional ];
        key: string option [@mel.optional ];
        keyPoints: string option [@mel.optional ];
        keySplines: string option [@mel.optional ];
        keyTimes: string option [@mel.optional ];
        keyType: string option [@mel.optional ];
        kind: string option [@mel.optional ];
        label: string option [@mel.optional ];
        lang: string option [@mel.optional ];
        lengthAdjust: string option [@mel.optional ];
        letterSpacing: string option [@mel.optional ];
        lightingColor: string option [@mel.optional ];
        limitingConeAngle: string option [@mel.optional ];
        list: string option [@mel.optional ];
        local: string option [@mel.optional ];
        loop: bool option [@mel.optional ];
        low: int option [@mel.optional ];
        manifest: string option [@mel.optional ];
        markerEnd: string option [@mel.optional ];
        markerHeight: string option [@mel.optional ];
        markerMid: string option [@mel.optional ];
        markerStart: string option [@mel.optional ];
        markerUnits: string option [@mel.optional ];
        markerWidth: string option [@mel.optional ];
        mask: string option [@mel.optional ];
        maskContentUnits: string option [@mel.optional ];
        maskUnits: string option [@mel.optional ];
        mathematical: string option [@mel.optional ];
        max: string option [@mel.optional ];
        maxLength: int option [@mel.optional ];
        media: string option [@mel.optional ];
        mediaGroup: string option [@mel.optional ];
        min: int option [@mel.optional ];
        minLength: int option [@mel.optional ];
        mode: string option [@mel.optional ];
        multiple: bool option [@mel.optional ];
        muted: bool option [@mel.optional ];
        name: string option [@mel.optional ];
        nonce: string option [@mel.optional ];
        noValidate: bool option [@mel.optional ];
        numOctaves: string option [@mel.optional ];
        offset: string option [@mel.optional ];
        opacity: string option [@mel.optional ];
        open_: bool option [@mel.optional ];
        operator: string option [@mel.optional ];
        optimum: int option [@mel.optional ];
        order: string option [@mel.optional ];
        orient: string option [@mel.optional ];
        orientation: string option [@mel.optional ];
        origin: string option [@mel.optional ];
        overflow: string option [@mel.optional ];
        overflowX: string option [@mel.optional ];
        overflowY: string option [@mel.optional ];
        overlinePosition: string option [@mel.optional ];
        overlineThickness: string option [@mel.optional ];
        paintOrder: string option [@mel.optional ];
        panose1: string option [@mel.optional ];
        pathLength: string option [@mel.optional ];
        pattern: string option [@mel.optional ];
        patternContentUnits: string option [@mel.optional ];
        patternTransform: string option [@mel.optional ];
        patternUnits: string option [@mel.optional ];
        placeholder: string option [@mel.optional ];
        pointerEvents: string option [@mel.optional ];
        points: string option [@mel.optional ];
        pointsAtX: string option [@mel.optional ];
        pointsAtY: string option [@mel.optional ];
        pointsAtZ: string option [@mel.optional ];
        poster: string option [@mel.optional ];
        prefix: string option [@mel.optional ];
        preload: string option [@mel.optional ];
        preserveAlpha: string option [@mel.optional ];
        preserveAspectRatio: string option [@mel.optional ];
        primitiveUnits: string option [@mel.optional ];
        property: string option [@mel.optional ];
        r: string option [@mel.optional ];
        radioGroup: string option [@mel.optional ];
        radius: string option [@mel.optional ];
        readOnly: bool option [@mel.optional ];
        refX: string option [@mel.optional ];
        refY: string option [@mel.optional ];
        rel: string option [@mel.optional ];
        renderingIntent: string option [@mel.optional ];
        repeatCount: string option [@mel.optional ];
        repeatDur: string option [@mel.optional ];
        required: bool option [@mel.optional ];
        requiredExtensions: string option [@mel.optional ];
        requiredFeatures: string option [@mel.optional ];
        resource: string option [@mel.optional ];
        restart: string option [@mel.optional ];
        result: string option [@mel.optional ];
        reversed: bool option [@mel.optional ];
        role: string option [@mel.optional ];
        rotate: string option [@mel.optional ];
        rows: int option [@mel.optional ];
        rowSpan: int option [@mel.optional ];
        rx: string option [@mel.optional ];
        ry: string option [@mel.optional ];
        sandbox: string option [@mel.optional ];
        scale: string option [@mel.optional ];
        scope: string option [@mel.optional ];
        scoped: bool option [@mel.optional ];
        scrolling: string option [@mel.optional ];
        seed: string option [@mel.optional ];
        selected: bool option [@mel.optional ];
        shape: string option [@mel.optional ];
        shapeRendering: string option [@mel.optional ];
        size: int option [@mel.optional ];
        sizes: string option [@mel.optional ];
        slope: string option [@mel.optional ];
        spacing: string option [@mel.optional ];
        span: int option [@mel.optional ];
        specularConstant: string option [@mel.optional ];
        specularExponent: string option [@mel.optional ];
        speed: string option [@mel.optional ];
        spellCheck: bool option [@mel.optional ];
        spreadMethod: string option [@mel.optional ];
        src: string option [@mel.optional ];
        srcDoc: string option [@mel.optional ];
        srcLang: string option [@mel.optional ];
        srcSet: string option [@mel.optional ];
        start: int option [@mel.optional ];
        startOffset: string option [@mel.optional ];
        stdDeviation: string option [@mel.optional ];
        stemh: string option [@mel.optional ];
        stemv: string option [@mel.optional ];
        step: float option [@mel.optional ];
        stitchTiles: string option [@mel.optional ];
        stopColor: string option [@mel.optional ];
        stopOpacity: string option [@mel.optional ];
        strikethroughPosition: string option [@mel.optional ];
        strikethroughThickness: string option [@mel.optional ];
        stroke: string option [@mel.optional ];
        strokeDasharray: string option [@mel.optional ];
        strokeDashoffset: string option [@mel.optional ];
        strokeLinecap: string option [@mel.optional ];
        strokeLinejoin: string option [@mel.optional ];
        strokeMiterlimit: string option [@mel.optional ];
        strokeOpacity: string option [@mel.optional ];
        strokeWidth: string option [@mel.optional ];
        style: ReactDOM.Style.t option [@mel.optional ];
        summary: string option [@mel.optional ];
        suppressContentEditableWarning: bool option [@mel.optional ];
        surfaceScale: string option [@mel.optional ];
        systemLanguage: string option [@mel.optional ];
        tabIndex: int option [@mel.optional ];
        tableValues: string option [@mel.optional ];
        target: string option [@mel.optional ];
        targetX: string option [@mel.optional ];
        targetY: string option [@mel.optional ];
        textAnchor: string option [@mel.optional ];
        textDecoration: string option [@mel.optional ];
        textLength: string option [@mel.optional ];
        textRendering: string option [@mel.optional ];
        title: string option [@mel.optional ];
        to_: string option [@mel.optional ];
        transform: string option [@mel.optional ];
        type_: string option [@mel.optional ][@mel.as "type"];
        typeof: string option [@mel.optional ];
        u1: string option [@mel.optional ];
        u2: string option [@mel.optional ];
        underlinePosition: string option [@mel.optional ];
        underlineThickness: string option [@mel.optional ];
        unicode: string option [@mel.optional ];
        unicodeBidi: string option [@mel.optional ];
        unicodeRange: string option [@mel.optional ];
        unitsPerEm: string option [@mel.optional ];
        useMap: string option [@mel.optional ];
        vAlphabetic: string option [@mel.optional ];
        value: string option [@mel.optional ];
        values: string option [@mel.optional ];
        vectorEffect: string option [@mel.optional ];
        version: string option [@mel.optional ];
        vertAdvX: string option [@mel.optional ];
        vertAdvY: string option [@mel.optional ];
        vertOriginX: string option [@mel.optional ];
        vertOriginY: string option [@mel.optional ];
        vHanging: string option [@mel.optional ];
        vIdeographic: string option [@mel.optional ];
        viewBox: string option [@mel.optional ];
        viewTarget: string option [@mel.optional ];
        visibility: string option [@mel.optional ];
        vMathematical: string option [@mel.optional ];
        vocab: string option [@mel.optional ];
        width: string option [@mel.optional ];
        widths: string option [@mel.optional ];
        wordSpacing: string option [@mel.optional ];
        wrap: string option [@mel.optional ];
        writingMode: string option [@mel.optional ];
        x: string option [@mel.optional ];
        x1: string option [@mel.optional ];
        x2: string option [@mel.optional ];
        xChannelSelector: string option [@mel.optional ];
        xHeight: string option [@mel.optional ];
        xlinkActuate: string option [@mel.optional ];
        xlinkArcrole: string option [@mel.optional ];
        xlinkHref: string option [@mel.optional ];
        xlinkRole: string option [@mel.optional ];
        xlinkShow: string option [@mel.optional ];
        xlinkTitle: string option [@mel.optional ];
        xlinkType: string option [@mel.optional ];
        xmlBase: string option [@mel.optional ];
        xmlLang: string option [@mel.optional ];
        xmlns: string option [@mel.optional ];
        xmlnsXlink: string option [@mel.optional ];
        xmlSpace: string option [@mel.optional ];
        y: string option [@mel.optional ];
        y1: string option [@mel.optional ];
        y2: string option [@mel.optional ];
        yChannelSelector: string option [@mel.optional ];
        z: string option [@mel.optional ];
        zoomAndPan: string option [@mel.optional ];
        onAbort: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onAnimationEnd: (ReactEvent.Animation.t -> unit) option
          [@mel.optional ];
        onAnimationIteration: (ReactEvent.Animation.t -> unit) option
          [@mel.optional ];
        onAnimationStart: (ReactEvent.Animation.t -> unit) option
          [@mel.optional ];
        onBlur: (ReactEvent.Focus.t -> unit) option [@mel.optional ];
        onCanPlay: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onCanPlayThrough: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onChange: (ReactEvent.Form.t -> unit) option [@mel.optional ];
        onClick: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onCompositionEnd: (ReactEvent.Composition.t -> unit) option
          [@mel.optional ];
        onCompositionStart: (ReactEvent.Composition.t -> unit) option
          [@mel.optional ];
        onCompositionUpdate: (ReactEvent.Composition.t -> unit) option
          [@mel.optional ];
        onContextMenu: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onCopy: (ReactEvent.Clipboard.t -> unit) option [@mel.optional ];
        onCut: (ReactEvent.Clipboard.t -> unit) option [@mel.optional ];
        onDoubleClick: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onDrag: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onDragEnd: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onDragEnter: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onDragExit: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onDragLeave: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onDragOver: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onDragStart: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onDrop: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onDurationChange: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onEmptied: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onEncrypetd: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onEnded: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onError: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onFocus: (ReactEvent.Focus.t -> unit) option [@mel.optional ];
        onInput: (ReactEvent.Form.t -> unit) option [@mel.optional ];
        onKeyDown: (ReactEvent.Keyboard.t -> unit) option [@mel.optional ];
        onKeyPress: (ReactEvent.Keyboard.t -> unit) option [@mel.optional ];
        onKeyUp: (ReactEvent.Keyboard.t -> unit) option [@mel.optional ];
        onLoadedData: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onLoadedMetadata: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onLoadStart: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onMouseDown: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onMouseEnter: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onMouseLeave: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onMouseMove: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onMouseOut: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onMouseOver: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onMouseUp: (ReactEvent.Mouse.t -> unit) option [@mel.optional ];
        onPaste: (ReactEvent.Clipboard.t -> unit) option [@mel.optional ];
        onPause: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onPlay: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onPlaying: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onProgress: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onRateChange: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onScroll: (ReactEvent.UI.t -> unit) option [@mel.optional ];
        onSeeked: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onSeeking: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onSelect: (ReactEvent.Selection.t -> unit) option [@mel.optional ];
        onStalled: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onSubmit: (ReactEvent.Form.t -> unit) option [@mel.optional ];
        onSuspend: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onTimeUpdate: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onTouchCancel: (ReactEvent.Touch.t -> unit) option [@mel.optional ];
        onTouchEnd: (ReactEvent.Touch.t -> unit) option [@mel.optional ];
        onTouchMove: (ReactEvent.Touch.t -> unit) option [@mel.optional ];
        onTouchStart: (ReactEvent.Touch.t -> unit) option [@mel.optional ];
        onTransitionEnd: (ReactEvent.Transition.t -> unit) option
          [@mel.optional ];
        onVolumeChange: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onWaiting: (ReactEvent.Media.t -> unit) option [@mel.optional ];
        onWheel: (ReactEvent.Wheel.t -> unit) option [@mel.optional ];
        var: 'var }[@@bs.deriving abstract]
      external createVariadicElement :
        string -> < .. >  Js.t -> React.element = "createElement"[@@bs.module
                                                                   "react"]
      let deleteProp = [%raw "(newProps, key) => delete newProps[key]"]
      let getOrEmpty str =
        match str with
        | ((Some (str))[@explicit_arity ]) -> " " ^ str
        | None -> ""
      external assign2 :
        < .. >  Js.t -> < .. >  Js.t -> < .. >  Js.t -> < .. >  Js.t =
          "Object.assign"[@@bs.val ]
      let styles ~var:((var)[@ns.namedArgLoc ])  _ =
        CssJs.style
          [|(CssJs.label "ArrayDynamicComponent");(CssJs.display `block);((
            match var with
            | `Black -> CssJs.color (`hex {js|999999|js})
            | `White -> CssJs.color (`hex {js|FAFAFA|js})))|]
      let make (props : 'var makeProps) =
        let className =
          (styles ~var:(varGet props) ()) ^ (getOrEmpty (classNameGet props)) in
        let stylesObject = [%bs.obj { className; ref = (innerRefGet props) }] in
        let newProps = assign2 (Js.Obj.empty ()) (Obj.magic props) stylesObject in
        ignore ((deleteProp newProps "var")[@bs ]);
        ignore ((deleteProp newProps "innerRef")[@bs ]);
        createVariadicElement "div" newProps
    end
