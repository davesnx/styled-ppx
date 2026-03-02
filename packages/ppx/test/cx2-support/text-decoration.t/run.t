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

  $ dune build

  $ dune describe pp ./input.re | sed '1,/^];$/d'
  [@css
    ".css-1hstiaf{text-decoration-line:none;}\n.css-h5jo7l{text-decoration-line:underline;}\n.css-ai7jjn{text-decoration-line:overline;}\n.css-c3aj5y{text-decoration-line:line-through;}\n.css-b04p93{text-decoration-line:underline overline;}\n.css-volvj2{text-decoration-color:white;}\n.css-17nde1x{text-decoration-style:solid;}\n.css-i63bb0{text-decoration-style:double;}\n.css-gzu23a{text-decoration-style:dotted;}\n.css-11w89xg{text-decoration-style:dashed;}\n.css-zebza7{text-decoration-style:wavy;}\n.css-fr7kvy{text-underline-position:auto;}\n.css-fjhfys{text-underline-position:under;}\n.css-ns2wu2{text-underline-position:left;}\n.css-1hhdp26{text-underline-position:right;}\n.css-1mis52a{text-underline-position:under left;}\n.css-7in9dq{text-underline-position:under right;}\n.css-oviqil{text-emphasis-style:none;}\n.css-1kyj2pl{text-emphasis-style:filled;}\n.css-dlg7ob{text-emphasis-style:open;}\n.css-1kyeeq5{text-emphasis-style:dot;}\n.css-rg2qxn{text-emphasis-style:circle;}\n.css-8rnz0y{text-emphasis-style:double-circle;}\n.css-1funiuc{text-emphasis-style:triangle;}\n.css-9243n{text-emphasis-style:sesame;}\n.css-1wr3653{text-emphasis-style:open dot;}\n.css-uii345{text-emphasis-style:\"foo\";}\n.css-1ps7yre{text-emphasis-color:green;}\n.css-1gm1xtr{text-emphasis:open dot green;}\n.css-1r11nl6{text-emphasis-position:over;}\n.css-x7dg2o{text-emphasis-position:under;}\n.css-ohd4dg{text-emphasis-position:over left;}\n.css-15nsz24{text-emphasis-position:over right;}\n.css-eywejo{text-emphasis-position:under left;}\n.css-e1ux8j{text-emphasis-position:left under;}\n.css-9is7qc{text-emphasis-position:under right;}\n.css-1f9ql9z{text-shadow:none;}\n.css-18sychj{text-shadow:1px 1px;}\n.css-sho2mi{text-shadow:0 0 black;}\n.css-14uqa7n{text-shadow:1px 2px 3px;}\n.css-qlj1j4{text-shadow:1px 2px 3px black;}\n.css-180bx5y{text-shadow:1px 1px, 2px 2px red;}\n.css-jw7zpt{text-shadow:1px 2px 3px black, 0 0 5px white;}\n.css-83xjle{text-decoration-skip:none;}\n.css-h2hh35{text-decoration-skip:objects;}\n.css-uql9gi{text-decoration-skip:objects spaces;}\n.css-k2jofb{text-decoration-skip:objects leading-spaces;}\n.css-1ya5tpa{text-decoration-skip:objects trailing-spaces;}\n.css-1itl3dj{text-decoration-skip:objects leading-spaces trailing-spaces;}\n.css-1j6wwzb{text-decoration-skip:objects leading-spaces trailing-spaces edges;}\n.css-81j747{text-decoration-skip:objects leading-spaces trailing-spaces edges box-decoration;}\n.css-jdqqvz{text-decoration-skip:objects edges;}\n.css-163jnz3{text-decoration-skip:objects box-decoration;}\n.css-dpnj6l{text-decoration-skip:spaces;}\n.css-1kylxfd{text-decoration-skip:spaces edges;}\n.css-vkealr{text-decoration-skip:spaces edges box-decoration;}\n.css-1549jre{text-decoration-skip:spaces box-decoration;}\n.css-dtf8ym{text-decoration-skip:leading-spaces;}\n.css-18cupg8{text-decoration-skip:leading-spaces trailing-spaces edges;}\n.css-1cyty82{text-decoration-skip:edges;}\n.css-r6xscz{text-decoration-skip:edges box-decoration;}\n.css-1xkedkd{text-decoration-skip:box-decoration;}\n.css-1ctq7y7{text-decoration-skip-ink:none;}\n.css-1191soe{text-decoration-skip-ink:auto;}\n.css-1eh2f09{text-decoration-skip-ink:all;}\n.css-113fdf1{text-decoration-skip-box:none;}\n.css-1o4djmk{text-decoration-skip-box:all;}\n.css-pp3yi9{text-decoration-skip-inset:none;}\n.css-jl0g23{text-decoration-skip-inset:auto;}\n.css-1s8jicj{text-underline-offset:auto;}\n.css-1kxlgvj{text-underline-offset:3px;}\n.css-len22j{text-underline-offset:10%;}\n.css-hjssta{text-decoration-thickness:auto;}\n.css-1vyyh8i{text-decoration-thickness:from-font;}\n.css-1f5jw5c{text-decoration-thickness:3px;}\n.css-1novgf0{text-decoration-thickness:10%;}\n"
  ];
  
  CSS.make("css-1hstiaf", []);
  CSS.make("css-h5jo7l", []);
  CSS.make("css-ai7jjn", []);
  CSS.make("css-c3aj5y", []);
  CSS.make("css-b04p93", []);
  CSS.make("css-volvj2", []);
  CSS.make("css-17nde1x", []);
  CSS.make("css-i63bb0", []);
  CSS.make("css-gzu23a", []);
  CSS.make("css-11w89xg", []);
  CSS.make("css-zebza7", []);
  CSS.make("css-fr7kvy", []);
  CSS.make("css-fjhfys", []);
  CSS.make("css-ns2wu2", []);
  CSS.make("css-1hhdp26", []);
  CSS.make("css-1mis52a", []);
  CSS.make("css-7in9dq", []);
  CSS.make("css-oviqil", []);
  CSS.make("css-1kyj2pl", []);
  CSS.make("css-dlg7ob", []);
  CSS.make("css-1kyeeq5", []);
  CSS.make("css-rg2qxn", []);
  CSS.make("css-8rnz0y", []);
  CSS.make("css-1funiuc", []);
  CSS.make("css-9243n", []);
  CSS.make("css-1wr3653", []);
  CSS.make("css-uii345", []);
  CSS.make("css-1ps7yre", []);
  CSS.make("css-1gm1xtr", []);
  
  CSS.make("css-1r11nl6", []);
  CSS.make("css-x7dg2o", []);
  CSS.make("css-ohd4dg", []);
  CSS.make("css-15nsz24", []);
  CSS.make("css-eywejo", []);
  CSS.make("css-e1ux8j", []);
  CSS.make("css-9is7qc", []);
  
  CSS.make("css-1f9ql9z", []);
  
  CSS.make("css-18sychj", []);
  
  CSS.make("css-sho2mi", []);
  
  CSS.make("css-14uqa7n", []);
  
  CSS.make("css-qlj1j4", []);
  
  CSS.make("css-180bx5y", []);
  CSS.make("css-jw7zpt", []);
  
  CSS.make("css-83xjle", []);
  CSS.make("css-h2hh35", []);
  CSS.make("css-uql9gi", []);
  CSS.make("css-k2jofb", []);
  CSS.make("css-1ya5tpa", []);
  CSS.make("css-1itl3dj", []);
  CSS.make("css-1j6wwzb", []);
  CSS.make("css-81j747", []);
  CSS.make("css-jdqqvz", []);
  CSS.make("css-163jnz3", []);
  CSS.make("css-dpnj6l", []);
  CSS.make("css-1kylxfd", []);
  CSS.make("css-vkealr", []);
  CSS.make("css-1549jre", []);
  CSS.make("css-dtf8ym", []);
  CSS.make("css-18cupg8", []);
  CSS.unsafe(
    {js|textDecorationSkip|js},
    {js|leading-spaces trailing-spaces edges box-decoration|js},
  );
  CSS.make("css-1cyty82", []);
  CSS.make("css-r6xscz", []);
  CSS.make("css-1xkedkd", []);
  CSS.make("css-1ctq7y7", []);
  CSS.make("css-1191soe", []);
  CSS.make("css-1eh2f09", []);
  CSS.make("css-113fdf1", []);
  CSS.make("css-1o4djmk", []);
  CSS.make("css-pp3yi9", []);
  CSS.make("css-jl0g23", []);
  CSS.make("css-1s8jicj", []);
  CSS.make("css-1kxlgvj", []);
  CSS.make("css-len22j", []);
  CSS.make("css-hjssta", []);
  CSS.make("css-1vyyh8i", []);
  CSS.make("css-1f5jw5c", []);
  CSS.make("css-1novgf0", []);
