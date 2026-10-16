Pins how `CSS.merge` and the stylesheet order resolve competing declaration
pairs that the Ahrefs monorepo does not use but a styled-ppx author can write,
as one case per combination (E01 to E45). It extends `cascade-cases.t`, which
holds one case per pair found in the monorepo (C01 to C49). Each case sits above
its code in `input.re` with its classification and the author's intended winner.
Every value is unique to its case, so no atom is shared between cases and the
sheet shows each pair on its own.

The cases cover `@supports`, the `all` sentinel and its exclusions, logical and
physical properties, pseudo-elements, raw `var()` shorthands, interpolation
bundles against an override, prefixed properties, shorthands of shorthands,
`!important`, three-way merges, nested at-rules, the one-block `@media` rewrite
and its exceptions, descendant selectors and `[%styled.global]` against an atom,
custom properties, property aliases and pseudo-class chains.

A pair `cascade-cases.t` already pins is not repeated here: `$(x)` in a
shorthand against a longhand (C08, C18, C19, C27, C43), an `_in_` bundle against
a plain atom or an @media atom (C34, C35, C37, C43, C47), and the same `@media`
pair across a merge (C07, C14).

The executable prints, per case, the class string of each operand and of the
result: a class of `a` missing from `result` was dropped by `CSS.merge`. The
generator then prints the full stylesheet. The winner for a pair that `merge`
keeps whole is whichever rule the sheet puts last (after `!important` and
specificity), so read the `result` line together with the sheet.

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
  E01 a: label:e01_a _id_9osalz _a_7p0002ms4m
  E01 b: label:e01_b _id_dw89wp _a_059rq7p0002r214
  E01 result: label:e01_a _id_9osalz _a_7p0002ms4m label:e01_b _id_dw89wp _a_059rq7p0002r214
  E02 a: label:e02_a _id_1n226mp _a_0p2f07p0002so52
  E02 b: label:e02_b _id_1evkk87 _a_059rq7p0002s7xu
  E02 result: label:e02_a _id_1n226mp _a_0p2f07p0002so52 label:e02_b _id_1evkk87 _a_059rq7p0002s7xu
  E03 a: label:e03_a _id_1894u2t _a_0ao227p00020xo5
  E03 b: label:e03_b _id_gxfws9 _a_059rq7p0002us7i
  E03 result: label:e03_a _id_1894u2t _a_0ao227p00020xo5 label:e03_b _id_gxfws9 _a_059rq7p0002us7i
  E04 a: label:e04_a _id_wsw80a _a_7p00022kq6
  E04 b: label:e04_b _id_u6zq7w _a_zz00pi
  E04 result: label:e04_a _id_wsw80a label:e04_b _id_u6zq7w _a_zz00pi
  E05 a: label:e05_a _id_m2zyxh _a_5q82ql _a_dp3xur
  E05 b: label:e05_b _id_gzazh6 _a_zzs30q
  E05 result: label:e05_a _id_m2zyxh _a_5q82ql _a_dp3xur label:e05_b _id_gzazh6 _a_zzs30q
  E06 a: label:e06_a _id_154vhwh _a_zyovh2jrusag
  E06 b: label:e06_b _id_16s1gk8 _a_zzce4j
  E06 result: label:e06_a _id_154vhwh _a_zyovh2jrusag label:e06_b _id_16s1gk8 _a_zzce4j
  E07 a: label:e07_a _id_sajkoc _a_zze1zs
  E07 b: label:e07_b _id_1io1r06 _a_7p0002hevr _a_4ebhyt
  E07 result: label:e07_a _id_sajkoc _a_zze1zs label:e07_b _id_1io1r06 _a_7p0002hevr _a_4ebhyt
  E08 a: label:e08_a _id_1icm9q3 _a_9400026cxn
  E08 b: label:e08_b _id_u48313 _a_960002o2m7
  E08 result: label:e08_a _id_1icm9q3 _a_9400026cxn label:e08_b _id_u48313 _a_960002o2m7
  E09 a: label:e09_a _id_1v3x7im _a_960001qh3g
  E09 b: label:e09_b _id_kdv74q _a_940004c0kc
  E09 result: label:e09_a _id_1v3x7im _a_960001qh3g label:e09_b _id_kdv74q _a_940004c0kc
  E10 a: label:e10_a _id_1ftf6as _a_7q53z7
  E10 b: label:e10_b _id_l0f2ox _a_7p0008viu6
  E10 result: label:e10_a _id_1ftf6as _a_7q53z7 label:e10_b _id_l0f2ox _a_7p0008viu6
  E11 a: label:e11_a _id_1wppxv3 _a_7p0001c2pf
  E11 b: label:e11_b _id_1le1mjf _a_7q4e2p
  E11 result: label:e11_a _id_1wppxv3 _a_7p0001c2pf label:e11_b _id_1le1mjf _a_7q4e2p
  E12 a: label:e12_a _id_1bvzmo1 _a_71w720
  E12 b: label:e12_b _id_1v0fb4 _a_71000862dn
  E12 result: label:e12_a _id_1bvzmo1 _a_71w720 label:e12_b _id_1v0fb4 _a_71000862dn
  E13 a: label:e13_a _id_1rl4bhy _a_2y6oc4eka7d
  E13 b: label:e13_b _id_1kswgxt _a_uo5714ehng9
  E13 result: label:e13_a _id_1rl4bhy _a_2y6oc4eka7d label:e13_b _id_1kswgxt _a_uo5714ehng9
  E14 a: label:e14_a _id_l4w2s0 _a_glt2n4e9r8z
  E14 b: label:e14_b _id_1lq5nuv _a_xmsc94ee0l8
  E14 result: label:e14_a _id_l4w2s0 _a_glt2n4e9r8z label:e14_b _id_1lq5nuv _a_xmsc94ee0l8
  E15 a: label:e15_a _id_1i263tt _a_7pi834
  E15 b: label:e15_b _id_tdw72g _a_7p0002ul8g
  E15 result: label:e15_a _id_1i263tt _a_7pi834 label:e15_b _id_tdw72g _a_7p0002ul8g
  E16 a: label:e16_a _id_1i6xrdx _a_940002igrf
  E16 b: label:e16_b _id_1syppgx _a_94se6h
  E16 result: label:e16_a _id_1i6xrdx label:e16_b _id_1syppgx _a_94se6h
  E17 a: label:e17_a _id_yee9vw _in_h4yksb
  E17 a style: --e17_v1-1w2tyhh:rgb(27, 0, 0)
  E17 b: label:e17_b _id_dw56fu _a_3h0cn4xj20
  E17 result: label:e17_a _id_yee9vw _in_h4yksb label:e17_b _id_dw56fu _a_3h0cn4xj20
  E17 result style: --e17_v1-1w2tyhh:rgb(27, 0, 0)
  E18 a: label:e18_a _id_29swre _in_1m6suwf
  E18 a style: --e18_v1-t1ny06:rgb(29, 0, 0)
  E18 b: label:e18_b _id_fv21ql _in_1llxr99
  E18 b style: --e18_v2-1bzve6l:rgb(30, 0, 0)
  E18 result: label:e18_a _id_29swre _in_1m6suwf label:e18_b _id_fv21ql _in_1llxr99
  E18 result style: --e18_v1-t1ny06:rgb(29, 0, 0);--e18_v2-1bzve6l:rgb(30, 0, 0)
  E19 a: label:e19_a _id_7plkfj _a_1lub32z0008hok3
  E19 b: label:e19_b _id_taocjx _a_x7ow72z5tji
  E19 result: label:e19_a _id_7plkfj _a_1lub32z0008hok3 label:e19_b _id_taocjx _a_x7ow72z5tji
  E20 a: label:e20_a _id_12atsww _a_2svney
  E20 b: label:e20_b _id_13rm7w3 _a_droigx
  E20 result: label:e20_a _id_12atsww _a_2svney label:e20_b _id_13rm7w3 _a_droigx
  E21 a: label:e21_a _id_vw2ne _a_3h0ljd
  E21 b: label:e21_b _id_pf7vxb _a_3h1ekgwqdq
  E21 result: label:e21_a _id_vw2ne _a_3h0ljd label:e21_b _id_pf7vxb _a_3h1ekgwqdq
  E22 a: label:e22_a _id_1ru0x3 _a_qyw7u3h1ekggmzt _a_qyw7u3h06bkdvl3 _a_qyw7u3h0004wrw5 _a_qyw7u3h00sgeuea
  E22 b: label:e22_b _id_1qzft2x _a_1lub33htomz
  E22 result: label:e22_a _id_1ru0x3 _a_qyw7u3h1ekggmzt _a_qyw7u3h06bkdvl3 _a_qyw7u3h0004wrw5 _a_qyw7u3h00sgeuea label:e22_b _id_1qzft2x _a_1lub33htomz
  E23 a: label:e23_a _id_188a8wj _a_oe8sa940008llzq
  E23 b: label:e23_b _id_1446a39 _a_cht88940008wmul _a_cht88940004n1ri _a_cht889400010ush _a_cht889400025pwa
  E23 result: label:e23_a _id_188a8wj _a_oe8sa940008llzq label:e23_b _id_1446a39 _a_cht88940008wmul _a_cht88940004n1ri _a_cht889400010ush _a_cht889400025pwa
  E24 a: label:e24_a _id_y73jiv _a_7p0002d4qg
  E24 b: label:e24_b _id_hqe50r _a_7puinr
  E24 c: label:e24_c _id_426s3k _a_7p0002cqrw
  E24 result: label:e24_a _id_y73jiv label:e24_b _id_hqe50r _a_7puinr label:e24_c _id_426s3k _a_7p0002cqrw
  E25 a: label:e25_a _id_1gckiua _a_7p00028sx6
  E25 b: label:e25_b _id_1m0tp6j _a_0p2f07p0002y0kt
  E25 c: label:e25_c _id_10zwq9e _a_7p00026rac
  E25 result: label:e25_a _id_1gckiua label:e25_b _id_1m0tp6j label:e25_c _id_10zwq9e _a_7p00026rac
  E26 left a: label:e26_a _id_1sw8ngh _a_7p00023ace
  E26 left empty: label:e26_empty _id_ap8yq6
  E26 left result: label:e26_a _id_1sw8ngh _a_7p00023ace label:e26_empty _id_ap8yq6
  E26 right result: label:e26_empty _id_ap8yq6 label:e26_a _id_1sw8ngh _a_7p00023ace
  E27 a: label:e27_a _id_1i9pupd _a_7p00021if4 _a_qyw7u7p00028sdg
  E27 result: label:e27_a _id_1i9pupd label:e27_a _id_1i9pupd _a_7p00021if4 _a_qyw7u7p00028sdg
  E28 a: label:e28_a _id_eijk8x _a_0kk4l7p0002ejru
  E28 b: label:e28_b _id_8eke8l _a_0aatx7p00022avm
  E28 result: label:e28_a _id_eijk8x _a_0kk4l7p0002ejru label:e28_b _id_8eke8l _a_0aatx7p00022avm
  E29 a: label:e29_a _id_17wzo6n _a_0z6h37p0002b1n2
  E29 b: label:e29_b _id_1n2e1d2 _a_0crm37p00023me0
  E29 result: label:e29_a _id_17wzo6n _a_0z6h37p0002b1n2 label:e29_b _id_1n2e1d2 _a_0crm37p00023me0
  E30 a: label:e30_a _id_1hjq29l _a_0bwi47p0002asf7
  E30 b: label:e30_b _id_m17h65 _a_0aatx7p0002cgo6
  E30 result: label:e30_a _id_1hjq29l _a_0bwi47p0002asf7 label:e30_b _id_m17h65 _a_0aatx7p0002cgo6
  E31 result: label:e31 _id_psw2h1 _a_0f0zo7p00024ep7 _a_0p2f07p0002l0a4
  E32 result: label:e32 _id_15n668e _a_0p2f07p00024j5c _a_0f0zo7p0002opsv
  E33 result: label:e33 _id_ftiwkg _a_0gqkv7p0002luqw _a_03qdy7p0002pa78
  E34 result: label:e34 _id_sjtyhp _a_04q027p00028cv9 _a_0q5or7p0002w9to
  E35 result: label:e35 _id_1fo0xx2 _a_0gqkv7p0002onxl _a_0f0zo7p0002iivl
  E36 parent: label:e36_a _id_8l1jh8 _a_dzdgw7p00022shq
  E36 child: label:e36_b _id_zvocwr _a_7p0002pqxt
  E37 parent: label:e37_a _id_1211w0b _a_exm317p0002zf0w
  E37 child: label:e37_b _id_11u4msy _a_7p0002gxxs
  E38 b: label:e38_b _id_c21s08 _a_7p0002yrio
  E39 b: label:e39_b _id_hr2prc _a_7p0002t7fr
  E40 a: label:e40_a _id_1mtopv8 _a_zys35fv8j1n8
  E40 b: label:e40_b _id_spf3ru _a_0p2f0zys35fv8rtiz
  E40 result: label:e40_a _id_1mtopv8 _a_zys35fv8j1n8 label:e40_b _id_spf3ru _a_0p2f0zys35fv8rtiz
  E41 a: label:e41_a _id_rrocj5 _a_zy13yy5e8vw2
  E41 b: label:e41_b _id_1q9snzb _a_zyo7exr1amxx
  E41 result: label:e41_a _id_rrocj5 _a_zy13yy5e8vw2 label:e41_b _id_1q9snzb _a_zyo7exr1amxx
  E42 a: label:e42_a _id_rsx84a _a_8xpt08
  E42 b: label:e42_b _id_vtwae2 _a_8x4jlj
  E42 result: label:e42_a _id_rsx84a label:e42_b _id_vtwae2 _a_8x4jlj
  E43 a: label:e43_a _id_pvzbp3 _a_qss4z7p0002ywuh
  E43 b: label:e43_b _id_13e0y5i _a_vflny7p0002j2yf
  E43 result: label:e43_a _id_pvzbp3 _a_qss4z7p0002ywuh label:e43_b _id_13e0y5i _a_vflny7p0002j2yf
  E44 result: label:e44 _id_nw31d3 _a_7p00022k5d
  E45 a: label:e45_a _id_118bvcf _a_710002ejjz
  E45 b: label:e45_b _id_15lyehp _a_740002s0x2
  E45 result: label:e45_a _id_118bvcf _a_710002ejjz label:e45_b _id_15lyehp _a_740002s0x2

