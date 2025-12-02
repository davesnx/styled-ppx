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
    ".css-ln465o { scroll-margin: 0px; }\n.css-17ynssh { scroll-margin: 6px 5px; }\n.css-12rw5gj { scroll-margin: 10px 20px 30px; }\n.css-9kl9s8 { scroll-margin: 10px 20px 30px 40px; }\n.css-1v3vu9e { scroll-margin: 20px 3em 1in 5rem; }\n.css-1gi8cz8 { scroll-margin: calc(2px); }\n.css-1frylul { scroll-margin: calc(3 * 25px); }\n.css-ft6tpu { scroll-margin: calc(3 * 25px) 5px 10em calc(1vw - 5px); }\n.css-y44050 { scroll-margin-block: 10px; }\n.css-isuzxh { scroll-margin-block: 10px 10px; }\n.css-17q6loy { scroll-margin-block-end: 10px; }\n.css-1s02mon { scroll-margin-block-start: 10px; }\n.css-1slismy { scroll-margin-bottom: 10px; }\n.css-okw7db { scroll-margin-inline: 10px; }\n.css-nwk411 { scroll-margin-inline: 10px 10px; }\n.css-fawqh3 { scroll-margin-inline-start: 10px; }\n.css-18217s3 { scroll-margin-inline-end: 10px; }\n.css-1wdbulw { scroll-margin-left: 10px; }\n.css-t5p016 { scroll-margin-right: 10px; }\n.css-5l8qqt { scroll-margin-top: 10px; }\n.css-1x4lgbf { scroll-padding: auto; }\n.css-1b6v1ys { scroll-padding: 0px; }\n.css-1djzdfs { scroll-padding: 6px 5px; }\n.css-1q93mrv { scroll-padding: 10px 20px 30px; }\n.css-1i1cpka { scroll-padding: 10px 20px 30px 40px; }\n.css-1g0xokg { scroll-padding: 10px auto 30px auto; }\n.css-n5xvjn { scroll-padding: 10%; }\n.css-dfcyrz { scroll-padding: 20% 3em 1in 5rem; }\n.css-122c787 { scroll-padding: calc(2px); }\n.css-1ha46zn { scroll-padding: calc(50%); }\n.css-zhhsa1 { scroll-padding: calc(3 * 25px); }\n.css-kmsxxn { scroll-padding: calc(3 * 25px) 5px 10% calc(10% - 5px); }\n.css-13x390v { scroll-padding-block: 10px; }\n.css-da6ki1 { scroll-padding-block: 50%; }\n.css-13zeit1 { scroll-padding-block: 10px 50%; }\n.css-55x98a { scroll-padding-block: 50% 50%; }\n.css-1xkixqy { scroll-padding-block-end: 10px; }\n.css-1prc3dg { scroll-padding-block-end: 50%; }\n.css-8a6gy7 { scroll-padding-block-start: 10px; }\n.css-1nozixy { scroll-padding-block-start: 50%; }\n.css-17vwe1r { scroll-padding-bottom: 10px; }\n.css-1aw6fx7 { scroll-padding-bottom: 50%; }\n.css-ekdwh5 { scroll-padding-inline: 10px; }\n.css-1ks0wr3 { scroll-padding-inline: 50%; }\n.css-1imdvtu { scroll-padding-inline: 10px 50%; }\n.css-34wm85 { scroll-padding-inline: 50% 50%; }\n.css-jazrbb { scroll-padding-inline-end: 10px; }\n.css-18a4c8j { scroll-padding-inline-end: 50%; }\n.css-fgo1nk { scroll-padding-inline-start: 10px; }\n.css-hh1jmk { scroll-padding-inline-start: 50%; }\n.css-17pw4k2 { scroll-padding-left: 10px; }\n.css-11l9lap { scroll-padding-left: 50%; }\n.css-3pe157 { scroll-padding-right: 10px; }\n.css-198bvio { scroll-padding-right: 50%; }\n.css-4104ud { scroll-padding-top: 10px; }\n.css-1b2737x { scroll-padding-top: 50%; }\n.css-wtggxx { scroll-snap-align: none; }\n.css-12m90qi { scroll-snap-align: start; }\n.css-zr2z71 { scroll-snap-align: end; }\n.css-1uh8i43 { scroll-snap-align: center; }\n.css-a5xln { scroll-snap-align: none start; }\n.css-13ei02w { scroll-snap-align: end center; }\n.css-1p532sc { scroll-snap-align: center start; }\n.css-xxuuah { scroll-snap-align: end none; }\n.css-1qr0g4w { scroll-snap-align: center center; }\n.css-1dinkp8 { scroll-snap-stop: normal; }\n.css-k3a5r { scroll-snap-stop: always; }\n.css-i4oy7a { scroll-snap-type: none; }\n.css-vzpnnm { scroll-snap-type: x mandatory; }\n.css-r3kugg { scroll-snap-type: y mandatory; }\n.css-em7yjq { scroll-snap-type: block mandatory; }\n.css-19itmt3 { scroll-snap-type: inline mandatory; }\n.css-dsb3ie { scroll-snap-type: both mandatory; }\n.css-17dnop3 { scroll-snap-type: x proximity; }\n.css-18zv1rh { scroll-snap-type: y proximity; }\n.css-egv1n6 { scroll-snap-type: block proximity; }\n.css-b5hutf { scroll-snap-type: inline proximity; }\n.css-dh9nie { scroll-snap-type: both proximity; }\n"
  ];
  CSS.make("css-ln465o", []);
  CSS.make("css-17ynssh", []);
  CSS.make("css-12rw5gj", []);
  CSS.make("css-9kl9s8", []);
  CSS.make("css-1v3vu9e", []);
  CSS.make("css-1gi8cz8", []);
  CSS.make("css-1frylul", []);
  CSS.make("css-ft6tpu", []);
  CSS.make("css-y44050", []);
  CSS.make("css-isuzxh", []);
  CSS.make("css-17q6loy", []);
  CSS.make("css-1s02mon", []);
  CSS.make("css-1slismy", []);
  CSS.make("css-okw7db", []);
  CSS.make("css-nwk411", []);
  CSS.make("css-fawqh3", []);
  CSS.make("css-18217s3", []);
  CSS.make("css-1wdbulw", []);
  CSS.make("css-t5p016", []);
  CSS.make("css-5l8qqt", []);
  CSS.make("css-1x4lgbf", []);
  CSS.make("css-1b6v1ys", []);
  CSS.make("css-1djzdfs", []);
  CSS.make("css-1q93mrv", []);
  CSS.make("css-1i1cpka", []);
  CSS.make("css-1g0xokg", []);
  CSS.make("css-n5xvjn", []);
  CSS.make("css-dfcyrz", []);
  CSS.make("css-122c787", []);
  CSS.make("css-1ha46zn", []);
  CSS.make("css-zhhsa1", []);
  CSS.make("css-kmsxxn", []);
  CSS.make("css-13x390v", []);
  CSS.make("css-da6ki1", []);
  CSS.make("css-13zeit1", []);
  CSS.make("css-55x98a", []);
  CSS.make("css-1xkixqy", []);
  CSS.make("css-1prc3dg", []);
  CSS.make("css-8a6gy7", []);
  CSS.make("css-1nozixy", []);
  CSS.make("css-17vwe1r", []);
  CSS.make("css-1aw6fx7", []);
  CSS.make("css-ekdwh5", []);
  CSS.make("css-1ks0wr3", []);
  CSS.make("css-1imdvtu", []);
  CSS.make("css-34wm85", []);
  CSS.make("css-jazrbb", []);
  CSS.make("css-18a4c8j", []);
  CSS.make("css-fgo1nk", []);
  CSS.make("css-hh1jmk", []);
  CSS.make("css-17pw4k2", []);
  CSS.make("css-11l9lap", []);
  CSS.make("css-3pe157", []);
  CSS.make("css-198bvio", []);
  CSS.make("css-4104ud", []);
  CSS.make("css-1b2737x", []);
  CSS.make("css-wtggxx", []);
  CSS.make("css-12m90qi", []);
  CSS.make("css-zr2z71", []);
  CSS.make("css-1uh8i43", []);
  CSS.make("css-a5xln", []);
  CSS.make("css-13ei02w", []);
  CSS.make("css-1p532sc", []);
  CSS.make("css-xxuuah", []);
  CSS.make("css-1qr0g4w", []);
  CSS.make("css-1dinkp8", []);
  CSS.make("css-k3a5r", []);
  CSS.make("css-i4oy7a", []);
  CSS.make("css-vzpnnm", []);
  CSS.make("css-r3kugg", []);
  CSS.make("css-em7yjq", []);
  CSS.make("css-19itmt3", []);
  CSS.make("css-dsb3ie", []);
  CSS.make("css-17dnop3", []);
  CSS.make("css-18zv1rh", []);
  CSS.make("css-egv1n6", []);
  CSS.make("css-b5hutf", []);
  CSS.make("css-dh9nie", []);
