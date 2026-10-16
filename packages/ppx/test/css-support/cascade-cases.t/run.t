Pins how `CSS.merge` and the stylesheet order resolve every kind of competing
declaration pair found in the Ahrefs monorepo, as one case per class (C01 to
C49, plus the swapped-file variants C29S and C37S). Each case sits above its
code in `input.re` with its classification and the author's intended
winner. Every value is unique to its case, so no atom is shared between cases
and the sheet shows each pair on its own.

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
  C01 a: label:c01_a _id_nf36w0 _a_7p00024mrz
  C01 b: label:c01_b _id_1ovy1cv _a_7p0002b1lg
  C01 result: label:c01_a _id_nf36w0 label:c01_b _id_1ovy1cv _a_7p0002b1lg
  C02 a: label:c02_a _id_pbrv6t _a_7p0002ysfb
  C02 b: label:c02_b _id_y4dpx6 _a_oe8sa7p00027kik
  C02 result: label:c02_a _id_pbrv6t _a_7p0002ysfb label:c02_b _id_y4dpx6 _a_oe8sa7p00027kik
  C03 a: label:c03_a _id_10s6gz9 _a_oe8sa7p0002kr08
  C03 b: label:c03_b _id_1uqdfo7 _a_7p00025qeb
  C03 result: label:c03_a _id_10s6gz9 _a_oe8sa7p0002kr08 label:c03_b _id_1uqdfo7 _a_7p00025qeb
  C04 ctx c04_sticky: label:c04_sticky _id_xis9zs
  C04 a: label:c04_a _id_11pivyj _a_7p0002790s
  C04 b: label:c04_b _id_1giacbo _a_6mxey7p00022ydp
  C04 result: label:c04_a _id_11pivyj _a_7p0002790s label:c04_b _id_1giacbo _a_6mxey7p00022ydp
  C05 a: label:c05_a _id_ze6f3u _a_ekl7q7p0002lpe2
  C05 b: label:c05_b _id_xojpie _a_7p0002ix26
  C05 result: label:c05_a _id_ze6f3u _a_ekl7q7p0002lpe2 label:c05_b _id_xojpie _a_7p0002ix26
  C06 a: label:c06_a _id_9h2ksf _a_7p0002zb3m
  C06 b: label:c06_b _id_1a3a86h _a_08cqd7p0002hw65
  C06 result: label:c06_a _id_9h2ksf _a_7p0002zb3m label:c06_b _id_1a3a86h _a_08cqd7p0002hw65
  C07 a: label:c07_a _id_l80pc8 _a_0p2f07p0002rqkl
  C07 b: label:c07_b _id_1burhrp _a_0m2ng7p0002mf8b
  C07 result: label:c07_a _id_l80pc8 _a_0p2f07p0002rqkl label:c07_b _id_1burhrp _t1_0m2ng7p0002mf8b
  C08 a: label:c08_a _id_1ockbuu _a_3hxp00
  C08 a style: --c08_a_v1-1lvioua:rgb(116, 0, 0)
  C08 b: label:c08_b _id_1e5sasy _a_3h0007alxb
  C08 result: label:c08_a _id_1ockbuu _a_3hxp00 label:c08_b _id_1e5sasy _a_3h0007alxb
  C08 result style: --c08_a_v1-1lvioua:rgb(116, 0, 0)
  C09 a: label:c09_a _id_hceiu2 _a_7prubs
  C09 b: label:c09_b _id_ut9754 _a_7p00024dth
  C09 result: label:c09_a _id_hceiu2 _a_7prubs label:c09_b _id_ut9754 _a_7p00024dth
  C10 a: label:c10_a _id_9tijwd _a_040pk7p00021f9x
  C10 b: label:c10_b _id_18mu5ns _a_0weld7p000220ko
  C10 result: label:c10_a _id_9tijwd _a_040pk7p00021f9x label:c10_b _id_18mu5ns _t1_0weld7p000220ko
  C11 a: label:c11_a _id_1of8059 _a_hilvs7p0002pol0
  C11 b: label:c11_b _id_1x85356 _a_h5nao7p0002a83i
  C11 result: label:c11_a _id_1of8059 _a_hilvs7p0002pol0 label:c11_b _id_1x85356 _t1_h5nao7p0002a83i
  C12 ctx c12_selected: label:c12_selected _id_1e5bhwu
  C12 a: label:c12_a _id_1vocoou _a_17qp47p00020gi1
  C12 b: label:c12_b _id_13qlz5s _a_bba1b7p0002nc5q
  C12 result: label:c12_a _id_1vocoou _a_17qp47p00020gi1 label:c12_b _id_13qlz5s _t1_bba1b7p0002nc5q
  C13 a: label:c13_a _id_10r8ilv _a_08cqd7p0002t29f
  C13 b: label:c13_b _id_15lqjan _a_7p00021n1i
  C13 result: label:c13_a _id_10r8ilv label:c13_b _id_15lqjan _a_7p00021n1i
  C14 a: label:c14_a _id_1bf4umr _a_0m2ng7p0002uwms
  C14 b: label:c14_b _id_q7vaei _a_0p2f07p00029z3v
  C14 result: label:c14_a _id_1bf4umr _a_0m2ng7p0002uwms label:c14_b _id_q7vaei _t1_0p2f07p00029z3v
  C15 a: label:c15_a _id_v7nmed _a_h5nao7p0002e4q0
  C15 b: label:c15_b _id_103qmrm _a_hilvs7p0002l88o
  C15 result: label:c15_a _id_v7nmed _a_h5nao7p0002e4q0 label:c15_b _id_103qmrm _t1_hilvs7p0002l88o
  C16 a: label:c16_a _id_1yqfcxe _a_940008sfay
  C16 b: label:c16_b _id_1v9j5os _a_0eyct94bgtl
  C16 result: label:c16_a _id_1yqfcxe _a_940008sfay label:c16_b _id_1v9j5os _a_0eyct94bgtl
  C17 ctx c17_buttonDisabled: label:c17_buttonDisabled _id_1447smv
  C17 a: label:c17_a _id_5opoy _a_zljev7p00023unn
  C17 b: label:c17_b _id_1kn9kpj _a_17qp47p0002c72t
  C17 result: label:c17_a _id_5opoy _a_zljev7p00023unn label:c17_b _id_1kn9kpj _t1_17qp47p0002c72t
  C18 a: label:c18_a _id_eyloby _a_3h1lok4jf1
  C18 b: label:c18_b _id_qg1xdk _a_3h000740we
  C18 b style: --c18_b_v1-vt5hie:rgb(138, 0, 0)
  C18 result: label:c18_a _id_eyloby _a_3h1lok4jf1 label:c18_b _id_qg1xdk _t1_3h000740we
  C18 result style: --c18_b_v1-vt5hie:rgb(138, 0, 0)
  C19 a: label:c19_a _id_1bflcs3 _a_0lkns94z9it
  C19 a style: --c19_a_v1-1g9lghy:139px;--c19_a_v2-10uwx3v:140px;--c19_a_v3-b504ir:141px;--c19_a_v4-19o2xwm:142px
  C19 b: label:c19_b _id_1jo0oq _a_0yyk8940001e01b
  C19 b style: --c19_b_v1-64pxg7:143px
  C19 result: label:c19_a _id_1bflcs3 _a_0lkns94z9it label:c19_b _id_1jo0oq _t1_0yyk8940001e01b
  C19 result style: --c19_a_v1-1g9lghy:139px;--c19_a_v2-10uwx3v:140px;--c19_a_v3-b504ir:141px;--c19_a_v4-19o2xwm:142px;--c19_b_v1-64pxg7:143px
  C20 a: label:c20_a _id_oo5y04 _a_beqwm7p000280q7
  C20 b: label:c20_b _id_1h4wcvr _a_t48el7p0002w5n3
  C20 result: label:c20_a _id_oo5y04 _a_beqwm7p000280q7 label:c20_b _id_1h4wcvr _t1_t48el7p0002w5n3
  C21 a: label:c21_a _id_o820es _a_94erbd
  C21 b: label:c21_b _id_1b316ye _a_0lkns940008gk6l
  C21 result: label:c21_a _id_o820es _a_94erbd label:c21_b _id_1b316ye _a_0lkns940008gk6l
  C22 ctx c22_inputNoBorder: label:c22_inputNoBorder _id_1eh3ga9
  C22 ctx c22_inputError: label:c22_inputError _id_1m4arcl
  C22 a: label:c22_a _id_bpr44t _a_yj3qo7p0002mrog
  C22 a style: --c22_a_v1-15yxvdj:149px
  C22 b: label:c22_b _id_irsigq _a_3lk567p0002iyo5
  C22 result: label:c22_a _id_bpr44t _a_yj3qo7p0002mrog label:c22_b _id_irsigq _t1_3lk567p0002iyo5
  C22 result style: --c22_a_v1-15yxvdj:149px
  C23 a: label:c23_a _id_1h4k8vt _a_psx2i7p00021r9j
  C23 b: label:c23_b _id_rhiltm _a_wnwbp7p0002ydte
  C23 result: label:c23_a _id_1h4k8vt _a_psx2i7p00021r9j label:c23_b _id_rhiltm _t1_wnwbp7p0002ydte
  C24 a: label:c24_a _id_a7zc2y _a_0eyct9416b1
  C24 b: label:c24_b _id_16r4hzu _a_9400083ump
  C24 result: label:c24_a _id_a7zc2y _a_0eyct9416b1 label:c24_b _id_16r4hzu _t1_9400083ump
  C25 a: label:c25_a _id_dr2emr _a_7l0qc94tmv1
  C25 b: label:c25_b _id_1ucp1kz _a_7l0qc94000496cx
  C25 result: label:c25_a _id_dr2emr _a_7l0qc94tmv1 label:c25_b _id_1ucp1kz _a_7l0qc94000496cx
  C26 ctx c26_buttonSelected: label:c26_buttonSelected _id_1w5r4st
  C26 a: label:c26_a _id_1wu295b _a_1lub38p00028f4e
  C26 b: label:c26_b _id_1a36gtu _a_cx72w8p6gkw
  C26 result: label:c26_a _id_1wu295b _a_1lub38p00028f4e label:c26_b _id_1a36gtu _t1_cx72w8p6gkw
  C27 a: label:c27_a _id_1kul53t _a_0lkns94000130iw
  C27 a style: --c27_a_v1-1hjd3hh:157px
  C27 b: label:c27_b _id_1btrebe _a_0yyk894mf2m
  C27 b style: --c27_b_v1-ecvqql:158px;--c27_b_v2-1cbrlo8:159px;--c27_b_v3-1cwxpmt:160px;--c27_b_v4-1suqbkt:161px
  C27 result: label:c27_a _id_1kul53t _a_0lkns94000130iw label:c27_b _id_1btrebe _t1_0yyk894mf2m
  C27 result style: --c27_a_v1-1hjd3hh:157px;--c27_b_v1-ecvqql:158px;--c27_b_v2-1cbrlo8:159px;--c27_b_v3-1cwxpmt:160px;--c27_b_v4-1suqbkt:161px
  C28 a: label:c28_a _id_1dzye _a_663aw7p0002sqqh
  C28 b: label:c28_b _id_1mqwope _a_4sm4u7p0002v7fa
  C28 result: label:c28_a _id_1dzye _a_663aw7p0002sqqh label:c28_b _id_1mqwope _t1_4sm4u7p0002v7fa
  C29 a: label:c29_a _id_1mnug77 _a_040pk7p0002xply
  C29 b: label:c29_b _id_1h2xeb _a_0eyct7p0002a5oh
  C29 result: label:c29_a _id_1mnug77 _a_040pk7p0002xply label:c29_b _id_1h2xeb _t1_0eyct7p0002a5oh
  C29S a: label:c29s_a _id_1lq16sq _a_040pk7p00026vnd
  C29S b: label:c29s_b _id_9quai9 _a_0eyct7p0002un4b
  C29S result: label:c29s_a _id_1lq16sq _a_040pk7p00026vnd label:c29s_b _id_9quai9 _t1_0eyct7p0002un4b
  C30 result: label:c30 _id_1c4z69j _a_2zdht7p0002udu7 _t1_6d4lr7p0002li07
  C31 a: label:c31_a _id_122vg2n _a_4sm4u7p0002f318
  C31 b: label:c31_b _id_1a5cy56 _a_663aw7p0002rbvl
  C31 result: label:c31_a _id_122vg2n _a_4sm4u7p0002f318 label:c31_b _id_1a5cy56 _t1_663aw7p0002rbvl
  C32 a: label:c32_a _id_1ek8295 _a_1lub38p0002xhxr
  C32 b: label:c32_b _id_1ggv8nb _a_x7ow78plm9p
  C32 result: label:c32_a _id_1ek8295 _a_1lub38p0002xhxr label:c32_b _id_1ggv8nb _t1_x7ow78plm9p
  C33 a: label:c33_a _id_8pspmu _a_wnwbp7p0002eund
  C33 b: label:c33_b _id_48ih9p _a_psx2i7p0002srlh
  C33 result: label:c33_a _id_8pspmu _a_wnwbp7p0002eund label:c33_b _id_48ih9p _t1_psx2i7p0002srlh
  C34 a: label:c34_a _id_14o83mv _a_0fdgq7p0002ppya _a_17qp47p0002za44
  C34 a style: --c34_a_v1-1xdslk1:175px
  C34 b: label:c34_b _id_7tm2kg _a_0p2f07p0002l8pl
  C34 result: label:c34_a _id_14o83mv _a_0fdgq7p0002ppya _a_17qp47p0002za44 label:c34_b _id_7tm2kg _t1_0p2f07p0002l8pl
  C34 result style: --c34_a_v1-1xdslk1:175px
  C35 ctx c35_rowIndented: label:c35_rowIndented _id_66z6xh
  C35 a: label:c35_a _id_1edop6 _a_r9p3l940002omym _t1_17qp4940002hn6x
  C35 a style: --c35_a_v1-qbjrz1:177px
  C35 b: label:c35_b _id_113wuow _a_y3idz940002rflh
  C35 b style: --c35_b_v1-19zf6xg:178px
  C35 result: label:c35_a _id_1edop6 _a_r9p3l940002omym _t1_17qp4940002hn6x label:c35_b _id_113wuow _t2_y3idz940002rflh
  C35 result style: --c35_a_v1-qbjrz1:177px;--c35_b_v1-19zf6xg:178px
  C36 result: label:c36 _id_vs7wv6 _a_ekl7q7p00024ttg _t1_f6v007p0002vsgb
  C37 a: label:c37_a _id_1tncjsd _a_7p0002t5hr
  C37 b: label:c37_b _id_m4d4by _a_7p0002mqyv _a_17qp47p0002amml
  C37 b style: --c37_b_v1-la3zpt:182px
  C37 result: label:c37_a _id_1tncjsd label:c37_b _id_m4d4by _a_7p0002mqyv _a_17qp47p0002amml
  C37 result style: --c37_b_v1-la3zpt:182px
  C37S a: label:c37s_a _id_pksthw _a_7p00026q98
  C37S b: label:c37s_b _id_1n23q75 _a_7p0002ahz1 _a_17qp47p0002gbux
  C37S b style: --c37s_b_v1-s4zg91:184px
  C37S result: label:c37s_a _id_pksthw label:c37s_b _id_1n23q75 _a_7p0002ahz1 _a_17qp47p0002gbux
  C37S result style: --c37s_b_v1-s4zg91:184px
  C38 a: label:c38_a _id_ug3vas _a_ugao67p0002qgqh
  C38 b: label:c38_b _id_v1li1d _a_ra8lm7p0002tc72
  C38 result: label:c38_a _id_ug3vas _a_ugao67p0002qgqh label:c38_b _id_v1li1d _t1_ra8lm7p0002tc72
  C39 result: label:c39 _id_6d8oqf _a_ekl7q3h2ghsq4mq _t1_qyw7u3h0pa8a83z
  C40 result: label:c40 _id_bzqj9h _a_27csn9400010i0u _t1_zucss94w4l0
  C40 result style: --c40_v1-1bz5jgd:189px;--c40_v2-1dn44o2:190px
  C41 ctx c41_tbody: label:c41_tbody _id_vm645b
  C41 ctx c41_rowTitleAlwaysVisible: label:c41_rowTitleAlwaysVisible _id_19bya77
  C41 result: label:c41 _id_12z3w26 _a_eda5c940008zrmd _t1_corib940008om9n _t2_17qp4940008w08x
  C41 result style: --c41_v1-1j6wafs:192px
  C42 result: label:c42 _id_rfojbb _a_izmu294lxcy _t1_e6xeu940008in7j
  C43 a: label:c43_a _id_15u1vzy _a_0lkns7p00086ndg
  C43 b: label:c43_b _id_1axilhb _a_7potxt _a_17qp47pjtlz
  C43 b style: --c43_b_v1-1xvqxy7:199px
  C43 result: label:c43_a _id_15u1vzy label:c43_b _id_1axilhb _a_7potxt _a_17qp47pjtlz
  C43 result style: --c43_b_v1-1xvqxy7:199px
  C44 result: label:c44 _id_15q2cly _a_kiios3h1lokcxkw _t1_vo2ns3h0004edka
  C45 ctx c45_compactButtonLeft: label:c45_compactButtonLeft _id_z1l0g2
  C45 result: label:c45 _id_1dru6e3 _a_9zbjd3h01dsiu0r _t1_17qp43h01ds9n0w _t2_17qp43h0ef5ui7a
  C45 result style: --c45_v1-19lye7:rgb(204, 0, 0);--c45_v2-1h7t4j3:rgb(205, 0, 0)
  C46 result: label:c46 _id_1u8w2oz _a_2y6oc2z0008jmji _t1_ra0y62zvxvs
  C47 ctx c47_headerMenuOpened: label:c47_headerMenuOpened _id_15bl859
  C47 result: label:c47 _id_1p3m5s4 _a_x5wnr7p0002waqg _t1_17qp47p00027rpw _t2_qyw7u7p0002jdb0 _t2_17qp47p0002hium
  C47 result style: --c47_v1-1hv8o2g:208px;--c47_v2-sxcaga:209px
  C48 result: label:c48 _id_1t3pmcy _a_otmai7p0002nesm _t1_glkoj7p0002viye
  C49 result: label:c49 _id_24diba _a_2cunn3h0ef5s3e1 _t1_f1m0m3hag2y

