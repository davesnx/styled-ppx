Pins how `CSS.merge` and the stylesheet order resolve competing declaration
pairs that the Ahrefs monorepo does not use but a styled-ppx author can write,
as one case per combination (E01 to E45). It extends `cascade-cases.t`, which
holds one case per pair found in the monorepo (C01 to C49). Each case sits above
its code in `input.re` with its classification and the author's intended winner.
Every value is unique to its case, so no atom is shared between cases and the
sheet shows each pair on its own.

The cases cover `@supports`, the `all` sentinel and its exclusions, logical and
physical properties, pseudo-elements, raw `var()` shorthands, atoms that share
one interpolation variable against an override, prefixed properties, shorthands of shorthands,
`!important`, three-way merges, nested at-rules, the one-block `@media` rewrite
and its exceptions, descendant selectors and `[%styled.global]` against an atom,
custom properties, property aliases and pseudo-class chains.

A pair `cascade-cases.t` already pins is not repeated here: `$(x)` in a
shorthand against a longhand (C08, C18, C19, C27, C43), a group of atoms that
share one interpolation variable against a plain atom or an @media atom (C34,
C35, C37, C43, C47), and the same `@media`
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
  E02 result: label:e02_a _id_1n226mp _a_0p2f07p0002so52 label:e02_b _id_1evkk87 _t1_059rq7p0002s7xu
  E03 a: label:e03_a _id_1894u2t _a_0ao227p00020xo5
  E03 b: label:e03_b _id_gxfws9 _a_059rq7p0002us7i
  E03 result: label:e03_a _id_1894u2t _a_0ao227p00020xo5 label:e03_b _id_gxfws9 _t1_059rq7p0002us7i
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
  E07 result: label:e07_a _id_sajkoc _a_zze1zs label:e07_b _id_1io1r06 _a_7p0002hevr _t1_4ebhyt
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
  E13 result: label:e13_a _id_1rl4bhy _a_2y6oc4eka7d label:e13_b _id_1kswgxt _t1_uo5714ehng9
  E14 a: label:e14_a _id_l4w2s0 _a_2y6oc4evzik
  E14 b: label:e14_b _id_1lq5nuv _a_xmsc94ee0l8
  E14 result: label:e14_a _id_l4w2s0 _a_2y6oc4evzik label:e14_b _id_1lq5nuv _t1_xmsc94ee0l8
  E15 a: label:e15_a _id_1i263tt _a_7pi834
  E15 b: label:e15_b _id_tdw72g _a_7p0002ul8g
  E15 result: label:e15_a _id_1i263tt _a_7pi834 label:e15_b _id_tdw72g _a_7p0002ul8g
  E16 a: label:e16_a _id_1i6xrdx _a_940002igrf
  E16 b: label:e16_b _id_1syppgx _a_94se6h
  E16 result: label:e16_a _id_1i6xrdx label:e16_b _id_1syppgx _a_94se6h
  E17 a: label:e17_a _id_yee9vw _a_3h0cn4vq7p _a_qyw7u3h0cn4ey88
  E17 a style: --e17_v1-1w2tyhh:rgb(27, 0, 0)
  E17 b: label:e17_b _id_dw56fu _a_3h0cn4xj20
  E17 result: label:e17_a _id_yee9vw _a_qyw7u3h0cn4ey88 label:e17_b _id_dw56fu _a_3h0cn4xj20
  E17 result style: --e17_v1-1w2tyhh:rgb(27, 0, 0)
  E18 a: label:e18_a _id_29swre _a_3h00748783 _a_qyw7u3h0074usgf
  E18 a style: --e18_v1-t1ny06:rgb(29, 0, 0)
  E18 b: label:e18_b _id_fv21ql _a_3h0074w57x _a_qyw7u3h0074vd91
  E18 b style: --e18_v2-1bzve6l:rgb(30, 0, 0)
  E18 result: label:e18_a _id_29swre label:e18_b _id_fv21ql _a_3h0074w57x _a_qyw7u3h0074vd91
  E18 result style: --e18_v1-t1ny06:rgb(29, 0, 0);--e18_v2-1bzve6l:rgb(30, 0, 0)
  E19 a: label:e19_a _id_7plkfj _a_1lub32z0008hok3
  E19 b: label:e19_b _id_taocjx _a_x7ow72z5tji
  E19 result: label:e19_a _id_7plkfj _a_1lub32z0008hok3 label:e19_b _id_taocjx _t1_x7ow72z5tji
  E20 a: label:e20_a _id_12atsww _a_2svney
  E20 b: label:e20_b _id_13rm7w3 _a_droigx
  E20 result: label:e20_a _id_12atsww _a_2svney label:e20_b _id_13rm7w3 _a_droigx
  E21 a: label:e21_a _id_vw2ne _a_3h0ljd
  E21 b: label:e21_b _id_pf7vxb _a_3h1ekgwqdq
  E21 result: label:e21_a _id_vw2ne _a_3h0ljd label:e21_b _id_pf7vxb _a_3h1ekgwqdq
  E22 a: label:e22_a _id_1ru0x3 _a_qyw7u3h1lokvz7n
  E22 b: label:e22_b _id_1qzft2x _a_1lub33htomz
  E22 result: label:e22_a _id_1ru0x3 _a_qyw7u3h1lokvz7n label:e22_b _id_1qzft2x _t1_1lub33htomz
  E23 a: label:e23_a _id_188a8wj _a_oe8sa940008llzq
  E23 b: label:e23_b _id_1446a39 _a_cht88948fkm
  E23 result: label:e23_a _id_188a8wj _a_oe8sa940008llzq label:e23_b _id_1446a39 _t1_cht88948fkm
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
  E28 result: label:e28_a _id_eijk8x _a_0kk4l7p0002ejru label:e28_b _id_8eke8l _t1_0aatx7p00022avm
  E29 a: label:e29_a _id_17wzo6n _a_0z6h37p0002b1n2
  E29 b: label:e29_b _id_1n2e1d2 _a_0crm37p00023me0
  E29 result: label:e29_a _id_17wzo6n _a_0z6h37p0002b1n2 label:e29_b _id_1n2e1d2 _t1_0crm37p00023me0
  E30 a: label:e30_a _id_1hjq29l _a_0bwi47p0002asf7
  E30 b: label:e30_b _id_m17h65 _a_0aatx7p0002cgo6
  E30 result: label:e30_a _id_1hjq29l _a_0bwi47p0002asf7 label:e30_b _id_m17h65 _t1_0aatx7p0002cgo6
  E31 result: label:e31 _id_psw2h1 _a_0f0zo7p00024ep7 _t1_0p2f07p0002l0a4
  E32 result: label:e32 _id_15n668e _a_0p2f07p00024j5c _t1_0f0zo7p0002opsv
  E33 result: label:e33 _id_ftiwkg _a_0gqkv7p0002luqw _t1_03qdy7p0002pa78
  E34 result: label:e34 _id_sjtyhp _a_04q027p00028cv9 _t1_0q5or7p0002w9to
  E35 result: label:e35 _id_1fo0xx2 _a_0gqkv7p0002onxl _t1_0f0zo7p0002iivl
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
  E43 result: label:e43_a _id_pvzbp3 _a_qss4z7p0002ywuh label:e43_b _id_13e0y5i _t1_vflny7p0002j2yf
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
  ._a_dzdgw7p00022shq *,._t1_dzdgw7p00022shq:not(x-) *,._t2_dzdgw7p00022shq:not(x-):not(x-) *{margin-left:367px;}
  ._a_exm317p0002zf0w span,._t1_exm317p0002zf0w:not(x-) span,._t2_exm317p0002zf0w:not(x-):not(x-) span{margin-left:369px;}
  ._a_zz00pi,._t1_zz00pi:not(x-),._t2_zz00pi:not(x-):not(x-){all:unset;}
  ._a_5q82ql,._t1_5q82ql:not(x-),._t2_5q82ql:not(x-):not(x-){direction:rtl;}
  ._a_dp3xur,._t1_dp3xur:not(x-),._t2_dp3xur:not(x-):not(x-){unicode-bidi:bidi-override;}
  ._a_zzs30q,._t1_zzs30q:not(x-),._t2_zzs30q:not(x-):not(x-){all:initial;}
  ._a_zyovh2jrusag,._t1_zyovh2jrusag:not(x-),._t2_zyovh2jrusag:not(x-):not(x-){--e06-a:308px;}
  ._a_zzce4j,._t1_zzce4j:not(x-),._t2_zzce4j:not(x-):not(x-){all:revert;}
  ._a_4ebhyt,._t1_4ebhyt:not(x-),._t2_4ebhyt:not(x-):not(x-){color:rgb(10, 0, 0);}
  ._a_zze1zs,._t1_zze1zs:not(x-),._t2_zze1zs:not(x-):not(x-){all:revert-layer;}
  ._a_7q53z7,._t1_7q53z7:not(x-),._t2_7q53z7:not(x-):not(x-){margin-block:315px;}
  ._a_7q4e2p,._t1_7q4e2p:not(x-),._t2_7q4e2p:not(x-):not(x-){margin-block:318px;}
  ._a_71w720,._t1_71w720:not(x-),._t2_71w720:not(x-):not(x-){inset:319px;}
  ._a_7pi834,._t1_7pi834:not(x-),._t2_7pi834:not(x-):not(x-){margin:var(--e15-x);}
  ._a_94se6h,._t1_94se6h:not(x-),._t2_94se6h:not(x-):not(x-){padding:var(--e16-x);}
  ._a_droigx,._t1_droigx:not(x-),._t2_droigx:not(x-):not(x-){-webkit-user-select:text;-moz-user-select:text;-ms-user-select:text;user-select:text;}
  ._a_2svney,._t1_2svney:not(x-),._t2_2svney:not(x-):not(x-){-webkit-user-select:none;}
  ._a_3h0ljd,._t1_3h0ljd:not(x-),._t2_3h0ljd:not(x-):not(x-){border:333px solid rgb(34, 0, 0);}
  ._a_7puinr,._t1_7puinr:not(x-),._t2_7puinr:not(x-):not(x-){margin:343px;}
  ._a_zys35fv8j1n8,._t1_zys35fv8j1n8:not(x-),._t2_zys35fv8j1n8:not(x-):not(x-){--e40-x:375px;}
  ._a_zy13yy5e8vw2,._t1_zy13yy5e8vw2:not(x-),._t2_zy13yy5e8vw2:not(x-):not(x-){--e41-x:377px;}
  ._a_zyo7exr1amxx,._t1_zyo7exr1amxx:not(x-),._t2_zyo7exr1amxx:not(x-):not(x-){--e41-y:378px;}
  ._a_8xpt08,._t1_8xpt08:not(x-),._t2_8xpt08:not(x-):not(x-){word-wrap:break-word;}
  ._a_8x4jlj,._t1_8x4jlj:not(x-),._t2_8x4jlj:not(x-):not(x-){overflow-wrap:anywhere;}
  ._a_7p0002ms4m,._t1_7p0002ms4m:not(x-),._t2_7p0002ms4m:not(x-):not(x-){margin-left:301px;}
  ._a_7p00022kq6,._t1_7p00022kq6:not(x-),._t2_7p00022kq6:not(x-):not(x-){margin-left:307px;}
  ._a_7p0002hevr,._t1_7p0002hevr:not(x-),._t2_7p0002hevr:not(x-):not(x-){margin-left:309px;}
  ._a_9400026cxn,._t1_9400026cxn:not(x-),._t2_9400026cxn:not(x-):not(x-){padding-left:311px;}
  ._a_960002o2m7,._t1_960002o2m7:not(x-),._t2_960002o2m7:not(x-):not(x-){-webkit-padding-start:312px;padding-inline-start:312px;}
  ._a_940004c0kc,._t1_940004c0kc:not(x-),._t2_940004c0kc:not(x-):not(x-){padding-right:313px;}
  ._a_960001qh3g,._t1_960001qh3g:not(x-),._t2_960001qh3g:not(x-):not(x-){-webkit-padding-end:314px;padding-inline-end:314px;}
  ._a_7p0008viu6,._t1_7p0008viu6:not(x-),._t2_7p0008viu6:not(x-):not(x-){margin-top:316px;}
  ._a_7p0001c2pf,._t1_7p0001c2pf:not(x-),._t2_7p0001c2pf:not(x-):not(x-){margin-bottom:317px;}
  ._a_71000862dn,._t1_71000862dn:not(x-),._t2_71000862dn:not(x-):not(x-){top:320px;}
  ._a_7p0002ul8g,._t1_7p0002ul8g:not(x-),._t2_7p0002ul8g:not(x-):not(x-){margin-left:325px;}
  ._a_940002igrf,._t1_940002igrf:not(x-),._t2_940002igrf:not(x-):not(x-){padding-left:326px;}
  ._a_oe8sa940008llzq,._t1_oe8sa940008llzq:not(x-),._t2_oe8sa940008llzq:not(x-):not(x-){padding-top:340px !important;}
  ._a_7p0002d4qg,._t1_7p0002d4qg:not(x-),._t2_7p0002d4qg:not(x-):not(x-){margin-left:342px;}
  ._a_7p0002cqrw,._t1_7p0002cqrw:not(x-),._t2_7p0002cqrw:not(x-):not(x-){margin-left:344px;}
  ._a_7p00028sx6,._t1_7p00028sx6:not(x-),._t2_7p00028sx6:not(x-):not(x-){margin-left:345px;}
  ._a_7p00026rac,._t1_7p00026rac:not(x-),._t2_7p00026rac:not(x-):not(x-){margin-left:347px;}
  ._a_7p00023ace,._t1_7p00023ace:not(x-),._t2_7p00023ace:not(x-):not(x-){margin-left:348px;}
  ._a_7p00021if4,._t1_7p00021if4:not(x-),._t2_7p00021if4:not(x-):not(x-){margin-left:349px;}
  ._a_7p0002pqxt,._t1_7p0002pqxt:not(x-),._t2_7p0002pqxt:not(x-):not(x-){margin-left:368px;}
  ._a_7p0002gxxs,._t1_7p0002gxxs:not(x-),._t2_7p0002gxxs:not(x-):not(x-){margin-left:370px;}
  ._a_7p0002yrio,._t1_7p0002yrio:not(x-),._t2_7p0002yrio:not(x-):not(x-){margin-left:372px;}
  ._a_7p0002t7fr,._t1_7p0002t7fr:not(x-),._t2_7p0002t7fr:not(x-):not(x-){margin-left:374px;}
  ._a_7p00022k5d,._t1_7p00022k5d:not(x-),._t2_7p00022k5d:not(x-):not(x-){margin-left:381px;margin-left:382px;}
  ._a_710002ejjz,._t1_710002ejjz:not(x-),._t2_710002ejjz:not(x-):not(x-){left:383px;}
  ._a_740002s0x2,._t1_740002s0x2:not(x-),._t2_740002s0x2:not(x-):not(x-){inset-inline-start:384px;}
  ._a_3h0cn4vq7p,._t1_3h0cn4vq7p:not(x-),._t2_3h0cn4vq7p:not(x-):not(x-){border-top-color:var(--e17_v1-1w2tyhh);}
  ._a_3h0cn4xj20,._t1_3h0cn4xj20:not(x-),._t2_3h0cn4xj20:not(x-):not(x-){border-top-color:rgb(28, 0, 0);}
  ._a_3h00748783,._t1_3h00748783:not(x-),._t2_3h00748783:not(x-):not(x-){border-left-color:var(--e18_v1-t1ny06);}
  ._a_3h0074w57x,._t1_3h0074w57x:not(x-),._t2_3h0074w57x:not(x-):not(x-){border-left-color:var(--e18_v2-1bzve6l);}
  ._a_3h1ekgwqdq,._t1_3h1ekgwqdq:not(x-),._t2_3h1ekgwqdq:not(x-):not(x-){border-top-width:335px;}
  ._a_1lub33htomz:focus,._t1_1lub33htomz:not(x-):focus,._t2_1lub33htomz:not(x-):not(x-):focus{border:337px solid rgb(38, 0, 0);border-top-width:339px;}
  ._a_x7ow72z5tji:active,._t1_x7ow72z5tji:not(x-):active,._t2_x7ow72z5tji:not(x-):not(x-):active{-webkit-animation:332s ease;animation:332s ease;}
  ._a_2y6oc4eka7d::before,._t1_2y6oc4eka7d:not(x-)::before,._t2_2y6oc4eka7d:not(x-):not(x-)::before{color:rgb(21, 0, 0);}
  ._a_uo5714ehng9::after,._t1_uo5714ehng9:not(x-)::after,._t2_uo5714ehng9:not(x-):not(x-)::after{color:rgb(22, 0, 0);}
  ._a_2y6oc4evzik::before,._t1_2y6oc4evzik:not(x-)::before,._t2_2y6oc4evzik:not(x-):not(x-)::before{color:rgb(23, 0, 0);}
  ._a_xmsc94ee0l8:hover::before,._t1_xmsc94ee0l8:not(x-):hover::before,._t2_xmsc94ee0l8:not(x-):not(x-):hover::before{color:rgb(24, 0, 0);}
  @media (max-width: 1200px) {._a_cht88948fkm,._t1_cht88948fkm:not(x-),._t2_cht88948fkm:not(x-):not(x-){padding:341px !important;}}
  @media (max-width: 1200px) {._a_0p2f0zys35fv8rtiz,._t1_0p2f0zys35fv8rtiz:not(x-),._t2_0p2f0zys35fv8rtiz:not(x-):not(x-){--e40-x:376px;}}
  ._a_qyw7u3h1lokvz7n:hover,._t1_qyw7u3h1lokvz7n:not(x-):hover,._t2_qyw7u3h1lokvz7n:not(x-):not(x-):hover{border-width:336px;}
  ._a_qyw7u7p00028sdg:hover,._t1_qyw7u7p00028sdg:not(x-):hover,._t2_qyw7u7p00028sdg:not(x-):not(x-):hover{margin-left:350px;}
  ._a_1lub32z0008hok3:focus,._t1_1lub32z0008hok3:not(x-):focus,._t2_1lub32z0008hok3:not(x-):not(x-):focus{-webkit-animation-duration:331s;animation-duration:331s;}
  ._a_vflny7p0002j2yf:active:first-child,._t1_vflny7p0002j2yf:not(x-):active:first-child,._t2_vflny7p0002j2yf:not(x-):not(x-):active:first-child{margin-left:380px;}
  ._a_qss4z7p0002ywuh:hover:focus-within,._t1_qss4z7p0002ywuh:not(x-):hover:focus-within,._t2_qss4z7p0002ywuh:not(x-):not(x-):hover:focus-within{margin-left:379px;}
  @supports (display: grid) {._a_059rq7p0002r214,._t1_059rq7p0002r214:not(x-),._t2_059rq7p0002r214:not(x-):not(x-){margin-left:302px;}}
  @supports (display: grid) {._a_059rq7p0002s7xu,._t1_059rq7p0002s7xu:not(x-),._t2_059rq7p0002s7xu:not(x-):not(x-){margin-left:304px;}}
  @supports (display: grid) {._a_059rq7p0002us7i,._t1_059rq7p0002us7i:not(x-),._t2_059rq7p0002us7i:not(x-):not(x-){margin-left:305px;}}
  @supports (display: flex) {._a_0ao227p00020xo5,._t1_0ao227p00020xo5:not(x-),._t2_0ao227p00020xo5:not(x-):not(x-){margin-left:306px;}}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l7p0002ejru,._t1_0kk4l7p0002ejru:not(x-),._t2_0kk4l7p0002ejru:not(x-):not(x-){margin-left:351px;}}}
  @media (max-width: 1200px) {._a_0p2f07p0002so52,._t1_0p2f07p0002so52:not(x-),._t2_0p2f07p0002so52:not(x-):not(x-){margin-left:303px;}}
  @media (max-width: 1200px) {._a_0p2f07p0002y0kt,._t1_0p2f07p0002y0kt:not(x-),._t2_0p2f07p0002y0kt:not(x-):not(x-){margin-left:346px;}}
  @media (max-width: 1100px) {._a_0aatx7p00022avm,._t1_0aatx7p00022avm:not(x-),._t2_0aatx7p00022avm:not(x-):not(x-){margin-left:352px;}}
  @media (max-width: 1200px) {@container app-main (max-width: 900px) {._a_0z6h37p0002b1n2,._t1_0z6h37p0002b1n2:not(x-),._t2_0z6h37p0002b1n2:not(x-):not(x-){margin-left:353px;}}}
  @media (max-width: 1200px) {@container app-main (max-width: 1000px) {._a_0bwi47p0002asf7,._t1_0bwi47p0002asf7:not(x-),._t2_0bwi47p0002asf7:not(x-):not(x-){margin-left:355px;}}}
  @media (max-width: 1100px) {._a_0aatx7p0002cgo6,._t1_0aatx7p0002cgo6:not(x-),._t2_0aatx7p0002cgo6:not(x-):not(x-){margin-left:356px;}}
  @media (max-width: 900px) and (not (max-width: 1200px)){._a_0f0zo7p00024ep7,._t1_0f0zo7p00024ep7:not(x-),._t2_0f0zo7p00024ep7:not(x-):not(x-){margin-left:357px;}}
  @media (max-width: 1200px) {._a_0p2f07p0002l0a4,._t1_0p2f07p0002l0a4:not(x-),._t2_0p2f07p0002l0a4:not(x-):not(x-){margin-left:358px;}}
  @media (max-width: 1200px) and (not (max-width: 900px)){._a_0p2f07p00024j5c,._t1_0p2f07p00024j5c:not(x-),._t2_0p2f07p00024j5c:not(x-):not(x-){margin-left:359px;}}
  @media (max-width: 900px) {._a_0f0zo7p0002opsv,._t1_0f0zo7p0002opsv:not(x-),._t2_0f0zo7p0002opsv:not(x-):not(x-){margin-left:360px;}}
  @media screen and (max-width: 1200px) and (not (max-width: 900px)){._a_0gqkv7p0002luqw,._t1_0gqkv7p0002luqw:not(x-),._t2_0gqkv7p0002luqw:not(x-):not(x-){margin-left:361px;}}
  @media screen and (max-width: 900px) {._a_03qdy7p0002pa78,._t1_03qdy7p0002pa78:not(x-),._t2_03qdy7p0002pa78:not(x-):not(x-){margin-left:362px;}}
  @media not screen and (min-width: 1200px) {._a_04q027p00028cv9,._t1_04q027p00028cv9:not(x-),._t2_04q027p00028cv9:not(x-):not(x-){margin-left:363px;}}
  @media not screen and (min-width: 900px) {._a_0q5or7p0002w9to,._t1_0q5or7p0002w9to:not(x-),._t2_0q5or7p0002w9to:not(x-):not(x-){margin-left:364px;}}
  @media screen and (max-width: 1200px) {._a_0gqkv7p0002onxl,._t1_0gqkv7p0002onxl:not(x-),._t2_0gqkv7p0002onxl:not(x-):not(x-){margin-left:365px;}}
  @media (max-width: 900px) {._a_0f0zo7p0002iivl,._t1_0f0zo7p0002iivl:not(x-),._t2_0f0zo7p0002iivl:not(x-):not(x-){margin-left:366px;}}
  @container app-main (max-width: 1000px) {._a_0crm37p00023me0,._t1_0crm37p00023me0:not(x-),._t2_0crm37p00023me0:not(x-):not(x-){margin-left:354px;}}
  ._a_qyw7u3h0cn4ey88:hover,._t1_qyw7u3h0cn4ey88:not(x-):hover,._t2_qyw7u3h0cn4ey88:not(x-):not(x-):hover{border-top-color:var(--e17_v1-1w2tyhh);}
  ._a_qyw7u3h0074usgf:hover,._t1_qyw7u3h0074usgf:not(x-):hover,._t2_qyw7u3h0074usgf:not(x-):not(x-):hover{border-left-color:var(--e18_v1-t1ny06);}
  ._a_qyw7u3h0074vd91:hover,._t1_qyw7u3h0074vd91:not(x-):hover,._t2_qyw7u3h0074vd91:not(x-):not(x-):hover{border-left-color:var(--e18_v2-1bzve6l);}
