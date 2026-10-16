Pins the specificity twin: every `_a_` rule in the sheet also answers to
`._t<k>_X` followed by `:not(x-)` `k` times, and `CSS.merge` (and a block, for its own
atoms) swaps an atom's class for the twin of level `k` when the atom overlaps
a surviving earlier atom that the sheet order could put after it. Cases G52 to
G60 cover chains that need one and two levels, a four-way chain that reaches the cap of two levels (G55), both groupings, a partial
overlap with a base atom, an author selector of two classes (it must beat the twin), and a
`:hover` atom against a twin at-rule atom.

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
  G52 a: label:g52_a _id_1mefo6i _a_0p2f03hghs75om
  G52 b: label:g52_b _id_dbzilk _a_0f0zo3hef5iz8q
  G52 c: label:g52_c _id_nagxqs _a_3hghssmo4
  G52 result: label:g52_a _id_1mefo6i label:g52_b _id_dbzilk _t1_0f0zo3hef5iz8q label:g52_c _id_nagxqs _t2_3hghssmo4
  G53 a: label:g53_a _id_17mpqz1 _a_0p2f03hghsttt7
  G53 b: label:g53_b _id_x5dlwl _a_0f0zo3hef52i91
  G53 c: label:g53_c _id_1q9xr6j _a_3hghsw7ry
  G53 result: label:g53_a _id_17mpqz1 label:g53_b _id_x5dlwl _a_0f0zo3hef52i91 label:g53_c _id_1q9xr6j _t1_3hghsw7ry
  G54 a: label:g54_a _id_1ebe62e _a_0p2f03hghsgh85
  G54 b: label:g54_b _id_f4zch5 _a_3hef5f3p1
  G54 result: label:g54_a _id_1ebe62e _a_0p2f03hghsgh85 label:g54_b _id_f4zch5 _t1_3hef5f3p1
  G55 a: label:g55_a _id_1it1uqw _a_0p2f03hghs82qp
  G55 b: label:g55_b _id_1cwx02e _a_0f0zo3hef53gy6
  G55 c: label:g55_c _id_su7tg _a_0trjp3hghs54xt
  G55 d: label:g55_d _id_joi1na _a_0fscf3hef5osbk
  G55 result: label:g55_a _id_1it1uqw _a_0p2f03hghs82qp label:g55_b _id_1cwx02e _t1_0f0zo3hef53gy6 label:g55_c _id_su7tg _t2_0trjp3hghs54xt label:g55_d _id_joi1na _t2_0fscf3hef5osbk
  G56 b: label:g56_x _id_1o2qy8 _a_0p2f07phq26 label:g56_y _id_mxjqwk _t1_7p002svew
  G57 a: label:g57_a _id_1sh8tzw _a_0p2f065b81a
  G57 b: label:g57_b _id_9z38n6 _a_6500wix1i
  G57 result: label:g57_a _id_1sh8tzw _a_0p2f065b81a label:g57_b _id_9z38n6 _t1_6500wix1i
  G58 a: label:g58_a _id_jqbjd0 _a_0p2f094008bn02
  G58 b: label:g58_b _id_1ulzyr2 _a_0f0zo94008fg96
  G58 c: label:g58_c _id_1u5yp68 _a_qyw7u94008n8bc
  G58 result: label:g58_a _id_jqbjd0 _a_0p2f094008bn02 label:g58_b _id_1ulzyr2 _t1_0f0zo94008fg96 label:g58_c _id_1u5yp68 _a_qyw7u94008n8bc
  G59 a: label:g59_a _id_14dhr2t _a_0p2f0940022q28
  G59 b: label:g59_b _id_1jiijm6 _a_0f0zo94qxcd
  G59 result: label:g59_a _id_14dhr2t _a_0p2f0940022q28 label:g59_b _id_1jiijm6 _t1_0f0zo94qxcd
  G60 a: label:g60_a _id_1cqlun4 _a_0p2f0940080sr9
  G60 b: label:g60_b _id_y2bmp7 _a_qyw7u940085uki
  G60 c: label:g60_c _id_1uciqbf _a_0f0zo94008biqu
  G60 result: label:g60_a _id_1cqlun4 _a_0p2f0940080sr9 label:g60_b _id_y2bmp7 _a_qyw7u940085uki label:g60_c _id_1uciqbf _t1_0f0zo94008biqu
  G61 a: label:g61_a _id_6xyx7r _a_0p2f04edryl
  G61 b: label:g61_b _id_c8ukp _a_qyw7u4ej85p _t1_1lub34eewkq _t2_mzyyh4evz20 _t2_egfee4epz49 _t2_wu9h64eecmo
  G61 c: label:g61_c _id_1f5fygi _a_0f0zo4e1mxw
  G61 result: label:g61_a _id_6xyx7r _a_0p2f04edryl label:g61_b _id_c8ukp _a_qyw7u4ej85p _t1_1lub34eewkq _t2_mzyyh4evz20 _t2_egfee4epz49 _t2_wu9h64eecmo label:g61_c _id_1f5fygi _t1_0f0zo4e1mxw
  G62 ctx g62_x: label:g62_x _id_dqage4
  G62 a: label:g62_a _id_6z55t _a_0u1th3hef5oh3i
  G62 f: label:g62_f _id_k38qjs _a_3hcn4dv9q
  G62 c: label:g62_c _id_kgtvzw _a_x4g8b3hcn4i8d6
  G62 result: label:g62_a _id_6z55t _a_0u1th3hef5oh3i label:g62_f _id_k38qjs _t1_3hcn4dv9q label:g62_c _id_kgtvzw _a_x4g8b3hcn4i8d6
  G63 a: label:g63_a _id_1i8la4g _a_0u1th3hef59qj7
  G63 f: label:g63_f _id_71j5ic _a_3hcn47md7
  G63 c: label:g63_c _id_128nlx4 _a_5wdc33hcn4s7ob
  G63 result: label:g63_a _id_1i8la4g _a_0u1th3hef59qj7 label:g63_f _id_71j5ic _t1_3hcn47md7 label:g63_c _id_128nlx4 _a_5wdc33hcn4s7ob
  G64 ctx g64_x: label:g64_x _id_5vv95s
  G64 a: label:g64_a _id_11xoc9 _a_0u1th3hef57eo9
  G64 f: label:g64_f _id_dherzy _a_3hcn49io8
  G64 c: label:g64_c _id_1p9hjdh _a_5uzps3hcn4k889
  G64 result: label:g64_a _id_11xoc9 _a_0u1th3hef57eo9 label:g64_f _id_dherzy _t1_3hcn49io8 label:g64_c _id_1p9hjdh _a_5uzps3hcn4k889
  G65 ctx g65_x: label:g65_x _id_1oq2lzb
  G65 a: label:g65_a _id_s1un0v _a_0u1th3hef5bllm
  G65 f: label:g65_f _id_4ra6dd _a_3hcn444i4
  G65 c: label:g65_c _id_nz8k91 _a_p4tmq3hcn415a4
  G65 result: label:g65_a _id_s1un0v _a_0u1th3hef5bllm label:g65_f _id_4ra6dd _t1_3hcn444i4 label:g65_c _id_nz8k91 _a_p4tmq3hcn415a4
  G66 ctx g66_x: label:g66_x _id_qxa9f2
  G66 a: label:g66_a _id_1nhjoqj _a_0u1th3hef5k7ns
  G66 f: label:g66_f _id_1av6rto _a_3hcn4lt69
  G66 c: label:g66_c _id_15rp9ze _a_k9lqp3hcn4erzc
  G66 result: label:g66_a _id_1nhjoqj _a_0u1th3hef5k7ns label:g66_f _id_1av6rto _t1_3hcn4lt69 label:g66_c _id_15rp9ze _a_k9lqp3hcn4erzc

