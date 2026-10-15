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
  C06 b: label:c06_b _id_1a3a86h _a_48cqd7p0002hw65
  C06 result: label:c06_a _id_9h2ksf _a_7p0002zb3m label:c06_b _id_1a3a86h _a_48cqd7p0002hw65
  C07 a: label:c07_a _id_l80pc8 _a_op2f07p0002rqkl
  C07 b: label:c07_b _id_1burhrp _a_4m2ng7p0002mf8b
  C07 result: label:c07_a _id_l80pc8 _a_op2f07p0002rqkl label:c07_b _id_1burhrp _a_4m2ng7p0002mf8b
  C08 a: label:c08_a _id_1ockbuu _a_3hxp00
  C08 a style: --c08_a_v1-1lvioua:rgb(116, 0, 0)
  C08 b: label:c08_b _id_1e5sasy _a_3h0007alxb
  C08 result: label:c08_a _id_1ockbuu _a_3hxp00 label:c08_b _id_1e5sasy _a_3h0007alxb
  C08 result style: --c08_a_v1-1lvioua:rgb(116, 0, 0)
  C09 a: label:c09_a _id_hceiu2 _a_7prubs
  C09 b: label:c09_b _id_ut9754 _a_7p00024dth
  C09 result: label:c09_a _id_hceiu2 _a_7prubs label:c09_b _id_ut9754 _a_7p00024dth
  C10 a: label:c10_a _id_9tijwd _a_e40pk7p00021f9x
  C10 b: label:c10_b _id_18mu5ns _a_2weld7p000220ko
  C10 result: label:c10_a _id_9tijwd _a_e40pk7p00021f9x label:c10_b _id_18mu5ns _a_2weld7p000220ko
  C11 a: label:c11_a _id_1of8059 _a_hilvs7p0002pol0
  C11 b: label:c11_b _id_1x85356 _a_h5nao7p0002a83i
  C11 result: label:c11_a _id_1of8059 _a_hilvs7p0002pol0 label:c11_b _id_1x85356 _a_h5nao7p0002a83i
  C12 ctx c12_selected: label:c12_selected _id_1e5bhwu
  C12 a: label:c12_a _id_1vocoou _a_07qp47p00020gi1
  C12 b: label:c12_b _id_13qlz5s _a_bba1b7p0002nc5q
  C12 result: label:c12_a _id_1vocoou _a_07qp47p00020gi1 label:c12_b _id_13qlz5s _a_bba1b7p0002nc5q
  C13 a: label:c13_a _id_10r8ilv _a_48cqd7p0002t29f
  C13 b: label:c13_b _id_15lqjan _a_7p00021n1i
  C13 result: label:c13_a _id_10r8ilv _a_48cqd7p0002t29f label:c13_b _id_15lqjan _a_7p00021n1i
  C14 a: label:c14_a _id_1bf4umr _a_4m2ng7p0002uwms
  C14 b: label:c14_b _id_q7vaei _a_op2f07p00029z3v
  C14 result: label:c14_a _id_1bf4umr _a_4m2ng7p0002uwms label:c14_b _id_q7vaei _a_op2f07p00029z3v
  C15 a: label:c15_a _id_v7nmed _a_h5nao7p0002e4q0
  C15 b: label:c15_b _id_103qmrm _a_hilvs7p0002l88o
  C15 result: label:c15_a _id_v7nmed _a_h5nao7p0002e4q0 label:c15_b _id_103qmrm _a_hilvs7p0002l88o
  C16 a: label:c16_a _id_1yqfcxe _a_940008sfay
  C16 b: label:c16_b _id_1v9j5os _a_5eyct94bgtl
  C16 result: label:c16_a _id_1yqfcxe _a_940008sfay label:c16_b _id_1v9j5os _a_5eyct94bgtl
  C17 ctx c17_buttonDisabled: label:c17_buttonDisabled _id_1447smv
  C17 a: label:c17_a _id_5opoy _a_zljev7p00023unn
  C17 b: label:c17_b _id_1kn9kpj _a_07qp47p0002c72t
  C17 result: label:c17_a _id_5opoy _a_zljev7p00023unn label:c17_b _id_1kn9kpj _a_07qp47p0002c72t
  C18 a: label:c18_a _id_eyloby _a_3h1lok4jf1
  C18 b: label:c18_b _id_qg1xdk _a_3h000740we
  C18 b style: --c18_b_v1-vt5hie:rgb(138, 0, 0)
  C18 result: label:c18_a _id_eyloby _a_3h1lok4jf1 label:c18_b _id_qg1xdk _a_3h000740we
  C18 result style: --c18_b_v1-vt5hie:rgb(138, 0, 0)
  C19 a: label:c19_a _id_1bflcs3 _a_tlkns94z9it
  C19 a style: --c19_a_v1-1g9lghy:139px;--c19_a_v2-10uwx3v:140px;--c19_a_v3-b504ir:141px;--c19_a_v4-19o2xwm:142px
  C19 b: label:c19_b _id_1jo0oq _a_9yyk8940001e01b
  C19 b style: --c19_b_v1-64pxg7:143px
  C19 result: label:c19_a _id_1bflcs3 _a_tlkns94z9it label:c19_b _id_1jo0oq _a_9yyk8940001e01b
  C19 result style: --c19_a_v1-1g9lghy:139px;--c19_a_v2-10uwx3v:140px;--c19_a_v3-b504ir:141px;--c19_a_v4-19o2xwm:142px;--c19_b_v1-64pxg7:143px
  C20 a: label:c20_a _id_oo5y04 _a_beqwm7p000280q7
  C20 b: label:c20_b _id_1h4wcvr _a_t48el7p0002w5n3
  C20 result: label:c20_a _id_oo5y04 _a_beqwm7p000280q7 label:c20_b _id_1h4wcvr _a_t48el7p0002w5n3
  C21 a: label:c21_a _id_o820es _a_94erbd
  C21 b: label:c21_b _id_1b316ye _a_tlkns940008gk6l
  C21 result: label:c21_a _id_o820es _a_94erbd label:c21_b _id_1b316ye _a_tlkns940008gk6l
  C22 ctx c22_inputNoBorder: label:c22_inputNoBorder _id_1eh3ga9
  C22 ctx c22_inputError: label:c22_inputError _id_1m4arcl
  C22 a: label:c22_a _id_bpr44t _a_yj3qo7p0002mrog
  C22 a style: --c22_a_v1-15yxvdj:149px
  C22 b: label:c22_b _id_irsigq _a_3lk567p0002iyo5
  C22 result: label:c22_a _id_bpr44t _a_yj3qo7p0002mrog label:c22_b _id_irsigq _a_3lk567p0002iyo5
  C22 result style: --c22_a_v1-15yxvdj:149px
  C23 a: label:c23_a _id_1h4k8vt _a_psx2i7p00021r9j
  C23 b: label:c23_b _id_rhiltm _a_wnwbp7p0002ydte
  C23 result: label:c23_a _id_1h4k8vt _a_psx2i7p00021r9j label:c23_b _id_rhiltm _a_wnwbp7p0002ydte
  C24 a: label:c24_a _id_a7zc2y _a_5eyct9416b1
  C24 b: label:c24_b _id_16r4hzu _a_9400083ump
  C24 result: label:c24_a _id_a7zc2y _a_5eyct9416b1 label:c24_b _id_16r4hzu _a_9400083ump
  C25 a: label:c25_a _id_dr2emr _a_7l0qc94tmv1
  C25 b: label:c25_b _id_1ucp1kz _a_7l0qc94000496cx
  C25 result: label:c25_a _id_dr2emr _a_7l0qc94tmv1 label:c25_b _id_1ucp1kz _a_7l0qc94000496cx
  C26 ctx c26_buttonSelected: label:c26_buttonSelected _id_1w5r4st
  C26 a: label:c26_a _id_1wu295b _a_0lub38p00028f4e
  C26 b: label:c26_b _id_1a36gtu _a_cx72w8p6gkw
  C26 result: label:c26_a _id_1wu295b _a_0lub38p00028f4e label:c26_b _id_1a36gtu _a_cx72w8p6gkw
  C27 a: label:c27_a _id_1kul53t _a_tlkns94000130iw
  C27 a style: --c27_a_v1-1hjd3hh:157px
  C27 b: label:c27_b _id_1btrebe _a_9yyk894mf2m
  C27 b style: --c27_b_v1-ecvqql:158px;--c27_b_v2-1cbrlo8:159px;--c27_b_v3-1cwxpmt:160px;--c27_b_v4-1suqbkt:161px
  C27 result: label:c27_a _id_1kul53t _a_tlkns94000130iw label:c27_b _id_1btrebe _a_9yyk894mf2m
  C27 result style: --c27_a_v1-1hjd3hh:157px;--c27_b_v1-ecvqql:158px;--c27_b_v2-1cbrlo8:159px;--c27_b_v3-1cwxpmt:160px;--c27_b_v4-1suqbkt:161px
  C28 a: label:c28_a _id_1dzye _a_663aw7p0002sqqh
  C28 b: label:c28_b _id_1mqwope _a_4sm4u7p0002v7fa
  C28 result: label:c28_a _id_1dzye _a_663aw7p0002sqqh label:c28_b _id_1mqwope _a_4sm4u7p0002v7fa
  C29 a: label:c29_a _id_1mnug77 _a_e40pk7p0002xply
  C29 b: label:c29_b _id_1h2xeb _a_5eyct7p0002a5oh
  C29 result: label:c29_a _id_1mnug77 _a_e40pk7p0002xply label:c29_b _id_1h2xeb _a_5eyct7p0002a5oh
  C29S a: label:c29s_a _id_1lq16sq _a_e40pk7p00026vnd
  C29S b: label:c29s_b _id_9quai9 _a_5eyct7p0002un4b
  C29S result: label:c29s_a _id_1lq16sq _a_e40pk7p00026vnd label:c29s_b _id_9quai9 _a_5eyct7p0002un4b
  C30 result: label:c30 _id_1c4z69j _a_2zdht7p0002udu7 _a_6d4lr7p0002li07
  C31 a: label:c31_a _id_122vg2n _a_4sm4u7p0002f318
  C31 b: label:c31_b _id_1a5cy56 _a_663aw7p0002rbvl
  C31 result: label:c31_a _id_122vg2n _a_4sm4u7p0002f318 label:c31_b _id_1a5cy56 _a_663aw7p0002rbvl
  C32 a: label:c32_a _id_1ek8295 _a_0lub38p0002xhxr
  C32 b: label:c32_b _id_1ggv8nb _a_x7ow78plm9p
  C32 result: label:c32_a _id_1ek8295 _a_0lub38p0002xhxr label:c32_b _id_1ggv8nb _a_x7ow78plm9p
  C33 a: label:c33_a _id_8pspmu _a_wnwbp7p0002eund
  C33 b: label:c33_b _id_48ih9p _a_psx2i7p0002srlh
  C33 result: label:c33_a _id_8pspmu _a_wnwbp7p0002eund label:c33_b _id_48ih9p _a_psx2i7p0002srlh
  C34 a: label:c34_a _id_14o83mv _in_e66e9x
  C34 a style: --c34_a_v1-1xdslk1:175px
  C34 b: label:c34_b _id_7tm2kg _a_op2f07p0002l8pl
  C34 result: label:c34_a _id_14o83mv _in_e66e9x label:c34_b _id_7tm2kg _a_op2f07p0002l8pl
  C34 result style: --c34_a_v1-1xdslk1:175px
  C35 ctx c35_rowIndented: label:c35_rowIndented _id_66z6xh
  C35 a: label:c35_a _id_1edop6 _in_lgxrcz
  C35 a style: --c35_a_v1-qbjrz1:177px
  C35 b: label:c35_b _id_113wuow _a_y3idz940002rflh
  C35 b style: --c35_b_v1-19zf6xg:178px
  C35 result: label:c35_a _id_1edop6 _in_lgxrcz label:c35_b _id_113wuow _a_y3idz940002rflh
  C35 result style: --c35_a_v1-qbjrz1:177px;--c35_b_v1-19zf6xg:178px
  C36 result: label:c36 _id_vs7wv6 _a_ekl7q7p00024ttg _a_f6v007p0002vsgb
  C37 a: label:c37_a _id_1tncjsd _a_7p0002t5hr
  C37 b: label:c37_b _id_m4d4by _in_1frk7ck
  C37 b style: --c37_b_v1-la3zpt:182px
  C37 result: label:c37_a _id_1tncjsd _a_7p0002t5hr label:c37_b _id_m4d4by _in_1frk7ck
  C37 result style: --c37_b_v1-la3zpt:182px
  C37S a: label:c37s_a _id_pksthw _a_7p00026q98
  C37S b: label:c37s_b _id_1n23q75 _in_o5kb48
  C37S b style: --c37s_b_v1-s4zg91:184px
  C37S result: label:c37s_a _id_pksthw _a_7p00026q98 label:c37s_b _id_1n23q75 _in_o5kb48
  C37S result style: --c37s_b_v1-s4zg91:184px
  C38 a: label:c38_a _id_ug3vas _a_ugao67p0002qgqh
  C38 b: label:c38_b _id_v1li1d _a_ra8lm7p0002tc72
  C38 result: label:c38_a _id_ug3vas _a_ugao67p0002qgqh label:c38_b _id_v1li1d _a_ra8lm7p0002tc72
  C39 result: label:c39 _id_6d8oqf _a_ekl7q3h2ghsq4mq _a_qyw7u3h0pa8a83z
  C40 result: label:c40 _id_bzqj9h _a_27csn9400010i0u _a_zucss94w4l0
  C40 result style: --c40_v1-1bz5jgd:189px;--c40_v2-1dn44o2:190px
  C41 ctx c41_tbody: label:c41_tbody _id_vm645b
  C41 ctx c41_rowTitleAlwaysVisible: label:c41_rowTitleAlwaysVisible _id_19bya77
  C41 result: label:c41 _id_12z3w26 _a_eda5c940008zrmd _in_8r42bl
  C41 result style: --c41_v1-1j6wafs:192px
  C42 result: label:c42 _id_rfojbb _a_izmu294lxcy _a_e6xeu940008in7j
  C43 a: label:c43_a _id_15u1vzy _a_tlkns7p00086ndg
  C43 b: label:c43_b _id_1axilhb _in_hp3r9r
  C43 b style: --c43_b_v1-1xvqxy7:199px
  C43 result: label:c43_a _id_15u1vzy _a_tlkns7p00086ndg label:c43_b _id_1axilhb _in_hp3r9r
  C43 result style: --c43_b_v1-1xvqxy7:199px
  C44 result: label:c44 _id_15q2cly _a_kiios3h1lokcxkw _a_vo2ns3h0004edka
  C45 ctx c45_compactButtonLeft: label:c45_compactButtonLeft _id_z1l0g2
  C45 result: label:c45 _id_1dru6e3 _in_1rp7ocu _a_07qp43h0ef5ui7a
  C45 result style: --c45_v1-19lye7:rgb(204, 0, 0);--c45_v2-1h7t4j3:rgb(205, 0, 0)
  C46 result: label:c46 _id_1u8w2oz _a_2y6oc2z0008jmji _a_ra0y62zvxvs
  C47 ctx c47_headerMenuOpened: label:c47_headerMenuOpened _id_15bl859
  C47 result: label:c47 _id_1p3m5s4 _in_l2s8fc _in_hy12jj
  C47 result style: --c47_v1-1hv8o2g:208px;--c47_v2-sxcaga:209px
  C48 result: label:c48 _id_1t3pmcy _a_otmai7p0002nesm _a_glkoj7p0002viye
  C49 result: label:c49 _id_24diba _a_2cunn3h0ef5s3e1 _a_f1m0m3hag2y

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
  ._a_7l0qc94tmv1 input{padding:154px;}
  ._a_izmu294lxcy td{padding:193px 194px;}
  ._a_f1m0m3hag2y input:focus{border:212px solid rgb(214, 0, 0);}
  ._a_beqwm7p000280q7 svg{margin-left:144px !important;}
  ._a_t48el7p0002w5n3 > svg{margin-left:145px !important;}
  ._a_psx2i7p00021r9j > a{margin-left:150px;}
  ._a_7l0qc94000496cx input{padding-right:155px;}
  ._a_psx2i7p0002srlh > a{margin-left:174px;}
  ._a_ra8lm7p0002tc72 input{margin-left:185px !important;}
  ._a_ugao67p0002qgqh > input{margin-left:186px !important;}
  ._a_27csn9400010i0u a{padding-bottom:var(--c40_v1-1bz5jgd);}
  ._a_kiios3h1lokcxkw td:first-child{border-width:200px;}
  ._a_2cunn3h0ef5s3e1 input:hover{border-color:rgb(213, 0, 0);}
  ._a_3hxp00{border:115px solid var(--c08_a_v1-1lvioua);}
  ._a_3h0007alxb{border-bottom:117px dotted;}
  ._a_7prubs{margin:118px;}
  ._a_3h000740we{border-bottom:137px solid var(--c18_b_v1-vt5hie);}
  ._a_94erbd{padding:146px;}
  ._a_cx72w8p6gkw._id_1w5r4st{outline:156px dashed red;}
  ._in_hp3r9r{margin:197px 0 var(--c43_b_v1-1xvqxy7);}
  ._in_1rp7ocu._id_z1l0g2{border-left:202px solid var(--c45_v1-19lye7);}
  ._a_7p0002t5hr{margin-left:181px;}
  ._in_1frk7ck{margin-left:var(--c37_b_v1-la3zpt);}
  ._in_o5kb48{margin-left:var(--c37s_b_v1-s4zg91);}
  ._a_7p00026q98{margin-left:183px;}
  ._a_7p00024mrz{margin-left:101px;}
  ._a_7p0002b1lg{margin-left:102px;}
  ._a_7p0002ysfb{margin-left:103px;}
  ._a_oe8sa7p00027kik{margin-left:104px !important;}
  ._a_oe8sa7p0002kr08{margin-left:105px !important;}
  ._a_7p00025qeb{margin-left:106px;}
  ._a_7p0002790s{margin-left:107px;}
  ._a_6mxey7p00022ydp._id_xis9zs{margin-left:108px;}
  ._a_7p0002ix26{margin-left:110px;}
  ._a_7p0002zb3m{margin-left:111px;}
  ._a_7p00024dth{margin-left:119px;}
  ._a_bba1b7p0002nc5q._id_1e5bhwu{margin-left:125px;}
  ._a_7p00021n1i{margin-left:127px;}
  ._a_940008sfay{padding-top:132px;}
  ._a_zljev7p00023unn._id_1447smv{margin-left:134px;}
  ._a_3h1lok4jf1{border-width:136px;}
  ._a_3lk567p0002iyo5._id_1eh3ga9{margin-left:148px;}
  ._a_yj3qo7p0002mrog._id_1m4arcl{margin-left:var(--c22_a_v1-15yxvdj);}
  ._a_9400083ump{padding-top:153px;}
  ._id_66z6xh ._a_y3idz940002rflh{padding-left:var(--c35_b_v1-19zf6xg);}
  ._id_vm645b:first-child ._a_eda5c940008zrmd{padding-top:191px;}
  @media (max-width: 767px) {._a_zucss94w4l0 a{padding:188px 0 var(--c40_v2-1dn44o2);}}
  ._a_4sm4u7p0002v7fa:disabled span{margin-left:163px !important;}
  ._a_4sm4u7p0002f318:disabled span{margin-left:170px !important;}
  ._a_663aw7p0002sqqh:hover span{margin-left:162px !important;}
  ._a_663aw7p0002rbvl:hover span{margin-left:171px !important;}
  @media (min-width: 1280px) {._a_wnwbp7p0002ydte > a{margin-left:151px;}}
  @media (min-width: 768px) and (max-width: 1279px) {._a_2zdht7p0002udu7 th:first-child{margin-left:168px;}}
  @media (max-width: 767px) {._a_6d4lr7p0002li07 th:first-child{margin-left:169px;}}
  @media (min-width: 1280px) {._a_wnwbp7p0002eund > a{margin-left:173px;}}
  @media (max-width: 767px) {._a_e6xeu940008in7j td{padding-top:195px;}}
  ._a_vo2ns3h0004edka:last-child td{border-bottom-width:201px;}
  ._a_ekl7q3h2ghsq4mq:first-child{border-top:187px dotted red;}
  ._in_hp3r9r:disabled{margin:198px 0 var(--c43_b_v1-1xvqxy7);}
  ._in_1rp7ocu:disabled{border-left:203px solid var(--c45_v1-19lye7);}
  ._a_x7ow78plm9p:active{outline:172px groove red;}
  ._a_2y6oc2z0008jmji::before{-webkit-animation-duration:206s;animation-duration:206s;}
  @media (max-width: 768px) {._a_5eyct94bgtl{padding:133px;}}
  @media (max-width: 767px) {._a_tlkns94z9it{padding:var(--c19_a_v1-1g9lghy) var(--c19_a_v2-10uwx3v) var(--c19_a_v3-b504ir) var(--c19_a_v4-19o2xwm);}}
  @media (max-width: 768px) {._a_5eyct9416b1{padding:152px;}}
  @media (max-width: 1279px) {._a_9yyk894mf2m{padding:var(--c27_b_v1-ecvqql) var(--c27_b_v2-1cbrlo8) var(--c27_b_v3-1cwxpmt) var(--c27_b_v4-1suqbkt);}}
  @media (prefers-reduced-motion: reduce) {._a_ra0y62zvxvs::before{-webkit-animation:207s ease;animation:207s ease;}}
  ._a_ekl7q7p0002lpe2:first-child{margin-left:109px;}
  ._a_ekl7q7p00024ttg:first-child{margin-left:179px;}
  ._a_otmai7p0002nesm:nth-child(2){margin-left:210px;}
  ._in_1frk7ck:disabled{margin-left:var(--c37_b_v1-la3zpt);}
  ._in_o5kb48:disabled{margin-left:var(--c37s_b_v1-s4zg91);}
  ._a_hilvs7p0002pol0:disabled{margin-left:122px !important;}
  ._a_07qp47p00020gi1:disabled{margin-left:124px;}
  ._a_hilvs7p0002l88o:disabled{margin-left:131px !important;}
  ._a_07qp47p0002c72t:disabled{margin-left:135px;}
  ._in_e66e9x:disabled{margin-left:var(--c34_a_v1-1xdslk1);}
  ._in_lgxrcz:disabled{padding-left:var(--c35_a_v1-qbjrz1);}
  ._in_8r42bl:disabled{padding-top:var(--c41_v1-1j6wafs);}
  ._a_07qp43h0ef5ui7a:disabled{border-color:var(--c45_v2-1h7t4j3);}
  ._in_l2s8fc:disabled{margin-left:var(--c47_v1-1hv8o2g);}
  ._in_hy12jj:disabled{margin-left:var(--c47_v2-sxcaga);}
  ._a_h5nao7p0002a83i:hover{margin-left:123px !important;}
  ._a_h5nao7p0002e4q0:hover{margin-left:130px !important;}
  ._in_hy12jj:hover{margin-left:var(--c47_v2-sxcaga);}
  ._a_0lub38p00028f4e:focus{outline-style:dotted;}
  ._a_0lub38p0002xhxr:focus{outline-style:double;}
  @media print {._a_e40pk7p0002xply{margin-left:164px;}}
  @media (max-width: 768px) {._a_5eyct7p0002a5oh{margin-left:165px;}}
  @media (max-width: 768px) {._a_5eyct7p0002un4b{margin-left:167px;}}
  @media print {._a_e40pk7p00026vnd{margin-left:166px;}}
  @media (max-width: 1200px) {._a_op2f07p0002rqkl{margin-left:113px;}}
  @media (max-width: 992px) {._a_4m2ng7p0002mf8b{margin-left:114px;}}
  @media print {._a_e40pk7p00021f9x{margin-left:120px;}}
  @media (max-width: 1200px) {._a_op2f07p00029z3v{margin-left:128px;}}
  @media (max-width: 992px) {._a_4m2ng7p0002uwms{margin-left:129px;}}
  @media (max-width: 1279px) {._a_9yyk8940001e01b{padding-bottom:var(--c19_b_v1-64pxg7);}}
  @media (max-width: 767px) {._a_tlkns940008gk6l{padding-top:147px;}}
  @media (max-width: 767px) {._a_tlkns94000130iw{padding-bottom:var(--c27_a_v1-1hjd3hh);}}
  @media (max-width: 1200px) {._a_op2f07p0002l8pl{margin-left:176px;}}
  @media (max-width: 767px) {._a_tlkns7p00086ndg{margin-top:196px;}}
  @media (max-width: 767px) {._in_l2s8fc._id_15bl859{margin-left:var(--c47_v1-1hv8o2g);}}
  @media (max-width: 1279px) {._id_19bya77 ._in_8r42bl:first-child{padding-top:var(--c41_v1-1j6wafs);}}
  @media (max-width: 1279px) {._a_glkoj7p0002viye:first-child{margin-left:211px;}}
  @media (max-width: 1279px) {._in_lgxrcz:last-child{padding-left:var(--c35_a_v1-qbjrz1);}}
  @media (max-width: 1279px) {._a_f6v007p0002vsgb:nth-child(2){margin-left:180px;}}
  @container (max-width: 768px) {._a_48cqd7p0002hw65{margin-left:112px;}}
  @container app-main (max-width: 768px) {._a_2weld7p000220ko{margin-left:121px;}}
  @container (max-width: 768px) {._a_48cqd7p0002t29f{margin-left:126px;}}
  @container app-main (max-width: 992px) {._in_e66e9x{margin-left:var(--c34_a_v1-1xdslk1);}}
  ._a_qyw7u3h0pa8a83z:hover{border-top-style:solid;}
