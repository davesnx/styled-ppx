This test ensures the ppx generates the correct output against styled-ppx.native
If this test fail means that the module is not in sync with the ppx

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-139svzs { scroll-behavior: auto; }\n.css-15d85rl { scroll-behavior: smooth; }\n.css-1a3e3yu { overflow-anchor: none; }\n.css-1mdepa7 { overflow-anchor: auto; }\n.css-1v2k22b { -moz-appearance: textfield; }\n.css-10s0057 { -webkit-appearance: none; }\n.css-19t04z6 { -webkit-box-orient: vertical; }\n.css-1nb6mu1 { -webkit-box-shadow: inset 0 0 0 1000px var(--var-6wokt0); }\n.css-1oixppz { -webkit-line-clamp: 2; }\n.css-k7nrdm { -webkit-overflow-scrolling: touch; }\n.css-187cpsq { -webkit-tap-highlight-color: transparent; }\n.css-vzfu8m { -webkit-text-fill-color: var(--var-g5egjq); }\n.css-1jf3yek { animation: none; }\n.css-1mar6mu { appearance: none; }\n.css-ocpgxz { aspect-ratio: 21 / 8; }\n.css-1recb04 { background-color: var(--var-11dnnxw); }\n.css-beqw7r { border: none; }\n.css-17nmynu { border: 1px; }\n.css-178qy9p { border: thin; }\n.css-o55quo { border: 1px solid; }\n.css-mpundo { border: thin dashed; }\n.css-18htonh { border: 1px solid black; }\n.css-1oo6j5i { border: thin dashed red; }\n.css-dugx5i { border: 2px dotted #333; }\n.css-5nhsqd { border: medium double blue; }\n.css-kqdeyl { bottom: unset; }\n.css-zic50l { box-shadow: none; }\n.css-109tu3w { break-inside: avoid; }\n.css-1qxycq6 { caret-color: #e15a46; }\n.css-1cxetvo { color: inherit; }\n.css-15qqr9c { color: var(--color-link); }\n.css-1ggvxgj { column-width: 125px; }\n.css-1iro2cm { column-width: auto; }\n.css-1y76s6a { counter-increment: ol; }\n.css-1q8xwve { counter-reset: ol; }\n.css-12oywv3 { display: -webkit-box; }\n.css-vjtp0 { display: contents; }\n.css-1fbxxu3 { display: table; }\n.css-1y508fb { fill: var(--var-11dnnxw); }\n.css-1aj0fbz { fill: currentColor; }\n.css-8j7fl0 { gap: 4px; }\n.css-13874aw { grid-column-end: span 2; }\n.css-15a21l7 { grid-column: unset; }\n.css-1v5hebf { grid-row: unset; }\n.css-17cc6rg { grid-template-columns: max-content max-content; }\n.css-10g80zc { grid-template-columns: repeat(2, auto); }\n.css-1exaw09 { grid-template-columns: repeat(3, auto); }\n.css-sf3f9p { height: fit-content; }\n.css-1yy5rgv { justify-items: start; }\n.css-eztnof { justify-self: unset; }\n.css-1r2eksx { left: unset; }\n.css-1irc2jm { mask-image: var(--var-1few37s); }\n.css-egl27m { mask-position: center center; }\n.css-13odl3r { mask-repeat: no-repeat; }\n.css-c745rk { max-width: max-content; }\n.css-csewbn { outline: none; }\n.css-knzj8t { position: unset; }\n.css-16azont { resize: none; }\n.css-zlyoyc { right: calc(50% - 4px); }\n.css-m43xbo { stroke-opacity: 0; }\n.css-al3chi { stroke: var(--var-16dsc2j); }\n.css-rzi3gd { top: calc(50% - 1px); }\n.css-14w7snj { top: unset; }\n.css-2n5rpj { touch-action: none; }\n.css-14sq7ic { touch-action: pan-x pan-y; }\n.css-19o4pvv { transform-origin: center bottom; }\n.css-1n927uc { transform-origin: center left; }\n.css-1drb62g { transform-origin: center right; }\n.css-74jqay { transform-origin: 2px; }\n.css-oq4gt6 { transform-origin: bottom; }\n.css-978kwi { transform-origin: 3cm 2px; }\n.css-w0ozjw { transform-origin: left 2px; }\n.css-j5aa7t { transform-origin: center top; }\n.css-rvgufc { transform: none; }\n.css-sa49tb { width: fit-content; }\n.css-1u0t4vi { width: max-content; }\n.css-1m262uw { transition-delay: 240ms; }\n.css-1oua3dm { animation-duration: 150ms; }\n.css-1oxbpfs { border-width: thin; }\n.css-x6ip4b { outline-width: medium; }\n.css-1vic8xz { outline: medium solid red; }\n.css-rqkro3 { overflow: var(--var-414vlv); }\n.css-e8c2i8 { overflow: hidden; }\n.css-14sj983 { overflow-y: var(--var-414vlv); }\n.css-c01ve6 { overflow-x: hidden; }\n.css-16ut36 { overflow-block: hidden; }\n.css-1e13asw { overflow-block: var(--var-7wrrwo); }\n.css-f33fte { overflow-inline: var(--var-7wrrwo); }\n"
  ];
  CSS.make("css-139svzs", []);
  CSS.make("css-15d85rl", []);
  
  CSS.make("css-1a3e3yu", []);
  CSS.make("css-1mdepa7", []);
  
  CSS.make("css-1v2k22b", []);
  CSS.make("css-10s0057", []);
  CSS.make("css-19t04z6", []);
  
  module Color = {
    let text = CSS.hex("444");
    let background = CSS.hex("333");
  };
  let backgroundString = Color.background |> CSS.Types.Color.toString;
  let colorTextString = Color.text |> CSS.Types.Color.toString;
  
  CSS.make(
    "css-1nb6mu1",
    [("--var-6wokt0", CSS.Types.BoxShadow.toString(backgroundString))],
  );
  CSS.make("css-1oixppz", []);
  CSS.make("css-k7nrdm", []);
  CSS.make("css-187cpsq", []);
  CSS.make(
    "css-vzfu8m",
    [
      ("--var-g5egjq", CSS.Types.WebkitTextFillColor.toString(colorTextString)),
    ],
  );
  CSS.make("css-1jf3yek", []);
  CSS.make("css-1mar6mu", []);
  CSS.make("css-ocpgxz", []);
  
  let c = CSS.hex("e15a46");
  CSS.make("css-1recb04", [("--var-11dnnxw", CSS.Types.Color.toString(c))]);
  
  CSS.make("css-beqw7r", []);
  
  CSS.make("css-17nmynu", []);
  CSS.make("css-178qy9p", []);
  
  CSS.make("css-o55quo", []);
  CSS.make("css-mpundo", []);
  
  CSS.make("css-18htonh", []);
  CSS.make("css-1oo6j5i", []);
  CSS.make("css-dugx5i", []);
  CSS.make("css-5nhsqd", []);
  CSS.make("css-kqdeyl", []);
  CSS.make("css-zic50l", []);
  CSS.make("css-109tu3w", []);
  CSS.make("css-1qxycq6", []);
  CSS.make("css-1cxetvo", []);
  CSS.make("css-15qqr9c", []);
  CSS.make("css-1ggvxgj", []);
  CSS.make("css-1iro2cm", []);
  CSS.make("css-1y76s6a", []);
  CSS.make("css-1q8xwve", []);
  CSS.make("css-12oywv3", []);
  CSS.make("css-vjtp0", []);
  CSS.make("css-1fbxxu3", []);
  CSS.make("css-1y508fb", [("--var-11dnnxw", CSS.Types.Paint.toString(c))]);
  CSS.make("css-1aj0fbz", []);
  CSS.make("css-8j7fl0", []);
  CSS.make("css-13874aw", []);
  CSS.make("css-15a21l7", []);
  CSS.make("css-1v5hebf", []);
  CSS.make("css-17cc6rg", []);
  CSS.gridTemplateColumns(
    `tracks([|
      `minmax((`pxFloat(10.), `auto)),
      `fitContent(`pxFloat(20.)),
      `fitContent(`pxFloat(20.)),
    |]),
  );
  CSS.gridTemplateColumns(
    `tracks([|
      `minmax((`pxFloat(51.), `auto)),
      `fitContent(`pxFloat(20.)),
      `fitContent(`pxFloat(20.)),
    |]),
  );
  CSS.make("css-10g80zc", []);
  CSS.make("css-1exaw09", []);
  CSS.make("css-sf3f9p", []);
  CSS.make("css-1yy5rgv", []);
  CSS.make("css-eztnof", []);
  CSS.make("css-1r2eksx", []);
  let maskedImageUrl = `url("https://www.example.com/eye-uncrossed.svg");
  CSS.make(
    "css-1irc2jm",
    [("--var-1few37s", CSS.Types.MaskImage.toString(maskedImageUrl))],
  );
  CSS.make("css-egl27m", []);
  CSS.make("css-13odl3r", []);
  CSS.make("css-c745rk", []);
  CSS.make("css-csewbn", []);
  CSS.make("css-1a3e3yu", []);
  CSS.make("css-knzj8t", []);
  CSS.make("css-16azont", []);
  CSS.make("css-zlyoyc", []);
  CSS.make("css-15d85rl", []);
  CSS.make("css-m43xbo", []);
  CSS.make(
    "css-al3chi",
    [("--var-16dsc2j", CSS.Types.Paint.toString(Color.text))],
  );
  CSS.make("css-rzi3gd", []);
  CSS.make("css-14w7snj", []);
  CSS.make("css-2n5rpj", []);
  CSS.make("css-14sq7ic", []);
  CSS.make("css-19o4pvv", []);
  CSS.make("css-1n927uc", []);
  CSS.make("css-1drb62g", []);
  CSS.make("css-74jqay", []);
  CSS.make("css-oq4gt6", []);
  CSS.make("css-978kwi", []);
  CSS.make("css-w0ozjw", []);
  CSS.make("css-j5aa7t", []);
  CSS.make("css-rvgufc", []);
  
  CSS.make("css-sa49tb", []);
  CSS.make("css-1u0t4vi", []);
  
  CSS.make("css-1m262uw", []);
  CSS.make("css-1oua3dm", []);
  
  CSS.make("css-1oxbpfs", []);
  CSS.make("css-x6ip4b", []);
  CSS.make("css-1vic8xz", []);
  
  let lola = `hidden;
  CSS.make(
    "css-rqkro3",
    [("--var-414vlv", CSS.Types.Overflow.toString(lola))],
  );
  CSS.make("css-e8c2i8", []);
  CSS.make(
    "css-14sj983",
    [("--var-414vlv", CSS.Types.OverflowY.toString(lola))],
  );
  CSS.make("css-c01ve6", []);
  
  let value = `clip;
  CSS.make("css-16ut36", []);
  CSS.make(
    "css-1e13asw",
    [("--var-7wrrwo", CSS.Types.OverflowBlock.toString(value))],
  );
  CSS.make(
    "css-f33fte",
    [("--var-7wrrwo", CSS.Types.OverflowInline.toString(value))],
  );
  
  CSS.style([|
    CSS.backgroundImage(
      `linearGradient((
        Some(`deg(84.)),
        [|
          (Some(`hex({js|F80|js})), Some(`percent(0.))),
          (Some(`rgba((255, 255, 255, `num(0.8)))), Some(`percent(50.))),
          (Some(`hex({js|2A97FF|js})), Some(`percent(100.))),
        |]: CSS.Types.Gradient.color_stop_list,
      )),
    ),
  |]);
  
  CSS.style([|CSS.aspectRatio(`ratio((16, 9)))|]);
  
  CSS.make("css-15qqr9c", []);
  
  let interpolation = `px(10);
  CSS.style([|CSS.right(interpolation), CSS.bottom(interpolation)|]);

  $ dune build
  File "input.re", line 20, characters 6-69:
  20 | [%cx2 {|-webkit-box-shadow: inset 0 0 0 1000px $(backgroundString);|}];
             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  Error: This expression has type string but an expression was expected of type
           Css_types.BoxShadow.t
  [1]