The stylesheet, from the same post-PPX files the executable was built from:

  $ styled-ppx.generate _build/default/*.re.pp.ml
  /* This file is generated by styled-ppx, do not edit manually */
  .g56-hook.g56-on{margin-left:561px;}
  ._a_mzyyh4evz20 a,._t1_mzyyh4evz20:not(x-) a,._t2_mzyyh4evz20:not(x-):not(x-) a{color:rgb(63, 0, 0);}
  ._a_egfee4epz49 :is(b,i),._t1_egfee4epz49:not(x-) :is(b,i),._t2_egfee4epz49:not(x-):not(x-) :is(b,i){color:rgb(63, 0, 0);}
  ._a_3hghssmo4,._t1_3hghssmo4:not(x-),._t2_3hghssmo4:not(x-):not(x-){border-top:3px dotted rgb(30, 0, 0);}
  ._a_3hghsw7ry,._t1_3hghsw7ry:not(x-),._t2_3hghsw7ry:not(x-):not(x-){border-top:3px dotted rgb(31, 0, 0);}
  ._a_3hef5f3p1,._t1_3hef5f3p1:not(x-),._t2_3hef5f3p1:not(x-):not(x-){border-color:rgb(22, 0, 0);}
  ._a_7p002svew,._t1_7p002svew:not(x-),._t2_7p002svew:not(x-):not(x-){margin-left:563px;}
  ._a_6500wix1i,._t1_6500wix1i:not(x-),._t2_6500wix1i:not(x-):not(x-){font-size:16px;}
  ._a_3hcn4dv9q,._t1_3hcn4dv9q:not(x-),._t2_3hcn4dv9q:not(x-):not(x-){border-top-color:rgb(62, 0, 0);}
  ._id_dqage4 ._a_x4g8b3hcn4i8d6,._id_dqage4 ._t1_x4g8b3hcn4i8d6:not(x-),._id_dqage4 ._t2_x4g8b3hcn4i8d6:not(x-):not(x-){border-top-color:rgb(63, 0, 0);}
  ._a_3hcn47md7,._t1_3hcn47md7:not(x-),._t2_3hcn47md7:not(x-):not(x-){border-top-color:rgb(72, 0, 0);}
  ._a_5wdc33hcn4s7ob + ._a_5wdc33hcn4s7ob,._t1_5wdc33hcn4s7ob:not(x-) + ._t1_5wdc33hcn4s7ob,._t2_5wdc33hcn4s7ob:not(x-):not(x-) + ._t2_5wdc33hcn4s7ob{border-top-color:rgb(73, 0, 0);}
  ._a_3hcn49io8,._t1_3hcn49io8:not(x-),._t2_3hcn49io8:not(x-):not(x-){border-top-color:rgb(82, 0, 0);}
  ._id_5vv95s + ._a_5uzps3hcn4k889,._id_5vv95s + ._t1_5uzps3hcn4k889:not(x-),._id_5vv95s + ._t2_5uzps3hcn4k889:not(x-):not(x-){border-top-color:rgb(83, 0, 0);}
  ._a_3hcn444i4,._t1_3hcn444i4:not(x-),._t2_3hcn444i4:not(x-):not(x-){border-top-color:rgb(92, 0, 0);}
  ._id_1oq2lzb:first-child ._a_p4tmq3hcn415a4,._id_1oq2lzb:first-child ._t1_p4tmq3hcn415a4:not(x-),._id_1oq2lzb:first-child ._t2_p4tmq3hcn415a4:not(x-):not(x-){border-top-color:rgb(93, 0, 0);}
  ._a_3hcn4lt69,._t1_3hcn4lt69:not(x-),._t2_3hcn4lt69:not(x-):not(x-){border-top-color:rgb(102, 0, 0);}
  ._a_qyw7u4ej85p:hover,._t1_qyw7u4ej85p:not(x-):hover,._t2_qyw7u4ej85p:not(x-):not(x-):hover{color:rgb(62, 0, 0);}
  ._a_1lub34eewkq:focus,._t1_1lub34eewkq:not(x-):focus,._t2_1lub34eewkq:not(x-):not(x-):focus{color:rgb(62, 0, 0);}
  ._a_wu9h64eecmo::placeholder,._t1_wu9h64eecmo:not(x-)::placeholder,._t2_wu9h64eecmo:not(x-):not(x-)::placeholder{color:rgb(64, 0, 0);}
  @media (max-width: 1200px) {._a_0p2f03hghs75om,._t1_0p2f03hghs75om:not(x-),._t2_0p2f03hghs75om:not(x-):not(x-){border-top:1px solid rgb(10, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f03hghsttt7,._t1_0p2f03hghsttt7:not(x-),._t2_0p2f03hghsttt7:not(x-):not(x-){border-top:1px solid rgb(11, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f03hghsgh85,._t1_0p2f03hghsgh85:not(x-),._t2_0p2f03hghsgh85:not(x-):not(x-){border-top:1px solid rgb(12, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f03hghs82qp,._t1_0p2f03hghs82qp:not(x-),._t2_0p2f03hghs82qp:not(x-):not(x-){border-top:1px solid rgb(13, 0, 0);}}
  @media (max-width: 700px) {._a_0trjp3hghs54xt,._t1_0trjp3hghs54xt:not(x-),._t2_0trjp3hghs54xt:not(x-):not(x-){border-top:2px dashed rgb(33, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f07phq26,._t1_0p2f07phq26:not(x-),._t2_0p2f07phq26:not(x-):not(x-){margin:562px;}}
  @media (max-width: 1200px) {._a_0p2f065b81a,._t1_0p2f065b81a:not(x-),._t2_0p2f065b81a:not(x-):not(x-){font:14px/1.2 serif;}}
  @media (max-width: 900px) {._a_0f0zo94qxcd,._t1_0f0zo94qxcd:not(x-),._t2_0f0zo94qxcd:not(x-):not(x-){padding:592px;}}
  @media (max-width: 1200px) {._a_0p2f04edryl,._t1_0p2f04edryl:not(x-),._t2_0p2f04edryl:not(x-):not(x-){color:rgb(61, 0, 0);}}
  @media (max-width: 900px) {._a_0f0zo4e1mxw,._t1_0f0zo4e1mxw:not(x-),._t2_0f0zo4e1mxw:not(x-):not(x-){color:rgb(65, 0, 0);}}
  ._a_qyw7u94008n8bc:hover,._t1_qyw7u94008n8bc:not(x-):hover,._t2_qyw7u94008n8bc:not(x-):not(x-):hover{padding-top:583px;}
  ._a_qyw7u940085uki:hover,._t1_qyw7u940085uki:not(x-):hover,._t2_qyw7u940085uki:not(x-):not(x-):hover{padding-top:602px;}
  @media (max-width: 900px) {._a_0f0zo3hef5iz8q,._t1_0f0zo3hef5iz8q:not(x-),._t2_0f0zo3hef5iz8q:not(x-):not(x-){border-color:rgb(20, 0, 0);}}
  @media (max-width: 900px) {._a_0f0zo3hef52i91,._t1_0f0zo3hef52i91:not(x-),._t2_0f0zo3hef52i91:not(x-):not(x-){border-color:rgb(21, 0, 0);}}
  @media (max-width: 900px) {._a_0f0zo3hef53gy6,._t1_0f0zo3hef53gy6:not(x-),._t2_0f0zo3hef53gy6:not(x-):not(x-){border-color:rgb(23, 0, 0);}}
  @media (max-width: 500px) {._a_0fscf3hef5osbk,._t1_0fscf3hef5osbk:not(x-),._t2_0fscf3hef5osbk:not(x-):not(x-){border-color:rgb(43, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f094008bn02,._t1_0p2f094008bn02:not(x-),._t2_0p2f094008bn02:not(x-):not(x-){padding-top:581px;}}
  @media (max-width: 900px) {._a_0f0zo94008fg96,._t1_0f0zo94008fg96:not(x-),._t2_0f0zo94008fg96:not(x-):not(x-){padding-top:582px;}}
  @media (max-width: 1200px) {._a_0p2f0940022q28,._t1_0p2f0940022q28:not(x-),._t2_0p2f0940022q28:not(x-):not(x-){padding-left:591px;}}
  @media (max-width: 1200px) {._a_0p2f0940080sr9,._t1_0p2f0940080sr9:not(x-),._t2_0p2f0940080sr9:not(x-):not(x-){padding-top:601px;}}
  @media (max-width: 900px) {._a_0f0zo94008biqu,._t1_0f0zo94008biqu:not(x-),._t2_0f0zo94008biqu:not(x-):not(x-){padding-top:603px;}}
  @media (min-width: 1px) {._a_0u1th3hef5oh3i,._t1_0u1th3hef5oh3i:not(x-),._t2_0u1th3hef5oh3i:not(x-):not(x-){border-color:rgb(61, 0, 0);}}
  @media (min-width: 1px) {._a_0u1th3hef59qj7,._t1_0u1th3hef59qj7:not(x-),._t2_0u1th3hef59qj7:not(x-):not(x-){border-color:rgb(71, 0, 0);}}
  @media (min-width: 1px) {._a_0u1th3hef57eo9,._t1_0u1th3hef57eo9:not(x-),._t2_0u1th3hef57eo9:not(x-):not(x-){border-color:rgb(81, 0, 0);}}
  @media (min-width: 1px) {._a_0u1th3hef5bllm,._t1_0u1th3hef5bllm:not(x-),._t2_0u1th3hef5bllm:not(x-):not(x-){border-color:rgb(91, 0, 0);}}
  @media (min-width: 1px) {._a_0u1th3hef5k7ns,._t1_0u1th3hef5k7ns:not(x-),._t2_0u1th3hef5k7ns:not(x-):not(x-){border-color:rgb(101, 0, 0);}}
  @media (min-width: 1px) {._id_qxa9f2 ._a_k9lqp3hcn4erzc,._id_qxa9f2 ._t1_k9lqp3hcn4erzc:not(x-),._id_qxa9f2 ._t2_k9lqp3hcn4erzc:not(x-):not(x-){border-top-color:rgb(103, 0, 0);}}