The stylesheet, from the same post-PPX files the executable was built from, so
its classes are the ones printed above:

  $ styled-ppx.generate _build/default/*.re.pp.ml
  /* This file is generated by styled-ppx, do not edit manually */
  @property --c37_b_v1-la3zpt{syntax:"*";inherits:false;}
  @property --c37s_b_v1-s4zg91{syntax:"*";inherits:false;}
  @property --c08_a_v1-1lvioua{syntax:"*";inherits:false;}
  @property --c18_b_v1-vt5hie{syntax:"*";inherits:false;}
  @property --c19_a_v1-1g9lghy{syntax:"*";inherits:false;}
  @property --c19_a_v2-10uwx3v{syntax:"*";inherits:false;}
  @property --c19_a_v3-b504ir{syntax:"*";inherits:false;}
  @property --c19_a_v4-19o2xwm{syntax:"*";inherits:false;}
  @property --c19_b_v1-64pxg7{syntax:"*";inherits:false;}
  @property --c22_a_v1-15yxvdj{syntax:"*";inherits:false;}
  @property --c27_a_v1-1hjd3hh{syntax:"*";inherits:false;}
  @property --c27_b_v1-ecvqql{syntax:"*";inherits:false;}
  @property --c27_b_v2-1cbrlo8{syntax:"*";inherits:false;}
  @property --c27_b_v3-1cwxpmt{syntax:"*";inherits:false;}
  @property --c27_b_v4-1suqbkt{syntax:"*";inherits:false;}
  @property --c34_a_v1-1xdslk1{syntax:"*";inherits:false;}
  @property --c35_a_v1-qbjrz1{syntax:"*";inherits:false;}
  @property --c35_b_v1-19zf6xg{syntax:"*";inherits:false;}
  @property --c41_v1-1j6wafs{syntax:"*";inherits:false;}
  @property --c43_b_v1-1xvqxy7{syntax:"*";inherits:false;}
  @property --c45_v1-19lye7{syntax:"*";inherits:false;}
  @property --c45_v2-1h7t4j3{syntax:"*";inherits:false;}
  @property --c47_v1-1hv8o2g{syntax:"*";inherits:false;}
  @property --c47_v2-sxcaga{syntax:"*";inherits:false;}
  ._a_7l0qc94tmv1 input,._t1_7l0qc94tmv1:not(x-) input,._t2_7l0qc94tmv1:not(x-):not(x-) input{padding:154px;}
  ._a_izmu294lxcy td,._t1_izmu294lxcy:not(x-) td,._t2_izmu294lxcy:not(x-):not(x-) td{padding:193px 194px;}
  ._a_f1m0m3hag2y input:focus,._t1_f1m0m3hag2y:not(x-) input:focus,._t2_f1m0m3hag2y:not(x-):not(x-) input:focus{border:212px solid rgb(214, 0, 0);}
  ._a_beqwm7p000280q7 svg,._t1_beqwm7p000280q7:not(x-) svg,._t2_beqwm7p000280q7:not(x-):not(x-) svg{margin-left:144px !important;}
  ._a_t48el7p0002w5n3 > svg,._t1_t48el7p0002w5n3:not(x-) > svg,._t2_t48el7p0002w5n3:not(x-):not(x-) > svg{margin-left:145px !important;}
  ._a_psx2i7p00021r9j > a,._t1_psx2i7p00021r9j:not(x-) > a,._t2_psx2i7p00021r9j:not(x-):not(x-) > a{margin-left:150px;}
  ._a_7l0qc94000496cx input,._t1_7l0qc94000496cx:not(x-) input,._t2_7l0qc94000496cx:not(x-):not(x-) input{padding-right:155px;}
  ._a_psx2i7p0002srlh > a,._t1_psx2i7p0002srlh:not(x-) > a,._t2_psx2i7p0002srlh:not(x-):not(x-) > a{margin-left:174px;}
  ._a_ra8lm7p0002tc72 input,._t1_ra8lm7p0002tc72:not(x-) input,._t2_ra8lm7p0002tc72:not(x-):not(x-) input{margin-left:185px !important;}
  ._a_ugao67p0002qgqh > input,._t1_ugao67p0002qgqh:not(x-) > input,._t2_ugao67p0002qgqh:not(x-):not(x-) > input{margin-left:186px !important;}
  ._a_27csn9400010i0u a,._t1_27csn9400010i0u:not(x-) a,._t2_27csn9400010i0u:not(x-):not(x-) a{padding-bottom:var(--c40_v1-1bz5jgd);}
  ._a_kiios3h1lokcxkw td:first-child,._t1_kiios3h1lokcxkw:not(x-) td:first-child,._t2_kiios3h1lokcxkw:not(x-):not(x-) td:first-child{border-width:200px;}
  ._a_2cunn3h0ef5s3e1 input:hover,._t1_2cunn3h0ef5s3e1:not(x-) input:hover,._t2_2cunn3h0ef5s3e1:not(x-):not(x-) input:hover{border-color:rgb(213, 0, 0);}
  ._a_3hxp00,._t1_3hxp00:not(x-),._t2_3hxp00:not(x-):not(x-){border:115px solid var(--c08_a_v1-1lvioua);}
  ._a_3h0007alxb,._t1_3h0007alxb:not(x-),._t2_3h0007alxb:not(x-):not(x-){border-bottom:117px dotted;}
  ._a_7prubs,._t1_7prubs:not(x-),._t2_7prubs:not(x-):not(x-){margin:118px;}
  ._a_3h000740we,._t1_3h000740we:not(x-),._t2_3h000740we:not(x-):not(x-){border-bottom:137px solid var(--c18_b_v1-vt5hie);}
  ._a_94erbd,._t1_94erbd:not(x-),._t2_94erbd:not(x-):not(x-){padding:146px;}
  ._a_cx72w8p6gkw._id_1w5r4st,._t1_cx72w8p6gkw:not(x-)._id_1w5r4st,._t2_cx72w8p6gkw:not(x-):not(x-)._id_1w5r4st{outline:156px dashed red;}
  ._a_7potxt,._t1_7potxt:not(x-),._t2_7potxt:not(x-):not(x-){margin:197px 0 var(--c43_b_v1-1xvqxy7);}
  ._a_9zbjd3h01dsiu0r._id_z1l0g2,._t1_9zbjd3h01dsiu0r:not(x-)._id_z1l0g2,._t2_9zbjd3h01dsiu0r:not(x-):not(x-)._id_z1l0g2{border-left:202px solid var(--c45_v1-19lye7);}
  ._a_7p0002t5hr,._t1_7p0002t5hr:not(x-),._t2_7p0002t5hr:not(x-):not(x-){margin-left:181px;}
  ._a_7p0002mqyv,._t1_7p0002mqyv:not(x-),._t2_7p0002mqyv:not(x-):not(x-){margin-left:var(--c37_b_v1-la3zpt);}
  ._a_7p0002ahz1,._t1_7p0002ahz1:not(x-),._t2_7p0002ahz1:not(x-):not(x-){margin-left:var(--c37s_b_v1-s4zg91);}
  ._a_7p00026q98,._t1_7p00026q98:not(x-),._t2_7p00026q98:not(x-):not(x-){margin-left:183px;}
  ._a_7p00024mrz,._t1_7p00024mrz:not(x-),._t2_7p00024mrz:not(x-):not(x-){margin-left:101px;}
  ._a_7p0002b1lg,._t1_7p0002b1lg:not(x-),._t2_7p0002b1lg:not(x-):not(x-){margin-left:102px;}
  ._a_7p0002ysfb,._t1_7p0002ysfb:not(x-),._t2_7p0002ysfb:not(x-):not(x-){margin-left:103px;}
  ._a_oe8sa7p00027kik,._t1_oe8sa7p00027kik:not(x-),._t2_oe8sa7p00027kik:not(x-):not(x-){margin-left:104px !important;}
  ._a_oe8sa7p0002kr08,._t1_oe8sa7p0002kr08:not(x-),._t2_oe8sa7p0002kr08:not(x-):not(x-){margin-left:105px !important;}
  ._a_7p00025qeb,._t1_7p00025qeb:not(x-),._t2_7p00025qeb:not(x-):not(x-){margin-left:106px;}
  ._a_7p0002790s,._t1_7p0002790s:not(x-),._t2_7p0002790s:not(x-):not(x-){margin-left:107px;}
  ._a_6mxey7p00022ydp._id_xis9zs,._t1_6mxey7p00022ydp:not(x-)._id_xis9zs,._t2_6mxey7p00022ydp:not(x-):not(x-)._id_xis9zs{margin-left:108px;}
  ._a_7p0002ix26,._t1_7p0002ix26:not(x-),._t2_7p0002ix26:not(x-):not(x-){margin-left:110px;}
  ._a_7p0002zb3m,._t1_7p0002zb3m:not(x-),._t2_7p0002zb3m:not(x-):not(x-){margin-left:111px;}
  ._a_7p00024dth,._t1_7p00024dth:not(x-),._t2_7p00024dth:not(x-):not(x-){margin-left:119px;}
  ._a_bba1b7p0002nc5q._id_1e5bhwu,._t1_bba1b7p0002nc5q:not(x-)._id_1e5bhwu,._t2_bba1b7p0002nc5q:not(x-):not(x-)._id_1e5bhwu{margin-left:125px;}
  ._a_7p00021n1i,._t1_7p00021n1i:not(x-),._t2_7p00021n1i:not(x-):not(x-){margin-left:127px;}
  ._a_940008sfay,._t1_940008sfay:not(x-),._t2_940008sfay:not(x-):not(x-){padding-top:132px;}
  ._a_zljev7p00023unn._id_1447smv,._t1_zljev7p00023unn:not(x-)._id_1447smv,._t2_zljev7p00023unn:not(x-):not(x-)._id_1447smv{margin-left:134px;}
  ._a_3h1lok4jf1,._t1_3h1lok4jf1:not(x-),._t2_3h1lok4jf1:not(x-):not(x-){border-width:136px;}
  ._a_3lk567p0002iyo5._id_1eh3ga9,._t1_3lk567p0002iyo5:not(x-)._id_1eh3ga9,._t2_3lk567p0002iyo5:not(x-):not(x-)._id_1eh3ga9{margin-left:148px;}
  ._a_yj3qo7p0002mrog._id_1m4arcl,._t1_yj3qo7p0002mrog:not(x-)._id_1m4arcl,._t2_yj3qo7p0002mrog:not(x-):not(x-)._id_1m4arcl{margin-left:var(--c22_a_v1-15yxvdj);}
  ._a_9400083ump,._t1_9400083ump:not(x-),._t2_9400083ump:not(x-):not(x-){padding-top:153px;}
  ._id_66z6xh ._a_y3idz940002rflh,._id_66z6xh ._t1_y3idz940002rflh:not(x-),._id_66z6xh ._t2_y3idz940002rflh:not(x-):not(x-){padding-left:var(--c35_b_v1-19zf6xg);}
  ._id_vm645b:first-child ._a_eda5c940008zrmd,._id_vm645b:first-child ._t1_eda5c940008zrmd:not(x-),._id_vm645b:first-child ._t2_eda5c940008zrmd:not(x-):not(x-){padding-top:191px;}
  @media (max-width: 767px) {._a_zucss94w4l0 a,._t1_zucss94w4l0:not(x-) a,._t2_zucss94w4l0:not(x-):not(x-) a{padding:188px 0 var(--c40_v2-1dn44o2);}}
  ._a_4sm4u7p0002v7fa:disabled span,._t1_4sm4u7p0002v7fa:not(x-):disabled span,._t2_4sm4u7p0002v7fa:not(x-):not(x-):disabled span{margin-left:163px !important;}
  ._a_4sm4u7p0002f318:disabled span,._t1_4sm4u7p0002f318:not(x-):disabled span,._t2_4sm4u7p0002f318:not(x-):not(x-):disabled span{margin-left:170px !important;}
  ._a_663aw7p0002sqqh:hover span,._t1_663aw7p0002sqqh:not(x-):hover span,._t2_663aw7p0002sqqh:not(x-):not(x-):hover span{margin-left:162px !important;}
  ._a_663aw7p0002rbvl:hover span,._t1_663aw7p0002rbvl:not(x-):hover span,._t2_663aw7p0002rbvl:not(x-):not(x-):hover span{margin-left:171px !important;}
  @media (min-width: 1280px) {._a_wnwbp7p0002ydte > a,._t1_wnwbp7p0002ydte:not(x-) > a,._t2_wnwbp7p0002ydte:not(x-):not(x-) > a{margin-left:151px;}}
  @media (min-width: 768px) and (max-width: 1279px) {._a_2zdht7p0002udu7 th:first-child,._t1_2zdht7p0002udu7:not(x-) th:first-child,._t2_2zdht7p0002udu7:not(x-):not(x-) th:first-child{margin-left:168px;}}
  @media (max-width: 767px) {._a_6d4lr7p0002li07 th:first-child,._t1_6d4lr7p0002li07:not(x-) th:first-child,._t2_6d4lr7p0002li07:not(x-):not(x-) th:first-child{margin-left:169px;}}
  @media (min-width: 1280px) {._a_wnwbp7p0002eund > a,._t1_wnwbp7p0002eund:not(x-) > a,._t2_wnwbp7p0002eund:not(x-):not(x-) > a{margin-left:173px;}}
  @media (max-width: 767px) {._a_e6xeu940008in7j td,._t1_e6xeu940008in7j:not(x-) td,._t2_e6xeu940008in7j:not(x-):not(x-) td{padding-top:195px;}}
  ._a_vo2ns3h0004edka:last-child td,._t1_vo2ns3h0004edka:not(x-):last-child td,._t2_vo2ns3h0004edka:not(x-):not(x-):last-child td{border-bottom-width:201px;}
  ._a_ekl7q3h2ghsq4mq:first-child,._t1_ekl7q3h2ghsq4mq:not(x-):first-child,._t2_ekl7q3h2ghsq4mq:not(x-):not(x-):first-child{border-top:187px dotted red;}
  ._a_17qp47pjtlz:disabled,._t1_17qp47pjtlz:not(x-):disabled,._t2_17qp47pjtlz:not(x-):not(x-):disabled{margin:198px 0 var(--c43_b_v1-1xvqxy7);}
  ._a_17qp43h01ds9n0w:disabled,._t1_17qp43h01ds9n0w:not(x-):disabled,._t2_17qp43h01ds9n0w:not(x-):not(x-):disabled{border-left:203px solid var(--c45_v1-19lye7);}
  ._a_x7ow78plm9p:active,._t1_x7ow78plm9p:not(x-):active,._t2_x7ow78plm9p:not(x-):not(x-):active{outline:172px groove red;}
  @media (max-width: 768px) {._a_0eyct94bgtl,._t1_0eyct94bgtl:not(x-),._t2_0eyct94bgtl:not(x-):not(x-){padding:133px;}}
  @media (max-width: 767px) {._a_0lkns94z9it,._t1_0lkns94z9it:not(x-),._t2_0lkns94z9it:not(x-):not(x-){padding:var(--c19_a_v1-1g9lghy) var(--c19_a_v2-10uwx3v) var(--c19_a_v3-b504ir) var(--c19_a_v4-19o2xwm);}}
  @media (max-width: 768px) {._a_0eyct9416b1,._t1_0eyct9416b1:not(x-),._t2_0eyct9416b1:not(x-):not(x-){padding:152px;}}
  @media (max-width: 1279px) {._a_0yyk894mf2m,._t1_0yyk894mf2m:not(x-),._t2_0yyk894mf2m:not(x-):not(x-){padding:var(--c27_b_v1-ecvqql) var(--c27_b_v2-1cbrlo8) var(--c27_b_v3-1cwxpmt) var(--c27_b_v4-1suqbkt);}}
  @media (prefers-reduced-motion: reduce) {._a_ra0y62zvxvs::before,._t1_ra0y62zvxvs:not(x-)::before,._t2_ra0y62zvxvs:not(x-):not(x-)::before{-webkit-animation:207s ease;animation:207s ease;}}
  ._a_ekl7q7p0002lpe2:first-child,._t1_ekl7q7p0002lpe2:not(x-):first-child,._t2_ekl7q7p0002lpe2:not(x-):not(x-):first-child{margin-left:109px;}
  ._a_ekl7q7p00024ttg:first-child,._t1_ekl7q7p00024ttg:not(x-):first-child,._t2_ekl7q7p00024ttg:not(x-):not(x-):first-child{margin-left:179px;}
  ._a_otmai7p0002nesm:nth-child(2),._t1_otmai7p0002nesm:not(x-):nth-child(2),._t2_otmai7p0002nesm:not(x-):not(x-):nth-child(2){margin-left:210px;}
  ._a_17qp47p0002amml:disabled,._t1_17qp47p0002amml:not(x-):disabled,._t2_17qp47p0002amml:not(x-):not(x-):disabled{margin-left:var(--c37_b_v1-la3zpt);}
  ._a_17qp47p0002gbux:disabled,._t1_17qp47p0002gbux:not(x-):disabled,._t2_17qp47p0002gbux:not(x-):not(x-):disabled{margin-left:var(--c37s_b_v1-s4zg91);}
  ._a_hilvs7p0002pol0:disabled,._t1_hilvs7p0002pol0:not(x-):disabled,._t2_hilvs7p0002pol0:not(x-):not(x-):disabled{margin-left:122px !important;}
  ._a_17qp47p00020gi1:disabled,._t1_17qp47p00020gi1:not(x-):disabled,._t2_17qp47p00020gi1:not(x-):not(x-):disabled{margin-left:124px;}
  ._a_hilvs7p0002l88o:disabled,._t1_hilvs7p0002l88o:not(x-):disabled,._t2_hilvs7p0002l88o:not(x-):not(x-):disabled{margin-left:131px !important;}
  ._a_17qp47p0002c72t:disabled,._t1_17qp47p0002c72t:not(x-):disabled,._t2_17qp47p0002c72t:not(x-):not(x-):disabled{margin-left:135px;}
  ._a_17qp47p0002za44:disabled,._t1_17qp47p0002za44:not(x-):disabled,._t2_17qp47p0002za44:not(x-):not(x-):disabled{margin-left:var(--c34_a_v1-1xdslk1);}
  ._a_17qp4940002hn6x:disabled,._t1_17qp4940002hn6x:not(x-):disabled,._t2_17qp4940002hn6x:not(x-):not(x-):disabled{padding-left:var(--c35_a_v1-qbjrz1);}
  ._a_17qp4940008w08x:disabled,._t1_17qp4940008w08x:not(x-):disabled,._t2_17qp4940008w08x:not(x-):not(x-):disabled{padding-top:var(--c41_v1-1j6wafs);}
  ._a_17qp43h0ef5ui7a:disabled,._t1_17qp43h0ef5ui7a:not(x-):disabled,._t2_17qp43h0ef5ui7a:not(x-):not(x-):disabled{border-color:var(--c45_v2-1h7t4j3);}
  ._a_17qp47p00027rpw:disabled,._t1_17qp47p00027rpw:not(x-):disabled,._t2_17qp47p00027rpw:not(x-):not(x-):disabled{margin-left:var(--c47_v1-1hv8o2g);}
  ._a_17qp47p0002hium:disabled,._t1_17qp47p0002hium:not(x-):disabled,._t2_17qp47p0002hium:not(x-):not(x-):disabled{margin-left:var(--c47_v2-sxcaga);}
  ._a_h5nao7p0002a83i:hover,._t1_h5nao7p0002a83i:not(x-):hover,._t2_h5nao7p0002a83i:not(x-):not(x-):hover{margin-left:123px !important;}
  ._a_h5nao7p0002e4q0:hover,._t1_h5nao7p0002e4q0:not(x-):hover,._t2_h5nao7p0002e4q0:not(x-):not(x-):hover{margin-left:130px !important;}
  ._a_qyw7u7p0002jdb0:hover,._t1_qyw7u7p0002jdb0:not(x-):hover,._t2_qyw7u7p0002jdb0:not(x-):not(x-):hover{margin-left:var(--c47_v2-sxcaga);}
  ._a_1lub38p00028f4e:focus,._t1_1lub38p00028f4e:not(x-):focus,._t2_1lub38p00028f4e:not(x-):not(x-):focus{outline-style:dotted;}
  ._a_1lub38p0002xhxr:focus,._t1_1lub38p0002xhxr:not(x-):focus,._t2_1lub38p0002xhxr:not(x-):not(x-):focus{outline-style:double;}
  ._a_2y6oc2z0008jmji::before,._t1_2y6oc2z0008jmji:not(x-)::before,._t2_2y6oc2z0008jmji:not(x-):not(x-)::before{-webkit-animation-duration:206s;animation-duration:206s;}
  @media print {._a_040pk7p0002xply,._t1_040pk7p0002xply:not(x-),._t2_040pk7p0002xply:not(x-):not(x-){margin-left:164px;}}
  @media (max-width: 768px) {._a_0eyct7p0002a5oh,._t1_0eyct7p0002a5oh:not(x-),._t2_0eyct7p0002a5oh:not(x-):not(x-){margin-left:165px;}}
  @media (max-width: 768px) {._a_0eyct7p0002un4b,._t1_0eyct7p0002un4b:not(x-),._t2_0eyct7p0002un4b:not(x-):not(x-){margin-left:167px;}}
  @media print {._a_040pk7p00026vnd,._t1_040pk7p00026vnd:not(x-),._t2_040pk7p00026vnd:not(x-):not(x-){margin-left:166px;}}
  @media (max-width: 1200px) {._a_0p2f07p0002rqkl,._t1_0p2f07p0002rqkl:not(x-),._t2_0p2f07p0002rqkl:not(x-):not(x-){margin-left:113px;}}
  @media (max-width: 992px) {._a_0m2ng7p0002mf8b,._t1_0m2ng7p0002mf8b:not(x-),._t2_0m2ng7p0002mf8b:not(x-):not(x-){margin-left:114px;}}
  @media print {._a_040pk7p00021f9x,._t1_040pk7p00021f9x:not(x-),._t2_040pk7p00021f9x:not(x-):not(x-){margin-left:120px;}}
  @media (max-width: 1200px) {._a_0p2f07p00029z3v,._t1_0p2f07p00029z3v:not(x-),._t2_0p2f07p00029z3v:not(x-):not(x-){margin-left:128px;}}
  @media (max-width: 992px) {._a_0m2ng7p0002uwms,._t1_0m2ng7p0002uwms:not(x-),._t2_0m2ng7p0002uwms:not(x-):not(x-){margin-left:129px;}}
  @media (max-width: 1279px) {._a_0yyk8940001e01b,._t1_0yyk8940001e01b:not(x-),._t2_0yyk8940001e01b:not(x-):not(x-){padding-bottom:var(--c19_b_v1-64pxg7);}}
  @media (max-width: 767px) {._a_0lkns940008gk6l,._t1_0lkns940008gk6l:not(x-),._t2_0lkns940008gk6l:not(x-):not(x-){padding-top:147px;}}
  @media (max-width: 767px) {._a_0lkns94000130iw,._t1_0lkns94000130iw:not(x-),._t2_0lkns94000130iw:not(x-):not(x-){padding-bottom:var(--c27_a_v1-1hjd3hh);}}
  @media (max-width: 1200px) {._a_0p2f07p0002l8pl,._t1_0p2f07p0002l8pl:not(x-),._t2_0p2f07p0002l8pl:not(x-):not(x-){margin-left:176px;}}
  @media (max-width: 767px) {._a_0lkns7p00086ndg,._t1_0lkns7p00086ndg:not(x-),._t2_0lkns7p00086ndg:not(x-):not(x-){margin-top:196px;}}
  @media (max-width: 767px) {._a_x5wnr7p0002waqg._id_15bl859,._t1_x5wnr7p0002waqg:not(x-)._id_15bl859,._t2_x5wnr7p0002waqg:not(x-):not(x-)._id_15bl859{margin-left:var(--c47_v1-1hv8o2g);}}
  @media (max-width: 1279px) {._id_19bya77 ._a_corib940008om9n:first-child,._id_19bya77 ._t1_corib940008om9n:not(x-):first-child,._id_19bya77 ._t2_corib940008om9n:not(x-):not(x-):first-child{padding-top:var(--c41_v1-1j6wafs);}}
  @media (max-width: 1279px) {._a_glkoj7p0002viye:first-child,._t1_glkoj7p0002viye:not(x-):first-child,._t2_glkoj7p0002viye:not(x-):not(x-):first-child{margin-left:211px;}}
  @media (max-width: 1279px) {._a_r9p3l940002omym:last-child,._t1_r9p3l940002omym:not(x-):last-child,._t2_r9p3l940002omym:not(x-):not(x-):last-child{padding-left:var(--c35_a_v1-qbjrz1);}}
  @media (max-width: 1279px) {._a_f6v007p0002vsgb:nth-child(2),._t1_f6v007p0002vsgb:not(x-):nth-child(2),._t2_f6v007p0002vsgb:not(x-):not(x-):nth-child(2){margin-left:180px;}}
  @container (max-width: 768px) {._a_08cqd7p0002hw65,._t1_08cqd7p0002hw65:not(x-),._t2_08cqd7p0002hw65:not(x-):not(x-){margin-left:112px;}}
  @container app-main (max-width: 768px) {._a_0weld7p000220ko,._t1_0weld7p000220ko:not(x-),._t2_0weld7p000220ko:not(x-):not(x-){margin-left:121px;}}
  @container (max-width: 768px) {._a_08cqd7p0002t29f,._t1_08cqd7p0002t29f:not(x-),._t2_08cqd7p0002t29f:not(x-):not(x-){margin-left:126px;}}
  @container app-main (max-width: 992px) {._a_0fdgq7p0002ppya,._t1_0fdgq7p0002ppya:not(x-),._t2_0fdgq7p0002ppya:not(x-):not(x-){margin-left:var(--c34_a_v1-1xdslk1);}}
  ._a_qyw7u3h0pa8a83z:hover,._t1_qyw7u3h0pa8a83z:not(x-):hover,._t2_qyw7u3h0pa8a83z:not(x-):not(x-):hover{border-top-style:solid;}
