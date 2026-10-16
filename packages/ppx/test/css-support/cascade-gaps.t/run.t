Pins what `CSS.merge` and the stylesheet order do today, with the base-removes
rule (`Slot_key.removes`) and the box shorthand split, for shapes where the
author's intended winner and the produced winner can differ, as one case per
shape (G01 to G51S). It extends `cascade-cases.t` (C01 to C49) and
`cascade-exotic.t` (E01 to E45). Each case sits above its code in `input.re`
with its intended winner. A case may pin a result that differs from the intended
winner: the test records the gap, it does not approve it.

The cases cover an interpolated shorthand against a longhand (single path,
repeated paths, a static value with a repeated path, four distinct paths, a raw
`var()`), `_in_` bundles on either side of a merge, the same selector with extra
at-rules, nested at-rules, two different conditions, the split and unsplit
shorthands against their longhands, three-way merges in both groupings, the same
pairs in one block, and operands in two files in both file orders.

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
  G01 a: label:g01_a _id_le1yyq _a_0p2f094tq86
  G01 a style: --g01_x-w1rss1:111px
  G01 b: label:g01_b _id_ra3lng _a_940082eeg
  G01 result: label:g01_a _id_le1yyq _a_0p2f094tq86 label:g01_b _id_ra3lng _t1_940082eeg
  G01 result style: --g01_x-w1rss1:111px
  G02 a: label:g02_a _id_1808hwv _a_0p2f094hffm
  G02 a style: --g02_a_v1-1r7r0iu:121px;--g02_a_v2-qruzaz:122px
  G02 b: label:g02_b _id_dbq0jb _a_94008tec9
  G02 result: label:g02_a _id_1808hwv _a_0p2f094hffm label:g02_b _id_dbq0jb _t1_94008tec9
  G02 result style: --g02_a_v1-1r7r0iu:121px;--g02_a_v2-qruzaz:122px
  G03 a: label:g03_a _id_1jhsssm _a_0p2f094jnqi
  G03 a style: --g03_x-1vl3uw1:132px
  G03 b: label:g03_b _id_fs8bfh _a_94008sz5p
  G03 result: label:g03_a _id_1jhsssm _a_0p2f094jnqi label:g03_b _id_fs8bfh _t1_94008sz5p
  G03 result style: --g03_x-1vl3uw1:132px
  G04 a: label:g04_a _id_eewn4v _a_0p2f094hyvd
  G04 a style: --g04_a_v1-1ouxgl4:141px;--g04_a_v2-j48dgx:142px;--g04_a_v3-jrtvxi:143px;--g04_a_v4-n1omg4:144px
  G04 b: label:g04_b _id_1ldsf4w _a_94008sqfx
  G04 result: label:g04_a _id_eewn4v _a_0p2f094hyvd label:g04_b _id_1ldsf4w _t1_94008sqfx
  G04 result style: --g04_a_v1-1ouxgl4:141px;--g04_a_v2-j48dgx:142px;--g04_a_v3-jrtvxi:143px;--g04_a_v4-n1omg4:144px
  G05 a: label:g05_a _id_1ei3u6a _a_0p2f094twy5
  G05 b: label:g05_b _id_5xml11 _a_94008hwvz
  G05 result: label:g05_a _id_1ei3u6a _a_0p2f094twy5 label:g05_b _id_5xml11 _t1_94008hwvz
  G06 a: label:g06_a _id_cocjkr _a_0p2f094gldf
  G06 b: label:g06_b _id_1osqhf3 _a_94008c1lf
  G06 b style: --g06_b_v1-1mo9n5b:162px
  G06 result: label:g06_a _id_cocjkr _a_0p2f094gldf label:g06_b _id_1osqhf3 _t1_94008c1lf
  G06 result style: --g06_b_v1-1mo9n5b:162px
  G07 a: label:g07_a _id_22o0f1 _in_17owvxb
  G07 a style: --g07_a_v1-1n6gf7y:171px
  G07 b: label:g07_b _id_4yzruu _a_94008eqd3
  G07 result: label:g07_a _id_22o0f1 _in_17owvxb label:g07_b _id_4yzruu _a_94008eqd3
  G07 result style: --g07_a_v1-1n6gf7y:171px
  G08 a: label:g08_a _id_ghrac4 _a_0p2f094m3ut
  G08 a style: --g08_a_v1-g0aivi:181px
  G08 b: label:g08_b _id_a9w0uv _a_94ep5r
  G08 result: label:g08_a _id_ghrac4 label:g08_b _id_a9w0uv _a_94ep5r
  G08 result style: --g08_a_v1-g0aivi:181px
  G09 a: label:g09_a _id_3jliw _a_94008sawn
  G09 b: label:g09_b _id_crbk5 _in_1adrker
  G09 b style: --g09_b_v1-1lh50ku:192px
  G09 result: label:g09_a _id_3jliw _a_94008sawn label:g09_b _id_crbk5 _in_1adrker
  G09 result style: --g09_b_v1-1lh50ku:192px
  G10 a: label:g10_a _id_9jyret _in_85rpxf
  G10 a style: --g10_a_v1-azo504:201px
  G10 b: label:g10_b _id_v2ts67 _a_0p2f094008xv6u
  G10 result: label:g10_a _id_9jyret _in_85rpxf label:g10_b _id_v2ts67 _a_0p2f094008xv6u
  G10 result style: --g10_a_v1-azo504:201px
  G11 a: label:g11_a _id_1kz82nw _in_193brsh
  G11 a style: --g11_a_v1-evlpt3:211px
  G11 b: label:g11_b _id_1v2b23j _in_lovnlp
  G11 b style: --g11_b_v1-15hdob5:212px
  G11 result: label:g11_a _id_1kz82nw _in_193brsh label:g11_b _id_1v2b23j _in_lovnlp
  G11 result style: --g11_a_v1-evlpt3:211px;--g11_b_v1-15hdob5:212px
  G12 a: label:g12_a _id_ok0wbn _a_cusig4exlm3
  G12 b: label:g12_b _id_15ljxw9 _a_s19nz4epz1m
  G12 result: label:g12_a _id_ok0wbn _a_cusig4exlm3 label:g12_b _id_15ljxw9 _a_s19nz4epz1m
  G13 a: label:g13_a _id_evr7y5 _a_bfxpa4egtum
  G13 b: label:g13_b _id_jlws23 _a_qyw7u4exirz
  G13 result: label:g13_a _id_evr7y5 _a_bfxpa4egtum label:g13_b _id_jlws23 _a_qyw7u4exirz
  G14 a: label:g14_a _id_1b7ll7u _a_cusig4ehjl1
  G14 b: label:g14_b _id_1pdntjk _a_s19nz4ev00p
  G14 result: label:g14_a _id_1b7ll7u _a_cusig4ehjl1 label:g14_b _id_1pdntjk _a_s19nz4ev00p
  G15 a: label:g15_a _id_q30hsk _a_cusig4e2nat
  G15 b: label:g15_b _id_au8c59 _a_cusig4eo88q
  G15 result: label:g15_a _id_q30hsk label:g15_b _id_au8c59 _a_cusig4eo88q
  G16 a: label:g16_a _id_dmso15 _a_0kk4l94w9fm
  G16 b: label:g16_b _id_i91hv1 _a_94008wnds
  G16 result: label:g16_a _id_dmso15 _a_0kk4l94w9fm label:g16_b _id_i91hv1 _t1_94008wnds
  G17 a: label:g17_a _id_1tqi38q _a_0bwi47p002qdre
  G17 b: label:g17_b _id_1xhi4qf _a_7p0021u47
  G17 result: label:g17_a _id_1tqi38q label:g17_b _id_1xhi4qf _a_7p0021u47
  G18 a: label:g18_a _id_qve405 _a_0bwi47p0028h0m
  G18 b: label:g18_b _id_1t29m73 _a_7p002ikad
  G18 result: label:g18_a _id_qve405 label:g18_b _id_1t29m73 _a_7p002ikad
  G19 a: label:g19_a _id_1y5qofl _a_0kk4l7p002mm7n
  G19 b: label:g19_b _id_1thyb6p _a_0kk4l7p0020z0w
  G19 result: label:g19_a _id_1y5qofl label:g19_b _id_1thyb6p _a_0kk4l7p0020z0w
  G20 a: label:g20_a _id_g0g3nc _a_0p2f07p0023nxv
  G20 b: label:g20_b _id_1c074z _a_0f0zo7p002depv
  G20 result: label:g20_a _id_g0g3nc _a_0p2f07p0023nxv label:g20_b _id_1c074z _t1_0f0zo7p002depv
  G21 a: label:g21_a _id_h6bkvd _a_0p2f094ngjf
  G21 b: label:g21_b _id_50uen8 _a_0p2f094008sipt
  G21 result: label:g21_a _id_h6bkvd _a_0p2f094ngjf label:g21_b _id_50uen8 _a_0p2f094008sipt
  G22 a: label:g22_a _id_wvp4ss _a_0f0zo94im9c
  G22 b: label:g22_b _id_oypggq _a_0p2f0940085zfw
  G22 result: label:g22_a _id_wvp4ss _a_0f0zo94im9c label:g22_b _id_oypggq _t1_0p2f0940085zfw
  G23 a: label:g23_a _id_u32gtg _a_0p2f07pnixf
  G23 b: label:g23_b _id_jfn5j3 _a_7p0025ef7
  G23 result: label:g23_a _id_u32gtg _a_0p2f07pnixf label:g23_b _id_jfn5j3 _t1_7p0025ef7
  G24 a: label:g24_a _id_s7lzke _a_0p2f096fqec
  G24 b: label:g24_b _id_1rwl97z _a_940020dgx
  G24 result: label:g24_a _id_s7lzke _a_0p2f096fqec label:g24_b _id_1rwl97z _a_940020dgx
  G25 a: label:g25_a _id_1j8unhb _a_0p2f03hia4z
  G25 b: label:g25_b _id_146k9dn _a_3hcn4bbg5
  G25 result: label:g25_a _id_1j8unhb _a_0p2f03hia4z label:g25_b _id_146k9dn _t1_3hcn4bbg5
  G26 a: label:g26_a _id_1ns0cxh _a_0p2f03n9uor
  G26 b: label:g26_b _id_qu3y1t _a_3n0041pt6
  G26 result: label:g26_a _id_1ns0cxh _a_0p2f03n9uor label:g26_b _id_qu3y1t _t1_3n0041pt6
  G27 a: label:g27_a _id_idjwk1 _a_cht8894jcw8
  G27 b: label:g27_b _id_1w5b27m _a_94008l2i8
  G27 result: label:g27_a _id_idjwk1 _a_cht8894jcw8 label:g27_b _id_1w5b27m _a_94008l2i8
  G28 a: label:g28_a _id_1h8z5lg _a_0p2f08ruqqx
  G28 b: label:g28_b _id_jzungn _a_8r0023rg8
  G28 result: label:g28_a _id_1h8z5lg _a_0p2f08ruqqx label:g28_b _id_jzungn _t1_8r0023rg8
  G29 a: label:g29_a _id_vjm16n _a_0p2f06fwk2e
  G29 b: label:g29_b _id_1282sm0 _a_6f002wim3
  G29 result: label:g29_a _id_vjm16n _a_0p2f06fwk2e label:g29_b _id_1282sm0 _t1_6f002wim3
  G30 a: label:g30_a _id_16u89p1 _a_0p2f0715yqm
  G30 b: label:g30_b _id_1t5hezu _a_710089sgg
  G30 result: label:g30_a _id_16u89p1 _a_0p2f0715yqm label:g30_b _id_1t5hezu _t1_710089sgg
  G31 a: label:g31_a _id_1db9ple _a_0crm394sth2
  G31 b: label:g31_b _id_6mttqr _a_94008mlcw
  G31 result: label:g31_a _id_1db9ple _a_0crm394sth2 label:g31_b _id_6mttqr _t1_94008mlcw
  G32 a: label:g32_a _id_1rc4ldg _a_0p2f07p8dqc
  G32 b: label:g32_b _id_1gigiji _a_7p004l0kr
  G32 result: label:g32_a _id_1rc4ldg _a_0p2f07p8dqc label:g32_b _id_1gigiji _t1_7p004l0kr
  G33 a: label:g33_a _id_6cxmjc _a_0p2f095ii5y
  G33 b: label:g33_b _id_1c46m52 _a_94008etwy
  G33 result: label:g33_a _id_6cxmjc _a_0p2f095ii5y label:g33_b _id_1c46m52 _a_94008etwy
  G34 a: label:g34_a _id_qxuwbj _a_qyw7u94o0wc
  G34 b: label:g34_b _id_sr8hg6 _a_qyw7u94008frph
  G34 result: label:g34_a _id_qxuwbj _a_qyw7u94o0wc label:g34_b _id_sr8hg6 _a_qyw7u94008frph
  G35 a: label:g35_a _id_uoavdd _a_0p2f094bsll
  G35 b: label:g35_b _id_ryi4kf _a_oe8sa94008kxgz
  G35 result: label:g35_a _id_uoavdd _a_0p2f094bsll label:g35_b _id_ryi4kf _a_oe8sa94008kxgz
  G36 a: label:g36_a _id_8c420j _a_0p2f0946b9d
  G36 b: label:g36_b _id_1lgmiy8 _a_940085dyq
  G36 result: label:g36_a _id_8c420j _a_0p2f0946b9d label:g36_b _id_1lgmiy8 _t1_940085dyq
  G37 a: label:g37_a _id_1qcjczj _a_0p2f065hule
  G37 b: label:g37_b _id_q7haz2 _a_6500wiyg8
  G37 result: label:g37_a _id_1qcjczj _a_0p2f065hule label:g37_b _id_q7haz2 _t1_6500wiyg8
  G38 a: label:g38_a _id_sd8g9c _a_0p2f039srwd
  G38 b: label:g38_b _id_rz6q8 _a_39004ki2q
  G38 result: label:g38_a _id_sd8g9c _a_0p2f039srwd label:g38_b _id_rz6q8 _t1_39004ki2q
  G39 a: label:g39_a _id_1c2tfi3 _a_0p2f060s8gu
  G39 b: label:g39_b _id_1jnvcdv _a_60002eqnu
  G39 result: label:g39_a _id_1c2tfi3 _a_0p2f060s8gu label:g39_b _id_1jnvcdv _t1_60002eqnu
  G40 a: label:g40_a _id_1w99iz0 _a_0p2f03hloka8vp
  G40 b: label:g40_b _id_15if4y7 _a_3hekg8hxa
  G40 result: label:g40_a _id_1w99iz0 _a_0p2f03hloka8vp label:g40_b _id_15if4y7 _t1_3hekg8hxa
  G41 a: label:g41_a _id_y3dsix _a_94wjd5
  G41 b: label:g41_b _id_ge53b8 _a_0p2f094008trvt
  G41 result: label:g41_a _id_y3dsix _a_94wjd5 label:g41_b _id_ge53b8 _a_0p2f094008trvt
  G42 a: label:g42_a _id_yoi53l _a_oe8sa94qxz8
  G42 b: label:g42_b _id_1f5qbqx _a_94008nyqa
  G42 result: label:g42_a _id_yoi53l _a_oe8sa94qxz8 label:g42_b _id_1f5qbqx _a_94008nyqa
  G43 a: label:g43_a _id_sb6z64 _a_9425e1
  G43 b: label:g43_b _id_1mv8eg2 _a_0p2f094qzpf
  G43 c: label:g43_c _id_g3bnrh _a_94008l9h9
  G43 result: label:g43_a _id_sb6z64 _a_9425e1 label:g43_b _id_1mv8eg2 _a_0p2f094qzpf label:g43_c _id_g3bnrh _t1_94008l9h9
  G44 a: label:g44_a _id_1iw4kr9 _a_94layi
  G44 b: label:g44_b _id_o1mr6z _a_0p2f094rh6e
  G44 c: label:g44_c _id_1kt9tm5 _a_94008suso
  G44 result: label:g44_a _id_1iw4kr9 _a_94layi label:g44_b _id_o1mr6z _a_0p2f094rh6e label:g44_c _id_1kt9tm5 _t1_94008suso
  G45 a: label:g45_a _id_1a07bmt _a_94008squy
  G45 b: label:g45_b _id_1z0zne3 _a_0p2f094008o9gy
  G45 c: label:g45_c _id_1gt2va2 _a_942oya
  G45 result: label:g45_a _id_1a07bmt label:g45_b _id_1z0zne3 label:g45_c _id_1gt2va2 _a_942oya
  G46 a: label:g46_a _id_11u965q _a_940086kdf
  G46 b: label:g46_b _id_u2i51c _a_0p2f094008mwf2
  G46 c: label:g46_c _id_w0u83i _a_94roh4
  G46 result: label:g46_a _id_11u965q label:g46_b _id_u2i51c label:g46_c _id_w0u83i _a_94roh4
  G47 a: label:g47_a _id_7zjga4 _a_94a4gd
  G47 b: label:g47_b _id_1izug5q _a_0p2f0940082uxx
  G47 result: label:g47 _id_1dto0oe _a_94a4gd _a_0p2f0940082uxx
  G48 a: label:g48_a _id_epkxz0 _a_0p2f094008bn02
  G48 b: label:g48_b _id_1vtw6u8 _a_944pn0
  G48 result: label:g48 _id_uvlb5j _a_944pn0
  G49 a: label:g49_a _id_epc09d _a_0p2f094m9ug
  G49 b: label:g49_b _id_n2bfd5 _a_94008vkr1
  G49 result: label:g49 _id_ft4hgr _a_0p2f094m9ug _t1_94008vkr1
  G50 a: label:g50_a _id_kel9e1 _a_94008awxs
  G50 b: label:g50_b _id_7nrwrz _a_0p2f094ow3z
  G50 result: label:g50 _id_pvs05l _a_94008awxs _a_0p2f094ow3z
  G51 a: label:g51_a _id_9hqx1q _a_0p2f094zocp
  G51 b: label:g51_b _id_154dcwn _a_94008oudn
  G51 result: label:g51_a _id_9hqx1q _a_0p2f094zocp label:g51_b _id_154dcwn _t1_94008oudn
  G51S a: label:g51s_a _id_1ip4w0k _a_0p2f094tzg7
  G51S b: label:g51s_b _id_1hdhg2z _a_94008324g
  G51S result: label:g51s_a _id_1ip4w0k _a_0p2f094tzg7 label:g51s_b _id_1hdhg2z _t1_94008324g

