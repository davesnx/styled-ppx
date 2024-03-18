module ArrayDynamicComponent = %styled.div(
  (~var) => [
    switch var {
    | #Black => %css("color: #999999")
    | #White => %css("color: #FAFAFA")
    },
    %css("display: block;"),
  ]
)
