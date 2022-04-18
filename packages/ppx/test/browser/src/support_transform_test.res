open Jest

let testData = list{
  (
    "translate",
    %cx("transform: translate(10px, 10px)"),
    CssJs.style(. [CssJs.transform(CssJs.translate(#pxFloat(10.), #pxFloat(10.)))]),
  ),
  (
    "translateX",
    %cx("transform: translateX(10px) rotate(10deg) translateY(5px)"),
    CssJs.style(. [CssJs.transforms([CssJs.translateX(#pxFloat(10.)), CssJs.rotate(#deg(10.)), CssJs.translateY(#pxFloat(5.))])]),
  ),
  (
    "matrix",
    %cx("transform: matrix(1.0, 2.0, 3.0, 4.0, 5.0, 6.0)"),
    CssJs.style(. [CssJs.unsafe("transform", "matrix(1.0, 2.0, 3.0, 4.0, 5.0, 6.0)")]),
  ),
  (
    "translate",
    %cx("transform: translate(12px, 50%)"),
    CssJs.style(. [CssJs.transform(CssJs.translate(#pxFloat(12.), #percent(50.)))]),
  ),
  (
    "translateX",
    %cx("transform: translateX(2em)"),
    CssJs.style(. [CssJs.transform(CssJs.translateX(#em(2.)))]),
  ),
  (
    "translateY",
    %cx("transform: translateY(3in)"),
    CssJs.style(. [CssJs.transform(CssJs.translateY(#inch(3.)))]),
  ),
  (
    "scale",
    %cx("transform: scale(2, 0.5)"),
    CssJs.style(. [CssJs.transform(CssJs.scale(2., 0.5))]),
  ),
  ("scaleX", %cx("transform: scaleX(2)"), CssJs.style(. [CssJs.unsafe("transform", "scaleX(2)")])),
  (
    "scaleY",
    %cx("transform: scaleY(0.5)"),
    CssJs.style(. [CssJs.transform(CssJs.scaleY(0.5))]),
  ),
  (
    "rotate",
    %cx("transform: rotate(0.5turn)"),
    CssJs.style(. [CssJs.transform(CssJs.rotate(#turn(0.5)))]),
  ),
  (
    "skew",
    %cx("transform: skew(30deg, 20deg)"),
    CssJs.style(. [CssJs.transform(CssJs.skew(#deg(30.), #deg(20.)))]),
  ),
  (
    "skewX",
    %cx("transform: skewX(30deg)"),
    CssJs.style(. [CssJs.transform(CssJs.skewX(#deg(30.)))]),
  ),
  (
    "skewY",
    %cx("transform: skewY(1.07rad)"),
    CssJs.style(. [CssJs.transform(CssJs.skewY(#rad(1.07)))]),
  ),
  (
    "matrix3d",
    %cx(
      "transform: matrix3d(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0)"
    ),
    CssJs.style(. [
      CssJs.unsafe(
        "transform",
        "matrix3d(1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0, 11.0, 12.0, 13.0, 14.0, 15.0, 16.0)",
      ),
    ]),
  ),
  (
    "translate3d",
    %cx("transform: translate3d(12px, 50%, 3em)"),
    CssJs.style(. [CssJs.transform(CssJs.translate3d(#pxFloat(12.), #percent(50.), #em(3.)))]),
  ),
  (
    "translateZ",
    %cx("transform: translateZ(2px)"),
    CssJs.style(. [CssJs.transform(CssJs.translateZ(#pxFloat(2.)))]),
  ),
  (
    "scale3d",
    %cx("transform: scale3d(2.5, 1.2, 0.3)"),
    CssJs.style(. [CssJs.transform(CssJs.scale3d(2.5, 1.2, 0.3))]),
  ),
  (
    "scaleZ",
    %cx("transform: scaleZ(0.3)"),
    CssJs.style(. [CssJs.transform(CssJs.scaleZ(0.3))]),
  ),
  (
    "rotate3d",
    %cx("transform: rotate3d(1, 2.0, 3.0, 10deg)"),
    CssJs.style(. [CssJs.transform(CssJs.rotate3d(1., 2., 3., #deg(10.)))]),
  ),
  (
    "rotateX",
    %cx("transform: rotateX(10deg)"),
    CssJs.style(. [CssJs.transform(CssJs.rotateX(#deg(10.)))]),
  ),
  (
    "rotateY",
    %cx("transform: rotateY(10deg)"),
    CssJs.style(. [CssJs.transform(CssJs.rotateY(#deg(10.)))]),
  ),
  (
    "rotateZ",
    %cx("transform: rotateZ(10deg)"),
    CssJs.style(. [CssJs.transform(CssJs.rotateZ(#deg(10.)))]),
  ),
  (
    "perspective",
    %cx("transform: perspective(17px)"),
    CssJs.style(. [CssJs.unsafe("transform", "perspective(17px)")]),
  ),
}

Belt.List.forEachWithIndex(testData, (index, (name, cssIn, emotionOut)) =>
  test(string_of_int(index) ++ (". Supports " ++ name), () =>
    Expect.expect(cssIn) |> Expect.toMatch(emotionOut)
  )
)