The stylesheet, from the same post-PPX files the executable was built from, so
its classes are the ones printed above:

  $ styled-ppx.generate _build/default/*.re.pp.ml
  /* This file is generated by styled-ppx, do not edit manually */
  @property --g01_x-w1rss1{syntax:"*";inherits:false;}
  @property --g02_a_v1-1r7r0iu{syntax:"*";inherits:false;}
  @property --g02_a_v2-qruzaz{syntax:"*";inherits:false;}
  @property --g03_x-1vl3uw1{syntax:"*";inherits:false;}
  @property --g04_a_v1-1ouxgl4{syntax:"*";inherits:false;}
  @property --g04_a_v2-j48dgx{syntax:"*";inherits:false;}
  @property --g04_a_v3-jrtvxi{syntax:"*";inherits:false;}
  @property --g04_a_v4-n1omg4{syntax:"*";inherits:false;}
  @property --g06_b_v1-1mo9n5b{syntax:"*";inherits:false;}
  @property --g07_a_v1-1n6gf7y{syntax:"*";inherits:false;}
  @property --g08_a_v1-g0aivi{syntax:"*";inherits:false;}
  @property --g09_b_v1-1lh50ku{syntax:"*";inherits:false;}
  @property --g10_a_v1-azo504{syntax:"*";inherits:false;}
  @property --g11_a_v1-evlpt3{syntax:"*";inherits:false;}
  @property --g11_b_v1-15hdob5{syntax:"*";inherits:false;}
  ._a_94ep5r,._t1_94ep5r._t1_94ep5r,._t2_94ep5r._t2_94ep5r._t2_94ep5r{padding:182px;}
  ._a_s19nz4epz1m .child,._t1_s19nz4epz1m._t1_s19nz4epz1m .child,._t2_s19nz4epz1m._t2_s19nz4epz1m._t2_s19nz4epz1m .child{color:rgb(222, 0, 0);}
  ._a_s19nz4ev00p .child,._t1_s19nz4ev00p._t1_s19nz4ev00p .child,._t2_s19nz4ev00p._t2_s19nz4ev00p._t2_s19nz4ev00p .child{color:rgb(242, 0, 0);}
  ._a_94wjd5,._t1_94wjd5._t1_94wjd5,._t2_94wjd5._t2_94wjd5._t2_94wjd5{padding:511px;}
  ._a_oe8sa94qxz8,._t1_oe8sa94qxz8._t1_oe8sa94qxz8,._t2_oe8sa94qxz8._t2_oe8sa94qxz8._t2_oe8sa94qxz8{padding:521px !important;}
  ._a_9425e1,._t1_9425e1._t1_9425e1,._t2_9425e1._t2_9425e1._t2_9425e1{padding:531px;}
  ._a_94layi,._t1_94layi._t1_94layi,._t2_94layi._t2_94layi._t2_94layi{padding:541px;}
  ._a_942oya,._t1_942oya._t1_942oya,._t2_942oya._t2_942oya._t2_942oya{padding:553px;}
  ._a_94roh4,._t1_94roh4._t1_94roh4,._t2_94roh4._t2_94roh4._t2_94roh4{padding:563px;}
  ._a_94a4gd,._t1_94a4gd._t1_94a4gd,._t2_94a4gd._t2_94a4gd._t2_94a4gd{padding:571px;}
  ._a_944pn0,._t1_944pn0._t1_944pn0,._t2_944pn0._t2_944pn0._t2_944pn0{padding:582px;}
  ._a_94008oudn,._t1_94008oudn._t1_94008oudn,._t2_94008oudn._t2_94008oudn._t2_94008oudn{padding-top:612px;}
  ._a_94008324g,._t1_94008324g._t1_94008324g,._t2_94008324g._t2_94008324g._t2_94008324g{padding-top:622px;}
  ._a_940082eeg,._t1_940082eeg._t1_940082eeg,._t2_940082eeg._t2_940082eeg._t2_940082eeg{padding-top:112px;}
  ._a_94008tec9,._t1_94008tec9._t1_94008tec9,._t2_94008tec9._t2_94008tec9._t2_94008tec9{padding-top:123px;}
  ._a_94008sz5p,._t1_94008sz5p._t1_94008sz5p,._t2_94008sz5p._t2_94008sz5p._t2_94008sz5p{padding-top:133px;}
  ._a_94008sqfx,._t1_94008sqfx._t1_94008sqfx,._t2_94008sqfx._t2_94008sqfx._t2_94008sqfx{padding-top:145px;}
  ._a_94008hwvz,._t1_94008hwvz._t1_94008hwvz,._t2_94008hwvz._t2_94008hwvz._t2_94008hwvz{padding-top:151px;}
  ._a_94008c1lf,._t1_94008c1lf._t1_94008c1lf,._t2_94008c1lf._t2_94008c1lf._t2_94008c1lf{padding-top:var(--g06_b_v1-1mo9n5b);}
  ._in_17owvxb{padding-top:var(--g07_a_v1-1n6gf7y);}
  ._a_94008eqd3,._t1_94008eqd3._t1_94008eqd3,._t2_94008eqd3._t2_94008eqd3._t2_94008eqd3{padding-top:172px;}
  ._a_94008sawn,._t1_94008sawn._t1_94008sawn,._t2_94008sawn._t2_94008sawn._t2_94008sawn{padding-top:191px;}
  ._in_1adrker{padding-top:var(--g09_b_v1-1lh50ku);}
  ._in_85rpxf{padding-top:var(--g10_a_v1-azo504);}
  ._in_193brsh{padding-top:var(--g11_a_v1-evlpt3);}
  ._in_lovnlp{padding-top:var(--g11_b_v1-15hdob5);}
  ._a_94008wnds,._t1_94008wnds._t1_94008wnds,._t2_94008wnds._t2_94008wnds._t2_94008wnds{padding-top:262px;}
  ._a_7p0021u47,._t1_7p0021u47._t1_7p0021u47,._t2_7p0021u47._t2_7p0021u47._t2_7p0021u47{margin-left:272px;}
  ._a_7p002ikad,._t1_7p002ikad._t1_7p002ikad,._t2_7p002ikad._t2_7p002ikad._t2_7p002ikad{margin-left:282px;}
  ._a_7p0025ef7,._t1_7p0025ef7._t1_7p0025ef7,._t2_7p0025ef7._t2_7p0025ef7._t2_7p0025ef7{margin-left:332px;}
  ._a_940020dgx,._t1_940020dgx._t1_940020dgx,._t2_940020dgx._t2_940020dgx._t2_940020dgx{padding-left:342px;}
  ._a_3n0041pt6,._t1_3n0041pt6._t1_3n0041pt6,._t2_3n0041pt6._t2_3n0041pt6._t2_3n0041pt6{border-top-left-radius:362px;}
  ._a_94008l2i8,._t1_94008l2i8._t1_94008l2i8,._t2_94008l2i8._t2_94008l2i8._t2_94008l2i8{padding-top:372px;}
  ._a_8r0023rg8,._t1_8r0023rg8._t1_8r0023rg8,._t2_8r0023rg8._t2_8r0023rg8._t2_8r0023rg8{overflow-y:auto;}
  ._a_6f002wim3,._t1_6f002wim3._t1_6f002wim3,._t2_6f002wim3._t2_6f002wim3._t2_6f002wim3{row-gap:392px;}
  ._a_710089sgg,._t1_710089sgg._t1_710089sgg,._t2_710089sgg._t2_710089sgg._t2_710089sgg{top:402px;}
  ._a_94008mlcw,._t1_94008mlcw._t1_94008mlcw,._t2_94008mlcw._t2_94008mlcw._t2_94008mlcw{padding-top:412px;}
  ._a_7p004l0kr,._t1_7p004l0kr._t1_7p004l0kr,._t2_7p004l0kr._t2_7p004l0kr._t2_7p004l0kr{margin-right:424px;}
  ._a_94008etwy,._t1_94008etwy._t1_94008etwy,._t2_94008etwy._t2_94008etwy._t2_94008etwy{padding-top:432px;}
  ._a_oe8sa94008kxgz,._t1_oe8sa94008kxgz._t1_oe8sa94008kxgz,._t2_oe8sa94008kxgz._t2_oe8sa94008kxgz._t2_oe8sa94008kxgz{padding-top:452px !important;}
  ._a_940085dyq,._t1_940085dyq._t1_940085dyq,._t2_940085dyq._t2_940085dyq._t2_940085dyq{padding-top:462px;}
  ._a_6500wiyg8,._t1_6500wiyg8._t1_6500wiyg8,._t2_6500wiyg8._t2_6500wiyg8._t2_6500wiyg8{font-size:29px;}
  ._a_39004ki2q,._t1_39004ki2q._t1_39004ki2q,._t2_39004ki2q._t2_39004ki2q._t2_39004ki2q{background-color:rgb(48, 0, 1);}
  ._a_60002eqnu,._t1_60002eqnu._t1_60002eqnu,._t2_60002eqnu._t2_60002eqnu._t2_60002eqnu{flex-grow:3;}
  ._a_94008nyqa,._t1_94008nyqa._t1_94008nyqa,._t2_94008nyqa._t2_94008nyqa._t2_94008nyqa{padding-top:522px;}
  ._a_94008l9h9,._t1_94008l9h9._t1_94008l9h9,._t2_94008l9h9._t2_94008l9h9._t2_94008l9h9{padding-top:533px;}
  ._a_94008suso,._t1_94008suso._t1_94008suso,._t2_94008suso._t2_94008suso._t2_94008suso{padding-top:543px;}
  ._a_94008squy,._t1_94008squy._t1_94008squy,._t2_94008squy._t2_94008squy._t2_94008squy{padding-top:551px;}
  ._a_940086kdf,._t1_940086kdf._t1_940086kdf,._t2_940086kdf._t2_940086kdf._t2_940086kdf{padding-top:561px;}
  ._a_94008vkr1,._t1_94008vkr1._t1_94008vkr1,._t2_94008vkr1._t2_94008vkr1._t2_94008vkr1{padding-top:592px;}
  ._a_94008awxs,._t1_94008awxs._t1_94008awxs,._t2_94008awxs._t2_94008awxs._t2_94008awxs{padding-top:601px;}
  ._a_3hcn4bbg5,._t1_3hcn4bbg5._t1_3hcn4bbg5,._t2_3hcn4bbg5._t2_3hcn4bbg5._t2_3hcn4bbg5{border-top-color:rgb(35, 2, 0);}
  ._a_3hekg8hxa,._t1_3hekg8hxa._t1_3hekg8hxa,._t2_3hekg8hxa._t2_3hekg8hxa._t2_3hekg8hxa{border-top-width:502px;}
  ._a_qyw7u4exirz:hover,._t1_qyw7u4exirz._t1_qyw7u4exirz:hover,._t2_qyw7u4exirz._t2_qyw7u4exirz._t2_qyw7u4exirz:hover{color:rgb(232, 0, 0);}
  ._a_qyw7u94o0wc:hover,._t1_qyw7u94o0wc._t1_qyw7u94o0wc:hover,._t2_qyw7u94o0wc._t2_qyw7u94o0wc._t2_qyw7u94o0wc:hover{padding:441px;}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l94w9fm,._t1_0kk4l94w9fm._t1_0kk4l94w9fm,._t2_0kk4l94w9fm._t2_0kk4l94w9fm._t2_0kk4l94w9fm{padding:261px;}}}
  @media (max-width: 1200px) {._a_0p2f094zocp,._t1_0p2f094zocp._t1_0p2f094zocp,._t2_0p2f094zocp._t2_0p2f094zocp._t2_0p2f094zocp{padding:611px;}}
  @media (max-width: 1200px) {._a_0p2f094tzg7,._t1_0p2f094tzg7._t1_0p2f094tzg7,._t2_0p2f094tzg7._t2_0p2f094tzg7._t2_0p2f094tzg7{padding:621px;}}
  @media (max-width: 1200px) {._a_0p2f094tq86,._t1_0p2f094tq86._t1_0p2f094tq86,._t2_0p2f094tq86._t2_0p2f094tq86._t2_0p2f094tq86{padding:var(--g01_x-w1rss1);}}
  @media (max-width: 1200px) {._a_0p2f094hffm,._t1_0p2f094hffm._t1_0p2f094hffm,._t2_0p2f094hffm._t2_0p2f094hffm._t2_0p2f094hffm{padding:var(--g02_a_v1-1r7r0iu) var(--g02_a_v2-qruzaz);}}
  @media (max-width: 1200px) {._a_0p2f094jnqi,._t1_0p2f094jnqi._t1_0p2f094jnqi,._t2_0p2f094jnqi._t2_0p2f094jnqi._t2_0p2f094jnqi{padding:131px var(--g03_x-1vl3uw1);}}
  @media (max-width: 1200px) {._a_0p2f094hyvd,._t1_0p2f094hyvd._t1_0p2f094hyvd,._t2_0p2f094hyvd._t2_0p2f094hyvd._t2_0p2f094hyvd{padding:var(--g04_a_v1-1ouxgl4) var(--g04_a_v2-j48dgx) var(--g04_a_v3-jrtvxi) var(--g04_a_v4-n1omg4);}}
  @media (max-width: 1200px) {._a_0p2f094twy5,._t1_0p2f094twy5._t1_0p2f094twy5,._t2_0p2f094twy5._t2_0p2f094twy5._t2_0p2f094twy5{padding:var(--g05-p, 152px);}}
  @media (max-width: 1200px) {._a_0p2f094gldf,._t1_0p2f094gldf._t1_0p2f094gldf,._t2_0p2f094gldf._t2_0p2f094gldf._t2_0p2f094gldf{padding:161px;}}
  @media (max-width: 1200px) {._a_0p2f094m3ut,._t1_0p2f094m3ut._t1_0p2f094m3ut,._t2_0p2f094m3ut._t2_0p2f094m3ut._t2_0p2f094m3ut{padding:var(--g08_a_v1-g0aivi);}}
  @media (max-width: 1200px) {._a_cusig4exlm3 .child,._t1_cusig4exlm3._t1_cusig4exlm3 .child,._t2_cusig4exlm3._t2_cusig4exlm3._t2_cusig4exlm3 .child{color:rgb(221, 0, 0);}}
  @media (max-width: 1200px) {._a_cusig4ehjl1 .child,._t1_cusig4ehjl1._t1_cusig4ehjl1 .child,._t2_cusig4ehjl1._t2_cusig4ehjl1._t2_cusig4ehjl1 .child{color:rgb(241, 0, 0);}}
  @media (max-width: 1200px) {._a_cusig4e2nat .child,._t1_cusig4e2nat._t1_cusig4e2nat .child,._t2_cusig4e2nat._t2_cusig4e2nat._t2_cusig4e2nat .child{color:rgb(251, 0, 0);}}
  @media (max-width: 1200px) {._a_cusig4eo88q .child,._t1_cusig4eo88q._t1_cusig4eo88q .child,._t2_cusig4eo88q._t2_cusig4eo88q._t2_cusig4eo88q .child{color:rgb(252, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f094ngjf,._t1_0p2f094ngjf._t1_0p2f094ngjf,._t2_0p2f094ngjf._t2_0p2f094ngjf._t2_0p2f094ngjf{padding:311px;}}
  @media (max-width: 900px) {._a_0f0zo94im9c,._t1_0f0zo94im9c._t1_0f0zo94im9c,._t2_0f0zo94im9c._t2_0f0zo94im9c._t2_0f0zo94im9c{padding:321px;}}
  @media (max-width: 1200px) {._a_0p2f07pnixf,._t1_0p2f07pnixf._t1_0p2f07pnixf,._t2_0p2f07pnixf._t2_0p2f07pnixf._t2_0p2f07pnixf{margin:331px auto;}}
  @media (max-width: 1200px) {._a_0p2f096fqec,._t1_0p2f096fqec._t1_0p2f096fqec,._t2_0p2f096fqec._t2_0p2f096fqec._t2_0p2f096fqec{padding-inline:341px;}}
  @media (max-width: 1200px) {._a_0p2f03hia4z,._t1_0p2f03hia4z._t1_0p2f03hia4z,._t2_0p2f03hia4z._t2_0p2f03hia4z._t2_0p2f03hia4z{border:351px solid rgb(35, 1, 0);}}
  @media (max-width: 1200px) {._a_0p2f03n9uor,._t1_0p2f03n9uor._t1_0p2f03n9uor,._t2_0p2f03n9uor._t2_0p2f03n9uor._t2_0p2f03n9uor{border-radius:361px;}}
  @media (max-width: 1200px) {._a_cht8894jcw8,._t1_cht8894jcw8._t1_cht8894jcw8,._t2_cht8894jcw8._t2_cht8894jcw8._t2_cht8894jcw8{padding:371px !important;}}
  @media (max-width: 1200px) {._a_0p2f08ruqqx,._t1_0p2f08ruqqx._t1_0p2f08ruqqx,._t2_0p2f08ruqqx._t2_0p2f08ruqqx._t2_0p2f08ruqqx{overflow:hidden;}}
  @media (max-width: 1200px) {._a_0p2f06fwk2e,._t1_0p2f06fwk2e._t1_0p2f06fwk2e,._t2_0p2f06fwk2e._t2_0p2f06fwk2e._t2_0p2f06fwk2e{gap:391px;}}
  @media (max-width: 1200px) {._a_0p2f0715yqm,._t1_0p2f0715yqm._t1_0p2f0715yqm,._t2_0p2f0715yqm._t2_0p2f0715yqm._t2_0p2f0715yqm{inset:401px;}}
  @media (max-width: 1200px) {._a_0p2f07p8dqc,._t1_0p2f07p8dqc._t1_0p2f07p8dqc,._t2_0p2f07p8dqc._t2_0p2f07p8dqc._t2_0p2f07p8dqc{margin:421px 422px 423px;}}
  @media (max-width: 1200px) {._a_0p2f095ii5y,._t1_0p2f095ii5y._t1_0p2f095ii5y,._t2_0p2f095ii5y._t2_0p2f095ii5y._t2_0p2f095ii5y{padding-block:431px;}}
  @media (max-width: 1200px) {._a_0p2f094bsll,._t1_0p2f094bsll._t1_0p2f094bsll,._t2_0p2f094bsll._t2_0p2f094bsll._t2_0p2f094bsll{padding:451px;}}
  @media (max-width: 1200px) {._a_0p2f0946b9d,._t1_0p2f0946b9d._t1_0p2f0946b9d,._t2_0p2f0946b9d._t2_0p2f0946b9d._t2_0p2f0946b9d{padding:461px;}}
  @media (max-width: 1200px) {._a_0p2f065hule,._t1_0p2f065hule._t1_0p2f065hule,._t2_0p2f065hule._t2_0p2f065hule._t2_0p2f065hule{font:14px/47px serif;}}
  @media (max-width: 1200px) {._a_0p2f039srwd,._t1_0p2f039srwd._t1_0p2f039srwd,._t2_0p2f039srwd._t2_0p2f039srwd._t2_0p2f039srwd{background:rgb(48, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f060s8gu,._t1_0p2f060s8gu._t1_0p2f060s8gu,._t2_0p2f060s8gu._t2_0p2f060s8gu._t2_0p2f060s8gu{-webkit-flex:1 1 491px;-ms-flex:1 1 491px;flex:1 1 491px;}}
  @media (max-width: 1200px) {._a_0p2f094qzpf,._t1_0p2f094qzpf._t1_0p2f094qzpf,._t2_0p2f094qzpf._t2_0p2f094qzpf._t2_0p2f094qzpf{padding:532px;}}
  @media (max-width: 1200px) {._a_0p2f094rh6e,._t1_0p2f094rh6e._t1_0p2f094rh6e,._t2_0p2f094rh6e._t2_0p2f094rh6e._t2_0p2f094rh6e{padding:542px;}}
  @media (max-width: 1200px) {._a_0p2f094m9ug,._t1_0p2f094m9ug._t1_0p2f094m9ug,._t2_0p2f094m9ug._t2_0p2f094m9ug._t2_0p2f094m9ug{padding:591px;}}
  @media (max-width: 1200px) {._a_0p2f094ow3z,._t1_0p2f094ow3z._t1_0p2f094ow3z,._t2_0p2f094ow3z._t2_0p2f094ow3z._t2_0p2f094ow3z{padding:602px;}}
  @media (max-width: 1200px) {._a_bfxpa4egtum:hover,._t1_bfxpa4egtum._t1_bfxpa4egtum:hover,._t2_bfxpa4egtum._t2_bfxpa4egtum._t2_bfxpa4egtum:hover{color:rgb(231, 0, 0);}}
  @container app-main (max-width: 1000px) {._a_0crm394sth2,._t1_0crm394sth2._t1_0crm394sth2,._t2_0crm394sth2._t2_0crm394sth2._t2_0crm394sth2{padding:411px;}}
  ._a_qyw7u94008frph:hover,._t1_qyw7u94008frph._t1_qyw7u94008frph:hover,._t2_qyw7u94008frph._t2_qyw7u94008frph._t2_qyw7u94008frph:hover{padding-top:442px;}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l7p002mm7n,._t1_0kk4l7p002mm7n._t1_0kk4l7p002mm7n,._t2_0kk4l7p002mm7n._t2_0kk4l7p002mm7n._t2_0kk4l7p002mm7n{margin-left:291px;}}}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l7p0020z0w,._t1_0kk4l7p0020z0w._t1_0kk4l7p0020z0w,._t2_0kk4l7p0020z0w._t2_0kk4l7p0020z0w._t2_0kk4l7p0020z0w{margin-left:292px;}}}
  @media (max-width: 1200px) {._in_17owvxb{padding-top:var(--g07_a_v1-1n6gf7y);}}
  @media (max-width: 1200px) {._in_1adrker{padding-top:var(--g09_b_v1-1lh50ku);}}
  @media (max-width: 1200px) {._in_85rpxf{padding-top:var(--g10_a_v1-azo504);}}
  @media (max-width: 1200px) {._a_0p2f094008xv6u,._t1_0p2f094008xv6u._t1_0p2f094008xv6u,._t2_0p2f094008xv6u._t2_0p2f094008xv6u._t2_0p2f094008xv6u{padding-top:202px;}}
  @media (max-width: 1200px) {._in_193brsh{padding-top:var(--g11_a_v1-evlpt3);}}
  @media (max-width: 1200px) {._in_lovnlp{padding-top:var(--g11_b_v1-15hdob5);}}
  @media (max-width: 1200px) {@container app-main (max-width: 1000px) {._a_0bwi47p002qdre,._t1_0bwi47p002qdre._t1_0bwi47p002qdre,._t2_0bwi47p002qdre._t2_0bwi47p002qdre._t2_0bwi47p002qdre{margin-left:271px;}}}
  @media (max-width: 1200px) {@container app-main (max-width: 1000px) {._a_0bwi47p0028h0m,._t1_0bwi47p0028h0m._t1_0bwi47p0028h0m,._t2_0bwi47p0028h0m._t2_0bwi47p0028h0m._t2_0bwi47p0028h0m{margin-left:281px;}}}
  @media (max-width: 1200px) {._a_0p2f07p0023nxv,._t1_0p2f07p0023nxv._t1_0p2f07p0023nxv,._t2_0p2f07p0023nxv._t2_0p2f07p0023nxv._t2_0p2f07p0023nxv{margin-left:301px;}}
  @media (max-width: 900px) {._a_0f0zo7p002depv,._t1_0f0zo7p002depv._t1_0f0zo7p002depv,._t2_0f0zo7p002depv._t2_0f0zo7p002depv._t2_0f0zo7p002depv{margin-left:302px;}}
  @media (max-width: 1200px) {._a_0p2f094008sipt,._t1_0p2f094008sipt._t1_0p2f094008sipt,._t2_0p2f094008sipt._t2_0p2f094008sipt._t2_0p2f094008sipt{padding-top:312px;}}
  @media (max-width: 1200px) {._a_0p2f0940085zfw,._t1_0p2f0940085zfw._t1_0p2f0940085zfw,._t2_0p2f0940085zfw._t2_0p2f0940085zfw._t2_0p2f0940085zfw{padding-top:322px;}}
  @media (max-width: 1200px) {._a_0p2f03hloka8vp,._t1_0p2f03hloka8vp._t1_0p2f03hloka8vp,._t2_0p2f03hloka8vp._t2_0p2f03hloka8vp._t2_0p2f03hloka8vp{border-width:501px;}}
  @media (max-width: 1200px) {._a_0p2f094008trvt,._t1_0p2f094008trvt._t1_0p2f094008trvt,._t2_0p2f094008trvt._t2_0p2f094008trvt._t2_0p2f094008trvt{padding-top:512px;}}
  @media (max-width: 1200px) {._a_0p2f094008o9gy,._t1_0p2f094008o9gy._t1_0p2f094008o9gy,._t2_0p2f094008o9gy._t2_0p2f094008o9gy._t2_0p2f094008o9gy{padding-top:552px;}}
  @media (max-width: 1200px) {._a_0p2f094008mwf2,._t1_0p2f094008mwf2._t1_0p2f094008mwf2,._t2_0p2f094008mwf2._t2_0p2f094008mwf2._t2_0p2f094008mwf2{padding-top:562px;}}
  @media (max-width: 1200px) {._a_0p2f0940082uxx,._t1_0p2f0940082uxx._t1_0p2f0940082uxx,._t2_0p2f0940082uxx._t2_0p2f0940082uxx._t2_0p2f0940082uxx{padding-top:572px;}}
  @media (max-width: 1200px) {._a_0p2f094008bn02,._t1_0p2f094008bn02._t1_0p2f094008bn02,._t2_0p2f094008bn02._t2_0p2f094008bn02._t2_0p2f094008bn02{padding-top:581px;}}