The stylesheet, from the same post-PPX files the executable was built from, so
its classes are the ones printed above:

  $ styled-ppx.generate _build/default/*.re.pp.ml
  /* This file is generated by styled-ppx, do not edit manually */
  @property --e17_v1-1w2tyhh{syntax:"*";inherits:false;}
  @property --e18_v1-t1ny06{syntax:"*";inherits:false;}
  @property --e18_v2-1bzve6l{syntax:"*";inherits:false;}
  .e38-hook{margin-left:371px;}
  div.e39-hook{margin-left:373px;}
  ._a_dzdgw7p00022shq *{margin-left:367px;}
  ._a_exm317p0002zf0w span{margin-left:369px;}
  ._a_zz00pi{all:unset;}
  ._a_5q82ql{direction:rtl;}
  ._a_dp3xur{unicode-bidi:bidi-override;}
  ._a_zzs30q{all:initial;}
  ._a_zyovh2jrusag{--e06-a:308px;}
  ._a_zzce4j{all:revert;}
  ._a_4ebhyt{color:rgb(10, 0, 0);}
  ._a_zze1zs{all:revert-layer;}
  ._a_7q53z7{margin-block:315px;}
  ._a_7q4e2p{margin-block:318px;}
  ._a_71w720{inset:319px;}
  ._a_7pi834{margin:var(--e15-x);}
  ._a_94se6h{padding:var(--e16-x);}
  ._a_droigx{-webkit-user-select:text;-moz-user-select:text;-ms-user-select:text;user-select:text;}
  ._a_2svney{-webkit-user-select:none;}
  ._a_3h0ljd{border:333px solid rgb(34, 0, 0);}
  ._a_7puinr{margin:343px;}
  ._a_zys35fv8j1n8{--e40-x:375px;}
  ._a_zy13yy5e8vw2{--e41-x:377px;}
  ._a_zyo7exr1amxx{--e41-y:378px;}
  ._a_8xpt08{word-wrap:break-word;}
  ._a_8x4jlj{overflow-wrap:anywhere;}
  ._a_7p0002ms4m{margin-left:301px;}
  ._a_7p00022kq6{margin-left:307px;}
  ._a_7p0002hevr{margin-left:309px;}
  ._a_9400026cxn{padding-left:311px;}
  ._a_960002o2m7{-webkit-padding-start:312px;padding-inline-start:312px;}
  ._a_940004c0kc{padding-right:313px;}
  ._a_960001qh3g{-webkit-padding-end:314px;padding-inline-end:314px;}
  ._a_7p0008viu6{margin-top:316px;}
  ._a_7p0001c2pf{margin-bottom:317px;}
  ._a_71000862dn{top:320px;}
  ._a_7p0002ul8g{margin-left:325px;}
  ._a_940002igrf{padding-left:326px;}
  ._a_oe8sa940008llzq{padding-top:340px !important;}
  ._a_7p0002d4qg{margin-left:342px;}
  ._a_7p0002cqrw{margin-left:344px;}
  ._a_7p00028sx6{margin-left:345px;}
  ._a_7p00026rac{margin-left:347px;}
  ._a_7p00023ace{margin-left:348px;}
  ._a_7p00021if4{margin-left:349px;}
  ._a_7p0002pqxt{margin-left:368px;}
  ._a_7p0002gxxs{margin-left:370px;}
  ._a_7p0002yrio{margin-left:372px;}
  ._a_7p0002t7fr{margin-left:374px;}
  ._a_7p00022k5d{margin-left:381px;margin-left:382px;}
  ._a_710002ejjz{left:383px;}
  ._a_740002s0x2{inset-inline-start:384px;}
  ._in_h4yksb{border-top-color:var(--e17_v1-1w2tyhh);}
  ._a_3h0cn4xj20{border-top-color:rgb(28, 0, 0);}
  ._in_1m6suwf{border-left-color:var(--e18_v1-t1ny06);}
  ._in_1llxr99{border-left-color:var(--e18_v2-1bzve6l);}
  ._a_3h1ekgwqdq{border-top-width:335px;}
  ._a_1lub33htomz:focus{border:337px solid rgb(38, 0, 0);border-top-width:339px;}
  ._a_x7ow72z5tji:active{-webkit-animation:332s ease;animation:332s ease;}
  ._a_2y6oc4eka7d::before{color:rgb(21, 0, 0);}
  ._a_uo5714ehng9::after{color:rgb(22, 0, 0);}
  ._a_glt2n4e9r8z::before:hover{color:rgb(23, 0, 0);}
  ._a_xmsc94ee0l8:hover::before{color:rgb(24, 0, 0);}
  @media (max-width: 1200px) {._a_0p2f0zys35fv8rtiz{--e40-x:376px;}}
  ._a_qyw7u7p00028sdg:hover{margin-left:350px;}
  ._a_1lub32z0008hok3:focus{-webkit-animation-duration:331s;animation-duration:331s;}
  ._a_vflny7p0002j2yf:active:first-child{margin-left:380px;}
  ._a_qss4z7p0002ywuh:hover:focus-within{margin-left:379px;}
  @supports (display: grid) {._a_059rq7p0002r214{margin-left:302px;}}
  @supports (display: grid) {._a_059rq7p0002s7xu{margin-left:304px;}}
  @supports (display: grid) {._a_059rq7p0002us7i{margin-left:305px;}}
  @supports (display: flex) {._a_0ao227p00020xo5{margin-left:306px;}}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l7p0002ejru{margin-left:351px;}}}
  @media (max-width: 1200px) {._a_0p2f07p0002so52{margin-left:303px;}}
  @media (max-width: 1200px) {._a_cht88940008wmul{padding-top:341px !important;}}
  @media (max-width: 1200px) {._a_cht88940004n1ri{padding-right:341px !important;}}
  @media (max-width: 1200px) {._a_cht889400010ush{padding-bottom:341px !important;}}
  @media (max-width: 1200px) {._a_cht889400025pwa{padding-left:341px !important;}}
  @media (max-width: 1200px) {._a_0p2f07p0002y0kt{margin-left:346px;}}
  @media (max-width: 1100px) {._a_0aatx7p00022avm{margin-left:352px;}}
  @media (max-width: 1200px) {@container app-main (max-width: 900px) {._a_0z6h37p0002b1n2{margin-left:353px;}}}
  @media (max-width: 1200px) {@container app-main (max-width: 1000px) {._a_0bwi47p0002asf7{margin-left:355px;}}}
  @media (max-width: 1100px) {._a_0aatx7p0002cgo6{margin-left:356px;}}
  @media (max-width: 900px) and (not (max-width: 1200px)){._a_0f0zo7p00024ep7{margin-left:357px;}}
  @media (max-width: 1200px) {._a_0p2f07p0002l0a4{margin-left:358px;}}
  @media (max-width: 1200px) and (not (max-width: 900px)){._a_0p2f07p00024j5c{margin-left:359px;}}
  @media (max-width: 900px) {._a_0f0zo7p0002opsv{margin-left:360px;}}
  @media screen and (max-width: 1200px) and (not (max-width: 900px)){._a_0gqkv7p0002luqw{margin-left:361px;}}
  @media screen and (max-width: 900px) {._a_03qdy7p0002pa78{margin-left:362px;}}
  @media not screen and (min-width: 1200px) {._a_04q027p00028cv9{margin-left:363px;}}
  @media not screen and (min-width: 900px) {._a_0q5or7p0002w9to{margin-left:364px;}}
  @media screen and (max-width: 1200px) {._a_0gqkv7p0002onxl{margin-left:365px;}}
  @media (max-width: 900px) {._a_0f0zo7p0002iivl{margin-left:366px;}}
  @container app-main (max-width: 1000px) {._a_0crm37p00023me0{margin-left:354px;}}
  ._in_h4yksb:hover{border-top-color:var(--e17_v1-1w2tyhh);}
  ._in_1m6suwf:hover{border-left-color:var(--e18_v1-t1ny06);}
  ._in_1llxr99:hover{border-left-color:var(--e18_v2-1bzve6l);}
  ._a_qyw7u3h1ekggmzt:hover{border-top-width:336px;}
  ._a_qyw7u3h06bkdvl3:hover{border-right-width:336px;}
  ._a_qyw7u3h0004wrw5:hover{border-bottom-width:336px;}
  ._a_qyw7u3h00sgeuea:hover{border-left-width:336px;}
