  $ bsc -ppx "rewriter --jsx-version 4" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res 2> output.ml

  $ cat output.ml
  let width = {js|120px|js}
  let orientation = {js|landscape|js}
  module SelectorWithInterpolation =
    struct
      type props = JsxDOM.domProps
      external createVariadicElement :
        string -> < .. >  Js.t -> React.element = "createElement"[@@bs.val ]
      [@@bs.module (("react")[@reason.raw_literal ])]
      let getOrEmpty str =
        ((match str with
          | ((Some (str))[@explicit_arity ]) ->
              ((" ")[@reason.raw_literal " "]) ^ str
          | None -> (("")[@reason.raw_literal ""]))
        [@reason.preserve_braces ])
      let deleteProp =
        [%raw
          (("(newProps, key) => delete newProps[key]")
            [@reason.raw_literal "(newProps, key) => delete newProps[key]"])]
      external assign2 :
        < .. >  Js.t -> < .. >  Js.t -> < .. >  Js.t -> < .. >  Js.t =
          "Object.assign"[@@bs.val ]
      let styles =
        ((CssJs.style
            [|(CssJs.label "SelectorWithInterpolation");((CssJs.media
                                                            ((({*j|only screen and (min-width: |*j})
                                                               [@res.template ])
                                                               ^
                                                               (width ^
                                                                  (({*j|)|*j})
                                                                  [@res.template
                                                                    ])))
                                                            [|(CssJs.color
                                                                 CssJs.blue)|])
              [@bs ]);((CssJs.media
                          ((({*j|(min-width: 700px) and (orientation: |*j})
                             [@res.template ]) ^
                             (orientation ^ (({*j|)|*j})[@res.template ])))
                          [|(CssJs.display `none)|])
              [@bs ])|])
        [@bs ])
      let make (props : props) =
        let className = styles ^ (getOrEmpty props.className) in
        let stylesObject = [%bs.obj { className; ref = (props.ref) }] in
        let newProps = assign2 (Js.Obj.empty ()) (Obj.magic props) stylesObject in
        createVariadicElement (("div")[@reason.raw_literal "div"]) newProps
    end

No clue why bsc generates a invalid syntax, but it does. This removes this particual bit.
  $ sed -e 's/.I1//g' output.ml > fixed.ml

  $ rescript convert fixed.ml
  Error when converting fixed.ml
  File "", line 35, characters 44-49:
  Error: Invalid literal 700px
  




