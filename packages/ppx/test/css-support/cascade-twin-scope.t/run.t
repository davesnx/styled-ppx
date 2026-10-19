A twin rule is written only for an atom that a merge may need to raise: an atom with a partly overlapping competitor, in its own source file (or in a file it uses in a selector), that styles the same element with the same specificity, that the atom does not replace, and that the sheet order may put after it. Where the sheet order surely puts the atom last, or a merge drops the competitor, there is no twin rule. `CSS.merge` still adds the twin class next to the `_a_` class, so a merge of atoms with no twin rule keeps both atoms working and lets the sheet order decide (accepted limit).

Cases, one file each unless stated:

- `same_file.re`: a media shorthand and a base longhand. Only the base `padding-top` gets twin rules: the sheet puts the media `padding` after it, so the shorthand needs none.
- `cross_first.re` and `cross_second.re`: the same pair in two files. The merge adds the twin class, the sheet has no twin rule, and the media shorthand, which the sheet puts last, wins the top padding.
- `alone.re`: two atoms of different properties. Plain rules.
- `used_a.re` and `used_b.re`: `used_b.re` uses a class of `used_a.re` in a selector (`$(Used_a.target)`), which shows it means to override it, so the two files compete as one and the base `padding-top` gets twin rules.
- `target_before.re`: `position: relative` on the element and `position: absolute` on `& > ::before`. They style different elements: plain rules.
- `target_hover.re`: `&:hover` `padding` and `&:hover` `padding-top`. The sheet puts a longhand after its shorthand: plain rules.
- `state_pair.re`: `&:hover` and `&:focus` of one element tie at (0,2,0), can be on together and have different contexts, so each may need raising over the other and both get twin rules. `hover` then `focus` merged: the focus `padding-top` wins the top. `focus` then `hover`: the hover `padding` wins every side. With both states forced on, Chromium, Firefox and WebKit give the later argument's value, and without the twin rules the earlier atom wins the second order.
- `class_state.re`: `&.on` `padding` and `&:hover` `padding-top` tie at (0,2,0) and can be on one element together, so both get twin rules. With the class and the state forced on, the later argument wins in both orders.
- `responsive_same.re`: a base `width` and the same `width` under `@media`. A merge drops the base one when the media one is later, and the sheet puts the media rule after the base rule otherwise: plain rules.
- `covering.re`: a base `padding` and a base `padding-left`, merged. The sheet puts a longhand after its shorthand and a merge drops a longhand that a later shorthand covers: plain rules.
- `same_value.re`: `width: 100%` under `@media` and under `@container` in one block. Equal values never need a twin against each other, whichever wins: plain rules.
- `media_pair.re`: `padding` under one `@media` and `padding-top` under another. Each may be raised over the other, in either merge order, but never twice: the twin rules stop at level 1.
- `base_state.re`: a base `padding` and `&:hover` `padding-top` differ in specificity, which a twin cannot change: plain rules.
- `empty_a.re` and `empty_b.re`: the referenced block is empty, it has no atom, so nothing competes and the atom stays plain.

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

  $ cat > dune << EOF
  > (executable
  >  (name input)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build ./input.exe

  $ ./_build/default/input.exe
  same file: label:responsive _id_nj0o3i _a_0p2f09462m4 label:override _id_1njk4dq _a_940008kzem _t1_940008kzem
  cross file: label:responsive _id_1kdqwpk _a_0p2f094kf94 label:override _id_1yq9mpx _a_940008xfx1 _t1_940008xfx1
  alone: label:only _id_1tni9kc _a_4eanme _a_390004tydx
  selector use: label:target _id_ory220 _a_0p2f094bl31 label:override _id_119fi2s _a_9400087zc5 _t1_9400087zc5
  empty block use: label:lone _id_qk1qir _a_940008k8nd
  other target: label:overlay _id_vup29l _a_9lelbk _a_irt5n9l0sjb
  same target: label:hover _id_fhqjve _a_qyw7u94f2bb _a_qyw7u940008c444
  hover then focus: label:hover _id_qei3s4 _a_qyw7u94kk25 label:focus _id_3qzjnk _a_1lub3940008rtdq _t1_1lub3940008rtdq
  focus then hover: label:focus _id_3qzjnk _a_1lub3940008rtdq label:hover _id_qei3s4 _a_qyw7u94kk25 _t1_qyw7u94kk25
  base and hover: label:state _id_1n761jp _a_94co3k _a_qyw7u940008eyud
  class then state: label:marked _id_mvy0f9 _a_mznts94ffg1 label:hovered _id_1eai73m _a_qyw7u940008xbde _t1_qyw7u940008xbde
  state then class: label:hovered _id_1eai73m _a_qyw7u940008xbde label:marked _id_mvy0f9 _a_mznts94ffg1 _t1_mznts94ffg1
  responsive same longhand: label:responsive _id_trwxo8 _a_ec6fii _a_0uxmbecfhnh
  shorthand then longhand: label:wide _id_j6zm4t _a_94jpjo label:narrow _id_16cmr31 _a_940002z7qv
  same value under two at-rules: label:fluid _id_1tpzp28 _a_0uxmbecc8xd _a_0k7h9ec8c7o _t1_0k7h9ec8c7o
  two media contexts: label:wide _id_c8qu5k _a_0p2f094gkw9 label:narrow _id_sw5h60 _a_0f0zo940008i4zu _t1_0f0zo940008i4zu
  two media contexts reversed: label:narrow _id_sw5h60 _a_0f0zo940008i4zu label:wide _id_c8qu5k _a_0p2f094gkw9 _t1_0p2f094gkw9

  $ styled-ppx.generate _build/default/*.re.pp.ml
  /* This file is generated by styled-ppx, do not edit manually */
  ._a_irt5n9l0sjb > ::before{position:absolute;}
  ._a_4eanme{color:rgb(31, 0, 0);}
  ._a_94co3k{padding:91px;}
  ._a_mznts94ffg1.on,._t1_mznts94ffg1:not(x-).on,._t2_mznts94ffg1:not(x-):not(x-).on{padding:85px;}
  ._a_94jpjo{padding:111px;}
  ._a_zv6iz4e2rin._id_1g4ku0i{color:rgb(63, 0, 0);}
  ._a_ec6fii{width:101px;}
  ._a_9lelbk{position:relative;}
  ._a_jo8cg4eeoet._id_ory220{color:rgb(53, 0, 0);}
  ._a_390004tydx{background-color:rgb(32, 0, 0);}
  ._a_940002z7qv{padding-left:112px;}
  ._a_940008xfx1{padding-top:22px;}
  ._a_940008k8nd{padding-top:62px;}
  ._a_940008kzem,._t1_940008kzem:not(x-),._t2_940008kzem:not(x-):not(x-){padding-top:12px;}
  ._a_9400087zc5,._t1_9400087zc5:not(x-),._t2_9400087zc5:not(x-):not(x-){padding-top:52px;}
  ._a_qyw7u94kk25:hover,._t1_qyw7u94kk25:not(x-):hover,._t2_qyw7u94kk25:not(x-):not(x-):hover{padding:81px;}
  ._a_qyw7u94f2bb:hover{padding:71px;}
  @media (max-width: 1200px) {._a_0p2f094kf94{padding:21px;}}
  @media (max-width: 1200px) {._a_0p2f094gkw9,._t1_0p2f094gkw9:not(x-),._t2_0p2f094gkw9:not(x-):not(x-){padding:121px;}}
  @media (max-width: 600px) {._a_0uxmbecfhnh{width:102px;}}
  @media (max-width: 1200px) {._a_0p2f09462m4{padding:11px;}}
  @media (max-width: 600px) {._a_0uxmbecc8xd{width:100%;}}
  @media (max-width: 1200px) {._a_0p2f094bl31{padding:51px;}}
  @container (max-width: 300px) {._a_0k7h9ec8c7o{width:100%;}}
  ._a_qyw7u940008eyud:hover{padding-top:92px;}
  ._a_qyw7u940008xbde:hover,._t1_qyw7u940008xbde:not(x-):hover,._t2_qyw7u940008xbde:not(x-):not(x-):hover{padding-top:86px;}
  ._a_qyw7u940008c444:hover{padding-top:72px;}
  ._a_1lub3940008rtdq:focus,._t1_1lub3940008rtdq:not(x-):focus,._t2_1lub3940008rtdq:not(x-):not(x-):focus{padding-top:82px;}
  @media (max-width: 900px) {._a_0f0zo940008i4zu,._t1_0f0zo940008i4zu:not(x-),._t2_0f0zo940008i4zu:not(x-):not(x-){padding-top:122px;}}
