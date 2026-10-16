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
  G01 b: label:g01_b _id_ra3lng _a_9400082eeg
  G01 result: label:g01_a _id_le1yyq _a_0p2f094tq86 label:g01_b _id_ra3lng _t1_9400082eeg
  G01 result style: --g01_x-w1rss1:111px
  G02 a: label:g02_a _id_1808hwv _a_0p2f094hffm
  G02 a style: --g02_a_v1-1r7r0iu:121px;--g02_a_v2-qruzaz:122px
  G02 b: label:g02_b _id_dbq0jb _a_940008tec9
  G02 result: label:g02_a _id_1808hwv _a_0p2f094hffm label:g02_b _id_dbq0jb _t1_940008tec9
  G02 result style: --g02_a_v1-1r7r0iu:121px;--g02_a_v2-qruzaz:122px
  G03 a: label:g03_a _id_1jhsssm _a_0p2f094jnqi
  G03 a style: --g03_x-1vl3uw1:132px
  G03 b: label:g03_b _id_fs8bfh _a_940008sz5p
  G03 result: label:g03_a _id_1jhsssm _a_0p2f094jnqi label:g03_b _id_fs8bfh _t1_940008sz5p
  G03 result style: --g03_x-1vl3uw1:132px
  G04 a: label:g04_a _id_eewn4v _a_0p2f094hyvd
  G04 a style: --g04_a_v1-1ouxgl4:141px;--g04_a_v2-j48dgx:142px;--g04_a_v3-jrtvxi:143px;--g04_a_v4-n1omg4:144px
  G04 b: label:g04_b _id_1ldsf4w _a_940008sqfx
  G04 result: label:g04_a _id_eewn4v _a_0p2f094hyvd label:g04_b _id_1ldsf4w _t1_940008sqfx
  G04 result style: --g04_a_v1-1ouxgl4:141px;--g04_a_v2-j48dgx:142px;--g04_a_v3-jrtvxi:143px;--g04_a_v4-n1omg4:144px
  G05 a: label:g05_a _id_1ei3u6a _a_0p2f094twy5
  G05 b: label:g05_b _id_5xml11 _a_940008hwvz
  G05 result: label:g05_a _id_1ei3u6a _a_0p2f094twy5 label:g05_b _id_5xml11 _t1_940008hwvz
  G06 a: label:g06_a _id_cocjkr _a_0p2f094gldf
  G06 b: label:g06_b _id_1osqhf3 _a_940008c1lf
  G06 b style: --g06_b_v1-1mo9n5b:162px
  G06 result: label:g06_a _id_cocjkr _a_0p2f094gldf label:g06_b _id_1osqhf3 _t1_940008c1lf
  G06 result style: --g06_b_v1-1mo9n5b:162px
  G07 a: label:g07_a _id_22o0f1 _in_17owvxb
  G07 a style: --g07_a_v1-1n6gf7y:171px
  G07 b: label:g07_b _id_4yzruu _a_940008eqd3
  G07 result: label:g07_a _id_22o0f1 _in_17owvxb label:g07_b _id_4yzruu _a_940008eqd3
  G07 result style: --g07_a_v1-1n6gf7y:171px
  G08 a: label:g08_a _id_ghrac4 _a_0p2f094m3ut
  G08 a style: --g08_a_v1-g0aivi:181px
  G08 b: label:g08_b _id_a9w0uv _a_94ep5r
  G08 result: label:g08_a _id_ghrac4 label:g08_b _id_a9w0uv _a_94ep5r
  G08 result style: --g08_a_v1-g0aivi:181px
  G09 a: label:g09_a _id_3jliw _a_940008sawn
  G09 b: label:g09_b _id_crbk5 _in_1adrker
  G09 b style: --g09_b_v1-1lh50ku:192px
  G09 result: label:g09_a _id_3jliw _a_940008sawn label:g09_b _id_crbk5 _in_1adrker
  G09 result style: --g09_b_v1-1lh50ku:192px
  G10 a: label:g10_a _id_9jyret _in_85rpxf
  G10 a style: --g10_a_v1-azo504:201px
  G10 b: label:g10_b _id_v2ts67 _a_0p2f0940008xv6u
  G10 result: label:g10_a _id_9jyret _in_85rpxf label:g10_b _id_v2ts67 _a_0p2f0940008xv6u
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
  G16 b: label:g16_b _id_i91hv1 _a_940008wnds
  G16 result: label:g16_a _id_dmso15 _a_0kk4l94w9fm label:g16_b _id_i91hv1 _t1_940008wnds
  G17 a: label:g17_a _id_1tqi38q _a_0bwi47p0002qdre
  G17 b: label:g17_b _id_1xhi4qf _a_7p00021u47
  G17 result: label:g17_a _id_1tqi38q label:g17_b _id_1xhi4qf _a_7p00021u47
  G18 a: label:g18_a _id_qve405 _a_0bwi47p00028h0m
  G18 b: label:g18_b _id_1t29m73 _a_7p0002ikad
  G18 result: label:g18_a _id_qve405 label:g18_b _id_1t29m73 _a_7p0002ikad
  G19 a: label:g19_a _id_1y5qofl _a_0kk4l7p0002mm7n
  G19 b: label:g19_b _id_1thyb6p _a_0kk4l7p00020z0w
  G19 result: label:g19_a _id_1y5qofl label:g19_b _id_1thyb6p _a_0kk4l7p00020z0w
  G20 a: label:g20_a _id_g0g3nc _a_0p2f07p00023nxv
  G20 b: label:g20_b _id_1c074z _a_0f0zo7p0002depv
  G20 result: label:g20_a _id_g0g3nc _a_0p2f07p00023nxv label:g20_b _id_1c074z _t1_0f0zo7p0002depv
  G21 a: label:g21_a _id_h6bkvd _a_0p2f094ngjf
  G21 b: label:g21_b _id_50uen8 _a_0p2f0940008sipt
  G21 result: label:g21_a _id_h6bkvd _a_0p2f094ngjf label:g21_b _id_50uen8 _a_0p2f0940008sipt
  G22 a: label:g22_a _id_wvp4ss _a_0f0zo94im9c
  G22 b: label:g22_b _id_oypggq _a_0p2f09400085zfw
  G22 result: label:g22_a _id_wvp4ss _a_0f0zo94im9c label:g22_b _id_oypggq _t1_0p2f09400085zfw
  G23 a: label:g23_a _id_u32gtg _a_0p2f07pnixf
  G23 b: label:g23_b _id_jfn5j3 _a_7p00025ef7
  G23 result: label:g23_a _id_u32gtg _a_0p2f07pnixf label:g23_b _id_jfn5j3 _t1_7p00025ef7
  G24 a: label:g24_a _id_s7lzke _a_0p2f096fqec
  G24 b: label:g24_b _id_1rwl97z _a_9400020dgx
  G24 result: label:g24_a _id_s7lzke _a_0p2f096fqec label:g24_b _id_1rwl97z _a_9400020dgx
  G25 a: label:g25_a _id_1j8unhb _a_0p2f03hia4z
  G25 b: label:g25_b _id_146k9dn _a_3h0cn4bbg5
  G25 result: label:g25_a _id_1j8unhb _a_0p2f03hia4z label:g25_b _id_146k9dn _t1_3h0cn4bbg5
  G26 a: label:g26_a _id_1ns0cxh _a_0p2f03n9uor
  G26 b: label:g26_b _id_qu3y1t _a_3n00041pt6
  G26 result: label:g26_a _id_1ns0cxh _a_0p2f03n9uor label:g26_b _id_qu3y1t _t1_3n00041pt6
  G27 a: label:g27_a _id_idjwk1 _a_cht8894jcw8
  G27 b: label:g27_b _id_1w5b27m _a_940008l2i8
  G27 result: label:g27_a _id_idjwk1 _a_cht8894jcw8 label:g27_b _id_1w5b27m _a_940008l2i8
  G28 a: label:g28_a _id_1h8z5lg _a_0p2f08ruqqx
  G28 b: label:g28_b _id_jzungn _a_8r00023rg8
  G28 result: label:g28_a _id_1h8z5lg _a_0p2f08ruqqx label:g28_b _id_jzungn _t1_8r00023rg8
  G29 a: label:g29_a _id_vjm16n _a_0p2f06fwk2e
  G29 b: label:g29_b _id_1282sm0 _a_6f0002wim3
  G29 result: label:g29_a _id_vjm16n _a_0p2f06fwk2e label:g29_b _id_1282sm0 _t1_6f0002wim3
  G30 a: label:g30_a _id_16u89p1 _a_0p2f0715yqm
  G30 b: label:g30_b _id_1t5hezu _a_7100089sgg
  G30 result: label:g30_a _id_16u89p1 _a_0p2f0715yqm label:g30_b _id_1t5hezu _t1_7100089sgg
  G31 a: label:g31_a _id_1db9ple _a_0crm394sth2
  G31 b: label:g31_b _id_6mttqr _a_940008mlcw
  G31 result: label:g31_a _id_1db9ple _a_0crm394sth2 label:g31_b _id_6mttqr _t1_940008mlcw
  G32 a: label:g32_a _id_1rc4ldg _a_0p2f07p8dqc
  G32 b: label:g32_b _id_1gigiji _a_7p0004l0kr
  G32 result: label:g32_a _id_1rc4ldg _a_0p2f07p8dqc label:g32_b _id_1gigiji _t1_7p0004l0kr
  G33 a: label:g33_a _id_6cxmjc _a_0p2f095ii5y
  G33 b: label:g33_b _id_1c46m52 _a_940008etwy
  G33 result: label:g33_a _id_6cxmjc _a_0p2f095ii5y label:g33_b _id_1c46m52 _a_940008etwy
  G34 a: label:g34_a _id_qxuwbj _a_qyw7u94o0wc
  G34 b: label:g34_b _id_sr8hg6 _a_qyw7u940008frph
  G34 result: label:g34_a _id_qxuwbj _a_qyw7u94o0wc label:g34_b _id_sr8hg6 _a_qyw7u940008frph
  G35 a: label:g35_a _id_uoavdd _a_0p2f094bsll
  G35 b: label:g35_b _id_ryi4kf _a_oe8sa940008kxgz
  G35 result: label:g35_a _id_uoavdd _a_0p2f094bsll label:g35_b _id_ryi4kf _a_oe8sa940008kxgz
  G36 a: label:g36_a _id_8c420j _a_0p2f0946b9d
  G36 b: label:g36_b _id_1lgmiy8 _a_9400085dyq
  G36 result: label:g36_a _id_8c420j _a_0p2f0946b9d label:g36_b _id_1lgmiy8 _t1_9400085dyq
  G37 a: label:g37_a _id_1qcjczj _a_0p2f065hule
  G37 b: label:g37_b _id_q7haz2 _a_65000wiyg8
  G37 result: label:g37_a _id_1qcjczj _a_0p2f065hule label:g37_b _id_q7haz2 _t1_65000wiyg8
  G38 a: label:g38_a _id_sd8g9c _a_0p2f039srwd
  G38 b: label:g38_b _id_rz6q8 _a_390004ki2q
  G38 result: label:g38_a _id_sd8g9c _a_0p2f039srwd label:g38_b _id_rz6q8 _t1_390004ki2q
  G39 a: label:g39_a _id_1c2tfi3 _a_0p2f060s8gu
  G39 b: label:g39_b _id_1jnvcdv _a_600002eqnu
  G39 result: label:g39_a _id_1c2tfi3 _a_0p2f060s8gu label:g39_b _id_1jnvcdv _t1_600002eqnu
  G40 a: label:g40_a _id_1w99iz0 _a_0p2f03h1loka8vp
  G40 b: label:g40_b _id_15if4y7 _a_3h1ekg8hxa
  G40 result: label:g40_a _id_1w99iz0 _a_0p2f03h1loka8vp label:g40_b _id_15if4y7 _t1_3h1ekg8hxa
  G41 a: label:g41_a _id_y3dsix _a_94wjd5
  G41 b: label:g41_b _id_ge53b8 _a_0p2f0940008trvt
  G41 result: label:g41_a _id_y3dsix _a_94wjd5 label:g41_b _id_ge53b8 _a_0p2f0940008trvt
  G42 a: label:g42_a _id_yoi53l _a_oe8sa94qxz8
  G42 b: label:g42_b _id_1f5qbqx _a_940008nyqa
  G42 result: label:g42_a _id_yoi53l _a_oe8sa94qxz8 label:g42_b _id_1f5qbqx _a_940008nyqa
  G43 a: label:g43_a _id_sb6z64 _a_9425e1
  G43 b: label:g43_b _id_1mv8eg2 _a_0p2f094qzpf
  G43 c: label:g43_c _id_g3bnrh _a_940008l9h9
  G43 result: label:g43_a _id_sb6z64 _a_9425e1 label:g43_b _id_1mv8eg2 _a_0p2f094qzpf label:g43_c _id_g3bnrh _t1_940008l9h9
  G44 a: label:g44_a _id_1iw4kr9 _a_94layi
  G44 b: label:g44_b _id_o1mr6z _a_0p2f094rh6e
  G44 c: label:g44_c _id_1kt9tm5 _a_940008suso
  G44 result: label:g44_a _id_1iw4kr9 _a_94layi label:g44_b _id_o1mr6z _a_0p2f094rh6e label:g44_c _id_1kt9tm5 _t1_940008suso
  G45 a: label:g45_a _id_1a07bmt _a_940008squy
  G45 b: label:g45_b _id_1z0zne3 _a_0p2f0940008o9gy
  G45 c: label:g45_c _id_1gt2va2 _a_942oya
  G45 result: label:g45_a _id_1a07bmt label:g45_b _id_1z0zne3 label:g45_c _id_1gt2va2 _a_942oya
  G46 a: label:g46_a _id_11u965q _a_9400086kdf
  G46 b: label:g46_b _id_u2i51c _a_0p2f0940008mwf2
  G46 c: label:g46_c _id_w0u83i _a_94roh4
  G46 result: label:g46_a _id_11u965q label:g46_b _id_u2i51c label:g46_c _id_w0u83i _a_94roh4
  G47 a: label:g47_a _id_7zjga4 _a_94a4gd
  G47 b: label:g47_b _id_1izug5q _a_0p2f09400082uxx
  G47 result: label:g47 _id_1dto0oe _a_94a4gd _a_0p2f09400082uxx
  G48 a: label:g48_a _id_epkxz0 _a_0p2f0940008bn02
  G48 b: label:g48_b _id_1vtw6u8 _a_944pn0
  G48 result: label:g48 _id_uvlb5j _a_944pn0
  G49 a: label:g49_a _id_epc09d _a_0p2f094m9ug
  G49 b: label:g49_b _id_n2bfd5 _a_940008vkr1
  G49 result: label:g49 _id_ft4hgr _a_0p2f094m9ug _t1_940008vkr1
  G50 a: label:g50_a _id_kel9e1 _a_940008awxs
  G50 b: label:g50_b _id_7nrwrz _a_0p2f094ow3z
  G50 result: label:g50 _id_pvs05l _a_940008awxs _a_0p2f094ow3z
  G51 a: label:g51_a _id_9hqx1q _a_0p2f094zocp
  G51 b: label:g51_b _id_154dcwn _a_940008oudn
  G51 result: label:g51_a _id_9hqx1q _a_0p2f094zocp label:g51_b _id_154dcwn _t1_940008oudn
  G51S a: label:g51s_a _id_1ip4w0k _a_0p2f094tzg7
  G51S b: label:g51s_b _id_1hdhg2z _a_940008324g
  G51S result: label:g51s_a _id_1ip4w0k _a_0p2f094tzg7 label:g51s_b _id_1hdhg2z _t1_940008324g

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
  ._a_94ep5r,._t1_94ep5r:not(x-),._t2_94ep5r:not(x-):not(x-){padding:182px;}
  ._a_s19nz4epz1m .child,._t1_s19nz4epz1m:not(x-) .child,._t2_s19nz4epz1m:not(x-):not(x-) .child{color:rgb(222, 0, 0);}
  ._a_s19nz4ev00p .child,._t1_s19nz4ev00p:not(x-) .child,._t2_s19nz4ev00p:not(x-):not(x-) .child{color:rgb(242, 0, 0);}
  ._a_94wjd5,._t1_94wjd5:not(x-),._t2_94wjd5:not(x-):not(x-){padding:511px;}
  ._a_oe8sa94qxz8,._t1_oe8sa94qxz8:not(x-),._t2_oe8sa94qxz8:not(x-):not(x-){padding:521px !important;}
  ._a_9425e1,._t1_9425e1:not(x-),._t2_9425e1:not(x-):not(x-){padding:531px;}
  ._a_94layi,._t1_94layi:not(x-),._t2_94layi:not(x-):not(x-){padding:541px;}
  ._a_942oya,._t1_942oya:not(x-),._t2_942oya:not(x-):not(x-){padding:553px;}
  ._a_94roh4,._t1_94roh4:not(x-),._t2_94roh4:not(x-):not(x-){padding:563px;}
  ._a_94a4gd,._t1_94a4gd:not(x-),._t2_94a4gd:not(x-):not(x-){padding:571px;}
  ._a_944pn0,._t1_944pn0:not(x-),._t2_944pn0:not(x-):not(x-){padding:582px;}
  ._a_940008oudn,._t1_940008oudn:not(x-),._t2_940008oudn:not(x-):not(x-){padding-top:612px;}
  ._a_940008324g,._t1_940008324g:not(x-),._t2_940008324g:not(x-):not(x-){padding-top:622px;}
  ._a_9400082eeg,._t1_9400082eeg:not(x-),._t2_9400082eeg:not(x-):not(x-){padding-top:112px;}
  ._a_940008tec9,._t1_940008tec9:not(x-),._t2_940008tec9:not(x-):not(x-){padding-top:123px;}
  ._a_940008sz5p,._t1_940008sz5p:not(x-),._t2_940008sz5p:not(x-):not(x-){padding-top:133px;}
  ._a_940008sqfx,._t1_940008sqfx:not(x-),._t2_940008sqfx:not(x-):not(x-){padding-top:145px;}
  ._a_940008hwvz,._t1_940008hwvz:not(x-),._t2_940008hwvz:not(x-):not(x-){padding-top:151px;}
  ._a_940008c1lf,._t1_940008c1lf:not(x-),._t2_940008c1lf:not(x-):not(x-){padding-top:var(--g06_b_v1-1mo9n5b);}
  ._in_17owvxb{padding-top:var(--g07_a_v1-1n6gf7y);}
  ._a_940008eqd3,._t1_940008eqd3:not(x-),._t2_940008eqd3:not(x-):not(x-){padding-top:172px;}
  ._a_940008sawn,._t1_940008sawn:not(x-),._t2_940008sawn:not(x-):not(x-){padding-top:191px;}
  ._in_1adrker{padding-top:var(--g09_b_v1-1lh50ku);}
  ._in_85rpxf{padding-top:var(--g10_a_v1-azo504);}
  ._in_193brsh{padding-top:var(--g11_a_v1-evlpt3);}
  ._in_lovnlp{padding-top:var(--g11_b_v1-15hdob5);}
  ._a_940008wnds,._t1_940008wnds:not(x-),._t2_940008wnds:not(x-):not(x-){padding-top:262px;}
  ._a_7p00021u47,._t1_7p00021u47:not(x-),._t2_7p00021u47:not(x-):not(x-){margin-left:272px;}
  ._a_7p0002ikad,._t1_7p0002ikad:not(x-),._t2_7p0002ikad:not(x-):not(x-){margin-left:282px;}
  ._a_7p00025ef7,._t1_7p00025ef7:not(x-),._t2_7p00025ef7:not(x-):not(x-){margin-left:332px;}
  ._a_9400020dgx,._t1_9400020dgx:not(x-),._t2_9400020dgx:not(x-):not(x-){padding-left:342px;}
  ._a_3n00041pt6,._t1_3n00041pt6:not(x-),._t2_3n00041pt6:not(x-):not(x-){border-top-left-radius:362px;}
  ._a_940008l2i8,._t1_940008l2i8:not(x-),._t2_940008l2i8:not(x-):not(x-){padding-top:372px;}
  ._a_8r00023rg8,._t1_8r00023rg8:not(x-),._t2_8r00023rg8:not(x-):not(x-){overflow-y:auto;}
  ._a_6f0002wim3,._t1_6f0002wim3:not(x-),._t2_6f0002wim3:not(x-):not(x-){row-gap:392px;}
  ._a_7100089sgg,._t1_7100089sgg:not(x-),._t2_7100089sgg:not(x-):not(x-){top:402px;}
  ._a_940008mlcw,._t1_940008mlcw:not(x-),._t2_940008mlcw:not(x-):not(x-){padding-top:412px;}
  ._a_7p0004l0kr,._t1_7p0004l0kr:not(x-),._t2_7p0004l0kr:not(x-):not(x-){margin-right:424px;}
  ._a_940008etwy,._t1_940008etwy:not(x-),._t2_940008etwy:not(x-):not(x-){padding-top:432px;}
  ._a_oe8sa940008kxgz,._t1_oe8sa940008kxgz:not(x-),._t2_oe8sa940008kxgz:not(x-):not(x-){padding-top:452px !important;}
  ._a_9400085dyq,._t1_9400085dyq:not(x-),._t2_9400085dyq:not(x-):not(x-){padding-top:462px;}
  ._a_65000wiyg8,._t1_65000wiyg8:not(x-),._t2_65000wiyg8:not(x-):not(x-){font-size:29px;}
  ._a_390004ki2q,._t1_390004ki2q:not(x-),._t2_390004ki2q:not(x-):not(x-){background-color:rgb(48, 0, 1);}
  ._a_600002eqnu,._t1_600002eqnu:not(x-),._t2_600002eqnu:not(x-):not(x-){flex-grow:3;}
  ._a_940008nyqa,._t1_940008nyqa:not(x-),._t2_940008nyqa:not(x-):not(x-){padding-top:522px;}
  ._a_940008l9h9,._t1_940008l9h9:not(x-),._t2_940008l9h9:not(x-):not(x-){padding-top:533px;}
  ._a_940008suso,._t1_940008suso:not(x-),._t2_940008suso:not(x-):not(x-){padding-top:543px;}
  ._a_940008squy,._t1_940008squy:not(x-),._t2_940008squy:not(x-):not(x-){padding-top:551px;}
  ._a_9400086kdf,._t1_9400086kdf:not(x-),._t2_9400086kdf:not(x-):not(x-){padding-top:561px;}
  ._a_940008vkr1,._t1_940008vkr1:not(x-),._t2_940008vkr1:not(x-):not(x-){padding-top:592px;}
  ._a_940008awxs,._t1_940008awxs:not(x-),._t2_940008awxs:not(x-):not(x-){padding-top:601px;}
  ._a_3h0cn4bbg5,._t1_3h0cn4bbg5:not(x-),._t2_3h0cn4bbg5:not(x-):not(x-){border-top-color:rgb(35, 2, 0);}
  ._a_3h1ekg8hxa,._t1_3h1ekg8hxa:not(x-),._t2_3h1ekg8hxa:not(x-):not(x-){border-top-width:502px;}
  ._a_qyw7u4exirz:hover,._t1_qyw7u4exirz:not(x-):hover,._t2_qyw7u4exirz:not(x-):not(x-):hover{color:rgb(232, 0, 0);}
  ._a_qyw7u94o0wc:hover,._t1_qyw7u94o0wc:not(x-):hover,._t2_qyw7u94o0wc:not(x-):not(x-):hover{padding:441px;}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l94w9fm,._t1_0kk4l94w9fm:not(x-),._t2_0kk4l94w9fm:not(x-):not(x-){padding:261px;}}}
  @media (max-width: 1200px) {._a_0p2f094zocp,._t1_0p2f094zocp:not(x-),._t2_0p2f094zocp:not(x-):not(x-){padding:611px;}}
  @media (max-width: 1200px) {._a_0p2f094tzg7,._t1_0p2f094tzg7:not(x-),._t2_0p2f094tzg7:not(x-):not(x-){padding:621px;}}
  @media (max-width: 1200px) {._a_0p2f094tq86,._t1_0p2f094tq86:not(x-),._t2_0p2f094tq86:not(x-):not(x-){padding:var(--g01_x-w1rss1);}}
  @media (max-width: 1200px) {._a_0p2f094hffm,._t1_0p2f094hffm:not(x-),._t2_0p2f094hffm:not(x-):not(x-){padding:var(--g02_a_v1-1r7r0iu) var(--g02_a_v2-qruzaz);}}
  @media (max-width: 1200px) {._a_0p2f094jnqi,._t1_0p2f094jnqi:not(x-),._t2_0p2f094jnqi:not(x-):not(x-){padding:131px var(--g03_x-1vl3uw1);}}
  @media (max-width: 1200px) {._a_0p2f094hyvd,._t1_0p2f094hyvd:not(x-),._t2_0p2f094hyvd:not(x-):not(x-){padding:var(--g04_a_v1-1ouxgl4) var(--g04_a_v2-j48dgx) var(--g04_a_v3-jrtvxi) var(--g04_a_v4-n1omg4);}}
  @media (max-width: 1200px) {._a_0p2f094twy5,._t1_0p2f094twy5:not(x-),._t2_0p2f094twy5:not(x-):not(x-){padding:var(--g05-p, 152px);}}
  @media (max-width: 1200px) {._a_0p2f094gldf,._t1_0p2f094gldf:not(x-),._t2_0p2f094gldf:not(x-):not(x-){padding:161px;}}
  @media (max-width: 1200px) {._a_0p2f094m3ut,._t1_0p2f094m3ut:not(x-),._t2_0p2f094m3ut:not(x-):not(x-){padding:var(--g08_a_v1-g0aivi);}}
  @media (max-width: 1200px) {._a_cusig4exlm3 .child,._t1_cusig4exlm3:not(x-) .child,._t2_cusig4exlm3:not(x-):not(x-) .child{color:rgb(221, 0, 0);}}
  @media (max-width: 1200px) {._a_cusig4ehjl1 .child,._t1_cusig4ehjl1:not(x-) .child,._t2_cusig4ehjl1:not(x-):not(x-) .child{color:rgb(241, 0, 0);}}
  @media (max-width: 1200px) {._a_cusig4e2nat .child,._t1_cusig4e2nat:not(x-) .child,._t2_cusig4e2nat:not(x-):not(x-) .child{color:rgb(251, 0, 0);}}
  @media (max-width: 1200px) {._a_cusig4eo88q .child,._t1_cusig4eo88q:not(x-) .child,._t2_cusig4eo88q:not(x-):not(x-) .child{color:rgb(252, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f094ngjf,._t1_0p2f094ngjf:not(x-),._t2_0p2f094ngjf:not(x-):not(x-){padding:311px;}}
  @media (max-width: 900px) {._a_0f0zo94im9c,._t1_0f0zo94im9c:not(x-),._t2_0f0zo94im9c:not(x-):not(x-){padding:321px;}}
  @media (max-width: 1200px) {._a_0p2f07pnixf,._t1_0p2f07pnixf:not(x-),._t2_0p2f07pnixf:not(x-):not(x-){margin:331px auto;}}
  @media (max-width: 1200px) {._a_0p2f096fqec,._t1_0p2f096fqec:not(x-),._t2_0p2f096fqec:not(x-):not(x-){padding-inline:341px;}}
  @media (max-width: 1200px) {._a_0p2f03hia4z,._t1_0p2f03hia4z:not(x-),._t2_0p2f03hia4z:not(x-):not(x-){border:351px solid rgb(35, 1, 0);}}
  @media (max-width: 1200px) {._a_0p2f03n9uor,._t1_0p2f03n9uor:not(x-),._t2_0p2f03n9uor:not(x-):not(x-){border-radius:361px;}}
  @media (max-width: 1200px) {._a_cht8894jcw8,._t1_cht8894jcw8:not(x-),._t2_cht8894jcw8:not(x-):not(x-){padding:371px !important;}}
  @media (max-width: 1200px) {._a_0p2f08ruqqx,._t1_0p2f08ruqqx:not(x-),._t2_0p2f08ruqqx:not(x-):not(x-){overflow:hidden;}}
  @media (max-width: 1200px) {._a_0p2f06fwk2e,._t1_0p2f06fwk2e:not(x-),._t2_0p2f06fwk2e:not(x-):not(x-){gap:391px;}}
  @media (max-width: 1200px) {._a_0p2f0715yqm,._t1_0p2f0715yqm:not(x-),._t2_0p2f0715yqm:not(x-):not(x-){inset:401px;}}
  @media (max-width: 1200px) {._a_0p2f07p8dqc,._t1_0p2f07p8dqc:not(x-),._t2_0p2f07p8dqc:not(x-):not(x-){margin:421px 422px 423px;}}
  @media (max-width: 1200px) {._a_0p2f095ii5y,._t1_0p2f095ii5y:not(x-),._t2_0p2f095ii5y:not(x-):not(x-){padding-block:431px;}}
  @media (max-width: 1200px) {._a_0p2f094bsll,._t1_0p2f094bsll:not(x-),._t2_0p2f094bsll:not(x-):not(x-){padding:451px;}}
  @media (max-width: 1200px) {._a_0p2f0946b9d,._t1_0p2f0946b9d:not(x-),._t2_0p2f0946b9d:not(x-):not(x-){padding:461px;}}
  @media (max-width: 1200px) {._a_0p2f065hule,._t1_0p2f065hule:not(x-),._t2_0p2f065hule:not(x-):not(x-){font:14px/47px serif;}}
  @media (max-width: 1200px) {._a_0p2f039srwd,._t1_0p2f039srwd:not(x-),._t2_0p2f039srwd:not(x-):not(x-){background:rgb(48, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f060s8gu,._t1_0p2f060s8gu:not(x-),._t2_0p2f060s8gu:not(x-):not(x-){-webkit-flex:1 1 491px;-ms-flex:1 1 491px;flex:1 1 491px;}}
  @media (max-width: 1200px) {._a_0p2f094qzpf,._t1_0p2f094qzpf:not(x-),._t2_0p2f094qzpf:not(x-):not(x-){padding:532px;}}
  @media (max-width: 1200px) {._a_0p2f094rh6e,._t1_0p2f094rh6e:not(x-),._t2_0p2f094rh6e:not(x-):not(x-){padding:542px;}}
  @media (max-width: 1200px) {._a_0p2f094m9ug,._t1_0p2f094m9ug:not(x-),._t2_0p2f094m9ug:not(x-):not(x-){padding:591px;}}
  @media (max-width: 1200px) {._a_0p2f094ow3z,._t1_0p2f094ow3z:not(x-),._t2_0p2f094ow3z:not(x-):not(x-){padding:602px;}}
  @media (max-width: 1200px) {._a_bfxpa4egtum:hover,._t1_bfxpa4egtum:not(x-):hover,._t2_bfxpa4egtum:not(x-):not(x-):hover{color:rgb(231, 0, 0);}}
  @container app-main (max-width: 1000px) {._a_0crm394sth2,._t1_0crm394sth2:not(x-),._t2_0crm394sth2:not(x-):not(x-){padding:411px;}}
  ._a_qyw7u940008frph:hover,._t1_qyw7u940008frph:not(x-):hover,._t2_qyw7u940008frph:not(x-):not(x-):hover{padding-top:442px;}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l7p0002mm7n,._t1_0kk4l7p0002mm7n:not(x-),._t2_0kk4l7p0002mm7n:not(x-):not(x-){margin-left:291px;}}}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l7p00020z0w,._t1_0kk4l7p00020z0w:not(x-),._t2_0kk4l7p00020z0w:not(x-):not(x-){margin-left:292px;}}}
  @media (max-width: 1200px) {._in_17owvxb{padding-top:var(--g07_a_v1-1n6gf7y);}}
  @media (max-width: 1200px) {._in_1adrker{padding-top:var(--g09_b_v1-1lh50ku);}}
  @media (max-width: 1200px) {._in_85rpxf{padding-top:var(--g10_a_v1-azo504);}}
  @media (max-width: 1200px) {._a_0p2f0940008xv6u,._t1_0p2f0940008xv6u:not(x-),._t2_0p2f0940008xv6u:not(x-):not(x-){padding-top:202px;}}
  @media (max-width: 1200px) {._in_193brsh{padding-top:var(--g11_a_v1-evlpt3);}}
  @media (max-width: 1200px) {._in_lovnlp{padding-top:var(--g11_b_v1-15hdob5);}}
  @media (max-width: 1200px) {@container app-main (max-width: 1000px) {._a_0bwi47p0002qdre,._t1_0bwi47p0002qdre:not(x-),._t2_0bwi47p0002qdre:not(x-):not(x-){margin-left:271px;}}}
  @media (max-width: 1200px) {@container app-main (max-width: 1000px) {._a_0bwi47p00028h0m,._t1_0bwi47p00028h0m:not(x-),._t2_0bwi47p00028h0m:not(x-):not(x-){margin-left:281px;}}}
  @media (max-width: 1200px) {._a_0p2f07p00023nxv,._t1_0p2f07p00023nxv:not(x-),._t2_0p2f07p00023nxv:not(x-):not(x-){margin-left:301px;}}
  @media (max-width: 900px) {._a_0f0zo7p0002depv,._t1_0f0zo7p0002depv:not(x-),._t2_0f0zo7p0002depv:not(x-):not(x-){margin-left:302px;}}
  @media (max-width: 1200px) {._a_0p2f0940008sipt,._t1_0p2f0940008sipt:not(x-),._t2_0p2f0940008sipt:not(x-):not(x-){padding-top:312px;}}
  @media (max-width: 1200px) {._a_0p2f09400085zfw,._t1_0p2f09400085zfw:not(x-),._t2_0p2f09400085zfw:not(x-):not(x-){padding-top:322px;}}
  @media (max-width: 1200px) {._a_0p2f03h1loka8vp,._t1_0p2f03h1loka8vp:not(x-),._t2_0p2f03h1loka8vp:not(x-):not(x-){border-width:501px;}}
  @media (max-width: 1200px) {._a_0p2f0940008trvt,._t1_0p2f0940008trvt:not(x-),._t2_0p2f0940008trvt:not(x-):not(x-){padding-top:512px;}}
  @media (max-width: 1200px) {._a_0p2f0940008o9gy,._t1_0p2f0940008o9gy:not(x-),._t2_0p2f0940008o9gy:not(x-):not(x-){padding-top:552px;}}
  @media (max-width: 1200px) {._a_0p2f0940008mwf2,._t1_0p2f0940008mwf2:not(x-),._t2_0p2f0940008mwf2:not(x-):not(x-){padding-top:562px;}}
  @media (max-width: 1200px) {._a_0p2f09400082uxx,._t1_0p2f09400082uxx:not(x-),._t2_0p2f09400082uxx:not(x-):not(x-){padding-top:572px;}}
  @media (max-width: 1200px) {._a_0p2f0940008bn02,._t1_0p2f0940008bn02:not(x-),._t2_0p2f0940008bn02:not(x-):not(x-){padding-top:581px;}}
