  $ npx bsc -ppx "rewriter" -only-parse -bs-ast -bs-jsx 4 -bs-loc -bs-diagnose -bs-no-version-header -bs-ml-out -bs-no-builtin-ppx -bs-super-errors -color never -dsource input.res
  ;;ignore
      (CSS.global
         [|(CSS.selectorMany [|(({*j|html|*j})[@res.template ])|]
              [|(CSS.lineHeight (`abs 1.15));(CSS.unsafe {*j|textSizeAdjust|*j}
                                                {js|100%|js})|]);(CSS.selectorMany
                                                                    [|(({*j|body|*j})
                                                                      [@res.template
                                                                      ])|]
                                                                    [|(
                                                                      CSS.margin
                                                                      `zero)|]);(
           CSS.selectorMany [|(({*j|main|*j})[@res.template ])|]
             [|(CSS.display `block)|]);(CSS.selectorMany
                                          [|(({*j|h1|*j})[@res.template ])|]
                                          [|(CSS.fontSize (`em 2.));(CSS.margin2
                                                                      ~v:(
                                                                      `em 0.67)
                                                                      ~h:`zero)|]);(
           CSS.selectorMany [|(({*j|hr|*j})[@res.template ])|]
             [|(CSS.boxSizing `contentBox);(CSS.height `zero);(CSS.overflow
                                                                 `visible)|]);(
           CSS.selectorMany [|(({*j|pre|*j})[@res.template ])|]
             [|(CSS.fontFamilies [|`monospace;`monospace|]);(CSS.fontSize
                                                               (`em 1.))|]);(
           CSS.selectorMany [|(({*j|a|*j})[@res.template ])|]
             [|(CSS.backgroundColor `transparent)|]);(CSS.selectorMany
                                                        [|(({*j|abbr[title]|*j})
                                                          [@res.template ])|]
                                                        [|(CSS.unsafe
                                                             {js|borderBottom|js}
                                                             {js|none|js});(
                                                          CSS.textDecorations
                                                            ?line:((Some
                                                                      ((CSS.Types.TextDecorationLine.Value.make
                                                                      ?underline:((
                                                                      Some
                                                                      (true))
                                                                      [@explicit_arity
                                                                      ])
                                                                      ?overline:None
                                                                      ?lineThrough:None
                                                                      ?blink:None
                                                                      ())))
                                                            [@explicit_arity ])
                                                            ?thickness:None
                                                            ?style:None
                                                            ?color:None ());(
                                                          CSS.textDecorations
                                                            ?line:((Some
                                                                      ((CSS.Types.TextDecorationLine.Value.make
                                                                      ?underline:((
                                                                      Some
                                                                      (true))
                                                                      [@explicit_arity
                                                                      ])
                                                                      ?overline:None
                                                                      ?lineThrough:None
                                                                      ?blink:None
                                                                      ())))
                                                            [@explicit_arity ])
                                                            ?thickness:None
                                                            ?style:((Some
                                                                      (`dotted))
                                                            [@explicit_arity ])
                                                            ?color:None ())|]);(
           CSS.selectorMany
             [|(({*j|b|*j})[@res.template ]);(({*j|strong|*j})
               [@res.template ])|] [|(CSS.fontWeight `bolder)|]);(CSS.selectorMany
                                                                    [|(({*j|code|*j})
                                                                      [@res.template
                                                                      ]);(({*j|kbd|*j})
                                                                      [@res.template
                                                                      ]);(({*j|samp|*j})
                                                                      [@res.template
                                                                      ])|]
                                                                    [|(
                                                                      CSS.fontFamilies
                                                                      [|`monospace;`monospace|]);(
                                                                      CSS.fontSize
                                                                      (`em 1.))|]);(
           CSS.selectorMany [|(({*j|small|*j})[@res.template ])|]
             [|(CSS.fontSize (`percent 80.))|]);(CSS.selectorMany
                                                   [|(({*j|sub|*j})
                                                     [@res.template ]);(({*j|sup|*j})
                                                     [@res.template ])|]
                                                   [|(CSS.fontSize
                                                        (`percent 75.));(
                                                     CSS.lineHeight `zero);(
                                                     CSS.unsafe
                                                       {*j|position|*j}
                                                       {js|relative|js});(
                                                     CSS.verticalAlign
                                                       `baseline)|]);(CSS.selectorMany
                                                                      [|(({*j|sub|*j})
                                                                      [@res.template
                                                                      ])|]
                                                                      [|(
                                                                      CSS.bottom
                                                                      (`em
                                                                      (-0.25)))|]);(
           CSS.selectorMany [|(({*j|sup|*j})[@res.template ])|]
             [|(CSS.top (`em (-0.5)))|]);(CSS.selectorMany
                                            [|(({*j|img|*j})[@res.template ])|]
                                            [|(CSS.borderStyle `none)|]);(
           CSS.selectorMany
             [|(({*j|button|*j})[@res.template ]);(({*j|input|*j})
               [@res.template ]);(({*j|optgroup|*j})
               [@res.template ]);(({*j|select|*j})
               [@res.template ]);(({*j|textarea|*j})[@res.template ])|]
             [|(CSS.unsafe {*j|fontFamily|*j} {*j|inherit|*j});(CSS.fontSize
                                                                  (`percent
                                                                     100.));(
               CSS.lineHeight (`abs 1.15));(CSS.margin `zero)|]);(CSS.selectorMany
                                                                    [|(({*j|button|*j})
                                                                      [@res.template
                                                                      ]);(({*j|input|*j})
                                                                      [@res.template
                                                                      ])|]
                                                                    [|(
                                                                      CSS.overflow
                                                                      `visible)|]);(
           CSS.selectorMany
             [|(({*j|button|*j})[@res.template ]);(({*j|select|*j})
               [@res.template ])|] [|(CSS.textTransform `none)|]);(CSS.selectorMany
                                                                     [|(({*j|button|*j})
                                                                      [@res.template
                                                                      ]);(({*j|[type="button"]|*j})
                                                                      [@res.template
                                                                      ]);(({*j|[type="reset"]|*j})
                                                                      [@res.template
                                                                      ]);(({*j|[type="submit"]|*j})
                                                                      [@res.template
                                                                      ])|]
                                                                     [|(
                                                                      CSS.unsafe
                                                                      {*j|WebkitAppearance|*j}
                                                                      {js|button|js})|]);(
           CSS.selectorMany
             [|(({*j|button::-moz-focus-inner|*j})
               [@res.template ]);(({*j|[type="button"]::-moz-focus-inner|*j})
               [@res.template ]);(({*j|[type="reset"]::-moz-focus-inner|*j})
               [@res.template ]);(({*j|[type="submit"]::-moz-focus-inner|*j})
               [@res.template ])|]
             [|(CSS.borderStyle `none);(CSS.padding `zero)|]);(CSS.selectorMany
                                                                 [|(({*j|button:-moz-focusring|*j})
                                                                   [@res.template
                                                                     ]);(({*j|[type="button"]:-moz-focusring|*j})
                                                                   [@res.template
                                                                     ]);(({*j|[type="reset"]:-moz-focusring|*j})
                                                                   [@res.template
                                                                     ]);(({*j|[type="submit"]:-moz-focusring|*j})
                                                                   [@res.template
                                                                     ])|]
                                                                 [|(CSS.unsafe
                                                                      {*j|outline|*j}
                                                                      {js|1px dotted ButtonText|js})|]);(
           CSS.selectorMany [|(({*j|fieldset|*j})[@res.template ])|]
             [|(CSS.padding3 ~top:(`em 0.35) ~h:(`em 0.75) ~bottom:(`em 0.625))|]);(
           CSS.selectorMany [|(({*j|legend|*j})[@res.template ])|]
             [|(CSS.boxSizing `borderBox);(CSS.unsafe {*j|color|*j}
                                             {*j|inherit|*j});(CSS.display
                                                                 `table);(
               CSS.maxWidth (`percent 100.));(CSS.padding `zero);(CSS.whiteSpace
                                                                    `normal)|]);(
           CSS.selectorMany [|(({*j|progress|*j})[@res.template ])|]
             [|(CSS.verticalAlign `baseline)|]);(CSS.selectorMany
                                                   [|(({*j|textarea|*j})
                                                     [@res.template ])|]
                                                   [|(CSS.overflow `auto)|]);(
           CSS.selectorMany
             [|(({*j|[type="checkbox"]|*j})
               [@res.template ]);(({*j|[type="radio"]|*j})[@res.template ])|]
             [|(CSS.boxSizing `borderBox);(CSS.padding `zero)|]);(CSS.selectorMany
                                                                    [|(({*j|[type="number"]::-webkit-inner-spin-button|*j})
                                                                      [@res.template
                                                                      ]);(({*j|[type="number"]::-webkit-outer-spin-button|*j})
                                                                      [@res.template
                                                                      ])|]
                                                                    [|(
                                                                      CSS.height
                                                                      `auto)|]);(
           CSS.selectorMany [|(({*j|[type="search"]|*j})[@res.template ])|]
             [|(CSS.unsafe {*j|WebkitAppearance|*j} {js|textfield|js});(
               CSS.outlineOffset (`pxFloat (-2.)))|]);(CSS.selectorMany
                                                         [|(({*j|[type="search"]::-webkit-search-decoration|*j})
                                                           [@res.template ])|]
                                                         [|(CSS.unsafe
                                                              {*j|WebkitAppearance|*j}
                                                              {js|none|js})|]);(
           CSS.selectorMany
             [|(({*j|::-webkit-file-upload-button|*j})[@res.template ])|]
             [|(CSS.unsafe {*j|WebkitAppearance|*j} {js|button|js});(CSS.unsafe
                                                                      {*j|font|*j}
                                                                      {*j|inherit|*j})|]);(
           CSS.selectorMany [|(({*j|details|*j})[@res.template ])|]
             [|(CSS.display `block)|]);(CSS.selectorMany
                                          [|(({*j|summary|*j})
                                            [@res.template ])|]
                                          [|(CSS.display `listItem)|]);(
           CSS.selectorMany [|(({*j|template|*j})[@res.template ])|]
             [|(CSS.display `none)|]);(CSS.selectorMany
                                         [|(({*j|[hidden]|*j})
                                           [@res.template ])|]
                                         [|(CSS.display `none)|])|])

Since OCaml syntax doesn't support *j in strings. We replace them to make the test pass
  $ sed -e 's/*j/js/g' output.ml > fixed.ml
  sed: output.ml: No such file or directory
  [1]

  $ npx rescript convert fixed.ml
