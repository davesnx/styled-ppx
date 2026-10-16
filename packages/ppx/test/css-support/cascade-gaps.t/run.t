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
  G01 result: label:g01_a _id_le1yyq _a_0p2f094tq86 label:g01_b _id_ra3lng _a_9400082eeg
  G01 result style: --g01_x-w1rss1:111px
  G02 a: label:g02_a _id_1808hwv _a_0p2f094hffm
  G02 a style: --g02_a_v1-1r7r0iu:121px;--g02_a_v2-qruzaz:122px
  G02 b: label:g02_b _id_dbq0jb _a_940008tec9
  G02 result: label:g02_a _id_1808hwv _a_0p2f094hffm label:g02_b _id_dbq0jb _a_940008tec9
  G02 result style: --g02_a_v1-1r7r0iu:121px;--g02_a_v2-qruzaz:122px
  G03 a: label:g03_a _id_1jhsssm _a_0p2f094jnqi
  G03 a style: --g03_x-1vl3uw1:132px
  G03 b: label:g03_b _id_fs8bfh _a_940008sz5p
  G03 result: label:g03_a _id_1jhsssm _a_0p2f094jnqi label:g03_b _id_fs8bfh _a_940008sz5p
  G03 result style: --g03_x-1vl3uw1:132px
  G04 a: label:g04_a _id_eewn4v _a_0p2f09400081k0h _a_0p2f0940004fat4 _a_0p2f0940001ogyz _a_0p2f0940002bkph
  G04 a style: --g04_a_v1-3mfchy:141px;--g04_a_v2-13246d8:142px;--g04_a_v3-2oyh4u:143px;--g04_a_v4-segwmv:144px
  G04 b: label:g04_b _id_1ldsf4w _a_940008sqfx
  G04 result: label:g04_a _id_eewn4v _a_0p2f0940004fat4 _a_0p2f0940001ogyz _a_0p2f0940002bkph label:g04_b _id_1ldsf4w _a_940008sqfx
  G04 result style: --g04_a_v1-3mfchy:141px;--g04_a_v2-13246d8:142px;--g04_a_v3-2oyh4u:143px;--g04_a_v4-segwmv:144px
  G05 a: label:g05_a _id_1ei3u6a _a_0p2f094twy5
  G05 b: label:g05_b _id_5xml11 _a_940008hwvz
  G05 result: label:g05_a _id_1ei3u6a _a_0p2f094twy5 label:g05_b _id_5xml11 _a_940008hwvz
  G06 a: label:g06_a _id_cocjkr _a_0p2f0940008j5ol _a_0p2f09400041ikb _a_0p2f0940001dcsw _a_0p2f0940002978u
  G06 b: label:g06_b _id_1osqhf3 _a_940008c1lf
  G06 b style: --g06_b_v1-1mo9n5b:162px
  G06 result: label:g06_a _id_cocjkr _a_0p2f09400041ikb _a_0p2f0940001dcsw _a_0p2f0940002978u label:g06_b _id_1osqhf3 _a_940008c1lf
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
  G16 a: label:g16_a _id_dmso15 _a_0kk4l940008hrp6 _a_0kk4l940004i6xk _a_0kk4l940001odg5 _a_0kk4l940002nmo1
  G16 b: label:g16_b _id_i91hv1 _a_940008wnds
  G16 result: label:g16_a _id_dmso15 _a_0kk4l940004i6xk _a_0kk4l940001odg5 _a_0kk4l940002nmo1 label:g16_b _id_i91hv1 _a_940008wnds
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
  G20 result: label:g20_a _id_g0g3nc _a_0p2f07p00023nxv label:g20_b _id_1c074z _a_0f0zo7p0002depv
  G21 a: label:g21_a _id_h6bkvd _a_0p2f094000872cq _a_0p2f0940004p19k _a_0p2f0940001k05e _a_0p2f09400026g7e
  G21 b: label:g21_b _id_50uen8 _a_0p2f0940008sipt
  G21 result: label:g21_a _id_h6bkvd _a_0p2f0940004p19k _a_0p2f0940001k05e _a_0p2f09400026g7e label:g21_b _id_50uen8 _a_0p2f0940008sipt
  G22 a: label:g22_a _id_wvp4ss _a_0f0zo940008ilx9 _a_0f0zo9400048kd9 _a_0f0zo9400018c0j _a_0f0zo940002mt9e
  G22 b: label:g22_b _id_oypggq _a_0p2f09400085zfw
  G22 result: label:g22_a _id_wvp4ss _a_0f0zo940008ilx9 _a_0f0zo9400048kd9 _a_0f0zo9400018c0j _a_0f0zo940002mt9e label:g22_b _id_oypggq _a_0p2f09400085zfw
  G23 a: label:g23_a _id_u32gtg _a_0p2f07p0008kkzn _a_0p2f07p0004vz3c _a_0p2f07p0001qqzw _a_0p2f07p000295e0
  G23 b: label:g23_b _id_jfn5j3 _a_7p00025ef7
  G23 result: label:g23_a _id_u32gtg _a_0p2f07p0008kkzn _a_0p2f07p0004vz3c _a_0p2f07p0001qqzw label:g23_b _id_jfn5j3 _a_7p00025ef7
  G24 a: label:g24_a _id_s7lzke _a_0p2f0960002fu16 _a_0p2f09600016yxm
  G24 b: label:g24_b _id_1rwl97z _a_9400020dgx
  G24 result: label:g24_a _id_s7lzke _a_0p2f0960002fu16 _a_0p2f09600016yxm label:g24_b _id_1rwl97z _a_9400020dgx
  G25 a: label:g25_a _id_1j8unhb _a_0p2f03hia4z
  G25 b: label:g25_b _id_146k9dn _a_3h0cn4bbg5
  G25 result: label:g25_a _id_1j8unhb _a_0p2f03hia4z label:g25_b _id_146k9dn _a_3h0cn4bbg5
  G26 a: label:g26_a _id_1ns0cxh _a_0p2f03n9uor
  G26 b: label:g26_b _id_qu3y1t _a_3n00041pt6
  G26 result: label:g26_a _id_1ns0cxh _a_0p2f03n9uor label:g26_b _id_qu3y1t _a_3n00041pt6
  G27 a: label:g27_a _id_idjwk1 _a_cht88940008h4y1 _a_cht889400042kio _a_cht88940001q07u _a_cht88940002xcqh
  G27 b: label:g27_b _id_1w5b27m _a_940008l2i8
  G27 result: label:g27_a _id_idjwk1 _a_cht88940008h4y1 _a_cht889400042kio _a_cht88940001q07u _a_cht88940002xcqh label:g27_b _id_1w5b27m _a_940008l2i8
  G28 a: label:g28_a _id_1h8z5lg _a_0p2f08r0001p82m _a_0p2f08r00027qfj
  G28 b: label:g28_b _id_jzungn _a_8r00023rg8
  G28 result: label:g28_a _id_1h8z5lg _a_0p2f08r0001p82m label:g28_b _id_jzungn _a_8r00023rg8
  G29 a: label:g29_a _id_vjm16n _a_0p2f06f0002de6v _a_0p2f06f0001j773
  G29 b: label:g29_b _id_1282sm0 _a_6f0002wim3
  G29 result: label:g29_a _id_vjm16n _a_0p2f06f0001j773 label:g29_b _id_1282sm0 _a_6f0002wim3
  G30 a: label:g30_a _id_16u89p1 _a_0p2f071000869cv _a_0p2f0710004nxlc _a_0p2f0710001waae _a_0p2f07100024hp9
  G30 b: label:g30_b _id_1t5hezu _a_7100089sgg
  G30 result: label:g30_a _id_16u89p1 _a_0p2f0710004nxlc _a_0p2f0710001waae _a_0p2f07100024hp9 label:g30_b _id_1t5hezu _a_7100089sgg
  G31 a: label:g31_a _id_1db9ple _a_0crm3940008pn2p _a_0crm3940004mjdw _a_0crm39400015tw7 _a_0crm3940002o7um
  G31 b: label:g31_b _id_6mttqr _a_940008mlcw
  G31 result: label:g31_a _id_1db9ple _a_0crm3940004mjdw _a_0crm39400015tw7 _a_0crm3940002o7um label:g31_b _id_6mttqr _a_940008mlcw
  G32 a: label:g32_a _id_1rc4ldg _a_0p2f07p00080r2a _a_0p2f07p0004f8br _a_0p2f07p0001bnot _a_0p2f07p000252bz
  G32 b: label:g32_b _id_1gigiji _a_7p0004l0kr
  G32 result: label:g32_a _id_1rc4ldg _a_0p2f07p00080r2a _a_0p2f07p0001bnot _a_0p2f07p000252bz label:g32_b _id_1gigiji _a_7p0004l0kr
  G33 a: label:g33_a _id_6cxmjc _a_0p2f09500023kx0 _a_0p2f0950001ys6c
  G33 b: label:g33_b _id_1c46m52 _a_940008etwy
  G33 result: label:g33_a _id_6cxmjc _a_0p2f09500023kx0 _a_0p2f0950001ys6c label:g33_b _id_1c46m52 _a_940008etwy
  G34 a: label:g34_a _id_qxuwbj _a_qyw7u940008utii _a_qyw7u9400040mtx _a_qyw7u940001cn5g _a_qyw7u9400021pla
  G34 b: label:g34_b _id_sr8hg6 _a_qyw7u940008frph
  G34 result: label:g34_a _id_qxuwbj _a_qyw7u9400040mtx _a_qyw7u940001cn5g _a_qyw7u9400021pla label:g34_b _id_sr8hg6 _a_qyw7u940008frph
  G35 a: label:g35_a _id_uoavdd _a_0p2f0940008eb57 _a_0p2f0940004cajy _a_0p2f0940001bpli _a_0p2f0940002xtrs
  G35 b: label:g35_b _id_ryi4kf _a_oe8sa940008kxgz
  G35 result: label:g35_a _id_uoavdd _a_0p2f0940008eb57 _a_0p2f0940004cajy _a_0p2f0940001bpli _a_0p2f0940002xtrs label:g35_b _id_ryi4kf _a_oe8sa940008kxgz
  G36 a: label:g36_a _id_8c420j _a_0p2f0940008cake _a_0p2f0940004ukb6 _a_0p2f0940001vd13 _a_0p2f0940002j6gd
  G36 b: label:g36_b _id_1lgmiy8 _a_9400085dyq
  G36 result: label:g36_a _id_8c420j _a_0p2f0940004ukb6 _a_0p2f0940001vd13 _a_0p2f0940002j6gd label:g36_b _id_1lgmiy8 _a_9400085dyq
  G37 a: label:g37_a _id_1qcjczj _a_0p2f065hule
  G37 b: label:g37_b _id_q7haz2 _a_65000wiyg8
  G37 result: label:g37_a _id_1qcjczj _a_0p2f065hule label:g37_b _id_q7haz2 _a_65000wiyg8
  G38 a: label:g38_a _id_sd8g9c _a_0p2f039srwd
  G38 b: label:g38_b _id_rz6q8 _a_390004ki2q
  G38 result: label:g38_a _id_sd8g9c _a_0p2f039srwd label:g38_b _id_rz6q8 _a_390004ki2q
  G39 a: label:g39_a _id_1c2tfi3 _a_0p2f060s8gu
  G39 b: label:g39_b _id_1jnvcdv _a_600002eqnu
  G39 result: label:g39_a _id_1c2tfi3 _a_0p2f060s8gu label:g39_b _id_1jnvcdv _a_600002eqnu
  G40 a: label:g40_a _id_1w99iz0 _a_0p2f03h1ekgdkvk _a_0p2f03h06bkepi5 _a_0p2f03h0004g6ai _a_0p2f03h00sg1sx4
  G40 b: label:g40_b _id_15if4y7 _a_3h1ekg8hxa
  G40 result: label:g40_a _id_1w99iz0 _a_0p2f03h06bkepi5 _a_0p2f03h0004g6ai _a_0p2f03h00sg1sx4 label:g40_b _id_15if4y7 _a_3h1ekg8hxa
  G41 a: label:g41_a _id_y3dsix _a_94wjd5
  G41 b: label:g41_b _id_ge53b8 _a_0p2f0940008trvt
  G41 result: label:g41_a _id_y3dsix _a_94wjd5 label:g41_b _id_ge53b8 _a_0p2f0940008trvt
  G42 a: label:g42_a _id_yoi53l _a_oe8sa940008ndpl _a_oe8sa9400048i88 _a_oe8sa940001ohze _a_oe8sa940002c86j
  G42 b: label:g42_b _id_1f5qbqx _a_940008nyqa
  G42 result: label:g42_a _id_yoi53l _a_oe8sa940008ndpl _a_oe8sa9400048i88 _a_oe8sa940001ohze _a_oe8sa940002c86j label:g42_b _id_1f5qbqx _a_940008nyqa
  G43 a: label:g43_a _id_sb6z64 _a_9425e1
  G43 b: label:g43_b _id_1mv8eg2 _a_0p2f0940008skge _a_0p2f0940004w6hr _a_0p2f094000130j7 _a_0p2f09400022e78
  G43 c: label:g43_c _id_g3bnrh _a_940008l9h9
  G43 result: label:g43_a _id_sb6z64 _a_9425e1 label:g43_b _id_1mv8eg2 _a_0p2f0940004w6hr _a_0p2f094000130j7 _a_0p2f09400022e78 label:g43_c _id_g3bnrh _a_940008l9h9
  G44 a: label:g44_a _id_1iw4kr9 _a_94layi
  G44 b: label:g44_b _id_o1mr6z _a_0p2f09400080t2g _a_0p2f0940004vjzs _a_0p2f0940001mt0y _a_0p2f0940002lcic
  G44 c: label:g44_c _id_1kt9tm5 _a_940008suso
  G44 result: label:g44_a _id_1iw4kr9 _a_94layi label:g44_b _id_o1mr6z _a_0p2f0940004vjzs _a_0p2f0940001mt0y _a_0p2f0940002lcic label:g44_c _id_1kt9tm5 _a_940008suso
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
  G49 a: label:g49_a _id_epc09d _a_0p2f0940008qcle _a_0p2f0940004ugg1 _a_0p2f0940001arec _a_0p2f09400022q28
  G49 b: label:g49_b _id_n2bfd5 _a_940008vkr1
  G49 result: label:g49 _id_ft4hgr _a_0p2f0940004ugg1 _a_0p2f0940001arec _a_0p2f09400022q28 _a_940008vkr1
  G50 a: label:g50_a _id_kel9e1 _a_940008awxs
  G50 b: label:g50_b _id_7nrwrz _a_0p2f0940008ybd4 _a_0p2f09400048jty _a_0p2f0940001v8e5 _a_0p2f0940002qysh
  G50 result: label:g50 _id_pvs05l _a_940008awxs _a_0p2f0940008ybd4 _a_0p2f09400048jty _a_0p2f0940001v8e5 _a_0p2f0940002qysh
  G51 a: label:g51_a _id_9hqx1q _a_0p2f09400085eff _a_0p2f0940004wfxm _a_0p2f0940001ne0b _a_0p2f0940002d0b2
  G51 b: label:g51_b _id_154dcwn _a_940008oudn
  G51 result: label:g51_a _id_9hqx1q _a_0p2f0940004wfxm _a_0p2f0940001ne0b _a_0p2f0940002d0b2 label:g51_b _id_154dcwn _a_940008oudn
  G51S a: label:g51s_a _id_1ip4w0k _a_0p2f094000813oi _a_0p2f094000421pq _a_0p2f0940001xdod _a_0p2f09400028s07
  G51S b: label:g51s_b _id_1hdhg2z _a_940008324g
  G51S result: label:g51s_a _id_1ip4w0k _a_0p2f094000421pq _a_0p2f0940001xdod _a_0p2f09400028s07 label:g51s_b _id_1hdhg2z _a_940008324g

The stylesheet, from the same post-PPX files the executable was built from, so
its classes are the ones printed above:

  $ styled-ppx.generate _build/default/*.re.pp.ml
  /* This file is generated by styled-ppx, do not edit manually */
  @property --g01_x-w1rss1{syntax:"*";inherits:false;}
  @property --g02_a_v1-1r7r0iu{syntax:"*";inherits:false;}
  @property --g02_a_v2-qruzaz{syntax:"*";inherits:false;}
  @property --g03_x-1vl3uw1{syntax:"*";inherits:false;}
  @property --g04_a_v1-3mfchy{syntax:"*";inherits:false;}
  @property --g04_a_v2-13246d8{syntax:"*";inherits:false;}
  @property --g04_a_v3-2oyh4u{syntax:"*";inherits:false;}
  @property --g04_a_v4-segwmv{syntax:"*";inherits:false;}
  @property --g06_b_v1-1mo9n5b{syntax:"*";inherits:false;}
  @property --g07_a_v1-1n6gf7y{syntax:"*";inherits:false;}
  @property --g08_a_v1-g0aivi{syntax:"*";inherits:false;}
  @property --g09_b_v1-1lh50ku{syntax:"*";inherits:false;}
  @property --g10_a_v1-azo504{syntax:"*";inherits:false;}
  @property --g11_a_v1-evlpt3{syntax:"*";inherits:false;}
  @property --g11_b_v1-15hdob5{syntax:"*";inherits:false;}
  ._a_94ep5r{padding:182px;}
  ._a_s19nz4epz1m .child{color:rgb(222, 0, 0);}
  ._a_s19nz4ev00p .child{color:rgb(242, 0, 0);}
  ._a_94wjd5{padding:511px;}
  ._a_9425e1{padding:531px;}
  ._a_94layi{padding:541px;}
  ._a_942oya{padding:553px;}
  ._a_94roh4{padding:563px;}
  ._a_94a4gd{padding:571px;}
  ._a_944pn0{padding:582px;}
  ._a_940008oudn{padding-top:612px;}
  ._a_940008324g{padding-top:622px;}
  ._a_9400082eeg{padding-top:112px;}
  ._a_940008tec9{padding-top:123px;}
  ._a_940008sz5p{padding-top:133px;}
  ._a_940008sqfx{padding-top:145px;}
  ._a_940008hwvz{padding-top:151px;}
  ._a_940008c1lf{padding-top:var(--g06_b_v1-1mo9n5b);}
  ._in_17owvxb{padding-top:var(--g07_a_v1-1n6gf7y);}
  ._a_940008eqd3{padding-top:172px;}
  ._a_940008sawn{padding-top:191px;}
  ._in_1adrker{padding-top:var(--g09_b_v1-1lh50ku);}
  ._in_85rpxf{padding-top:var(--g10_a_v1-azo504);}
  ._in_193brsh{padding-top:var(--g11_a_v1-evlpt3);}
  ._in_lovnlp{padding-top:var(--g11_b_v1-15hdob5);}
  ._a_940008wnds{padding-top:262px;}
  ._a_7p00021u47{margin-left:272px;}
  ._a_7p0002ikad{margin-left:282px;}
  ._a_7p00025ef7{margin-left:332px;}
  ._a_9400020dgx{padding-left:342px;}
  ._a_3n00041pt6{border-top-left-radius:362px;}
  ._a_940008l2i8{padding-top:372px;}
  ._a_8r00023rg8{overflow-y:auto;}
  ._a_6f0002wim3{row-gap:392px;}
  ._a_7100089sgg{top:402px;}
  ._a_940008mlcw{padding-top:412px;}
  ._a_7p0004l0kr{margin-right:424px;}
  ._a_940008etwy{padding-top:432px;}
  ._a_oe8sa940008kxgz{padding-top:452px !important;}
  ._a_9400085dyq{padding-top:462px;}
  ._a_65000wiyg8{font-size:29px;}
  ._a_390004ki2q{background-color:rgb(48, 0, 1);}
  ._a_600002eqnu{flex-grow:3;}
  ._a_oe8sa940008ndpl{padding-top:521px !important;}
  ._a_oe8sa9400048i88{padding-right:521px !important;}
  ._a_oe8sa940001ohze{padding-bottom:521px !important;}
  ._a_oe8sa940002c86j{padding-left:521px !important;}
  ._a_940008nyqa{padding-top:522px;}
  ._a_940008l9h9{padding-top:533px;}
  ._a_940008suso{padding-top:543px;}
  ._a_940008squy{padding-top:551px;}
  ._a_9400086kdf{padding-top:561px;}
  ._a_940008vkr1{padding-top:592px;}
  ._a_940008awxs{padding-top:601px;}
  ._a_3h0cn4bbg5{border-top-color:rgb(35, 2, 0);}
  ._a_3h1ekg8hxa{border-top-width:502px;}
  ._a_qyw7u4exirz:hover{color:rgb(232, 0, 0);}
  @media (max-width: 1200px) {._a_0p2f094tq86{padding:var(--g01_x-w1rss1);}}
  @media (max-width: 1200px) {._a_0p2f094hffm{padding:var(--g02_a_v1-1r7r0iu) var(--g02_a_v2-qruzaz);}}
  @media (max-width: 1200px) {._a_0p2f094jnqi{padding:131px var(--g03_x-1vl3uw1);}}
  @media (max-width: 1200px) {._a_0p2f094twy5{padding:var(--g05-p, 152px);}}
  @media (max-width: 1200px) {._a_0p2f094m3ut{padding:var(--g08_a_v1-g0aivi);}}
  @media (max-width: 1200px) {._a_cusig4exlm3 .child{color:rgb(221, 0, 0);}}
  @media (max-width: 1200px) {._a_cusig4ehjl1 .child{color:rgb(241, 0, 0);}}
  @media (max-width: 1200px) {._a_cusig4e2nat .child{color:rgb(251, 0, 0);}}
  @media (max-width: 1200px) {._a_cusig4eo88q .child{color:rgb(252, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f03hia4z{border:351px solid rgb(35, 1, 0);}}
  @media (max-width: 1200px) {._a_0p2f03n9uor{border-radius:361px;}}
  @media (max-width: 1200px) {._a_0p2f065hule{font:14px/47px serif;}}
  @media (max-width: 1200px) {._a_0p2f039srwd{background:rgb(48, 0, 0);}}
  @media (max-width: 1200px) {._a_0p2f060s8gu{-webkit-flex:1 1 491px;-ms-flex:1 1 491px;flex:1 1 491px;}}
  @media (max-width: 1200px) {._a_bfxpa4egtum:hover{color:rgb(231, 0, 0);}}
  ._a_qyw7u940008utii:hover{padding-top:441px;}
  ._a_qyw7u9400040mtx:hover{padding-right:441px;}
  ._a_qyw7u940001cn5g:hover{padding-bottom:441px;}
  ._a_qyw7u9400021pla:hover{padding-left:441px;}
  ._a_qyw7u940008frph:hover{padding-top:442px;}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l940008hrp6{padding-top:261px;}}}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l940004i6xk{padding-right:261px;}}}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l940001odg5{padding-bottom:261px;}}}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l940002nmo1{padding-left:261px;}}}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l7p0002mm7n{margin-left:291px;}}}
  @supports (display: grid) {@media (max-width: 1200px) {._a_0kk4l7p00020z0w{margin-left:292px;}}}
  @media (max-width: 1200px) {._a_0p2f09400085eff{padding-top:611px;}}
  @media (max-width: 1200px) {._a_0p2f0940004wfxm{padding-right:611px;}}
  @media (max-width: 1200px) {._a_0p2f0940001ne0b{padding-bottom:611px;}}
  @media (max-width: 1200px) {._a_0p2f0940002d0b2{padding-left:611px;}}
  @media (max-width: 1200px) {._a_0p2f094000813oi{padding-top:621px;}}
  @media (max-width: 1200px) {._a_0p2f094000421pq{padding-right:621px;}}
  @media (max-width: 1200px) {._a_0p2f0940001xdod{padding-bottom:621px;}}
  @media (max-width: 1200px) {._a_0p2f09400028s07{padding-left:621px;}}
  @media (max-width: 1200px) {._a_0p2f09400081k0h{padding-top:var(--g04_a_v1-3mfchy);}}
  @media (max-width: 1200px) {._a_0p2f0940004fat4{padding-right:var(--g04_a_v2-13246d8);}}
  @media (max-width: 1200px) {._a_0p2f0940001ogyz{padding-bottom:var(--g04_a_v3-2oyh4u);}}
  @media (max-width: 1200px) {._a_0p2f0940002bkph{padding-left:var(--g04_a_v4-segwmv);}}
  @media (max-width: 1200px) {._a_0p2f0940008j5ol{padding-top:161px;}}
  @media (max-width: 1200px) {._a_0p2f09400041ikb{padding-right:161px;}}
  @media (max-width: 1200px) {._a_0p2f0940001dcsw{padding-bottom:161px;}}
  @media (max-width: 1200px) {._a_0p2f0940002978u{padding-left:161px;}}
  @media (max-width: 1200px) {._in_17owvxb{padding-top:var(--g07_a_v1-1n6gf7y);}}
  @media (max-width: 1200px) {._in_1adrker{padding-top:var(--g09_b_v1-1lh50ku);}}
  @media (max-width: 1200px) {._in_85rpxf{padding-top:var(--g10_a_v1-azo504);}}
  @media (max-width: 1200px) {._a_0p2f0940008xv6u{padding-top:202px;}}
  @media (max-width: 1200px) {._in_193brsh{padding-top:var(--g11_a_v1-evlpt3);}}
  @media (max-width: 1200px) {._in_lovnlp{padding-top:var(--g11_b_v1-15hdob5);}}
  @media (max-width: 1200px) {@container app-main (max-width: 1000px) {._a_0bwi47p0002qdre{margin-left:271px;}}}
  @media (max-width: 1200px) {@container app-main (max-width: 1000px) {._a_0bwi47p00028h0m{margin-left:281px;}}}
  @media (max-width: 1200px) {._a_0p2f07p00023nxv{margin-left:301px;}}
  @media (max-width: 900px) {._a_0f0zo7p0002depv{margin-left:302px;}}
  @media (max-width: 1200px) {._a_0p2f094000872cq{padding-top:311px;}}
  @media (max-width: 1200px) {._a_0p2f0940004p19k{padding-right:311px;}}
  @media (max-width: 1200px) {._a_0p2f0940001k05e{padding-bottom:311px;}}
  @media (max-width: 1200px) {._a_0p2f09400026g7e{padding-left:311px;}}
  @media (max-width: 1200px) {._a_0p2f0940008sipt{padding-top:312px;}}
  @media (max-width: 900px) {._a_0f0zo940008ilx9{padding-top:321px;}}
  @media (max-width: 900px) {._a_0f0zo9400048kd9{padding-right:321px;}}
  @media (max-width: 900px) {._a_0f0zo9400018c0j{padding-bottom:321px;}}
  @media (max-width: 900px) {._a_0f0zo940002mt9e{padding-left:321px;}}
  @media (max-width: 1200px) {._a_0p2f09400085zfw{padding-top:322px;}}
  @media (max-width: 1200px) {._a_0p2f07p0008kkzn{margin-top:331px;}}
  @media (max-width: 1200px) {._a_0p2f07p0004vz3c{margin-right:auto;}}
  @media (max-width: 1200px) {._a_0p2f07p0001qqzw{margin-bottom:331px;}}
  @media (max-width: 1200px) {._a_0p2f07p000295e0{margin-left:auto;}}
  @media (max-width: 1200px) {._a_0p2f0960002fu16{-webkit-padding-start:341px;padding-inline-start:341px;}}
  @media (max-width: 1200px) {._a_0p2f09600016yxm{-webkit-padding-end:341px;padding-inline-end:341px;}}
  @media (max-width: 1200px) {._a_cht88940008h4y1{padding-top:371px !important;}}
  @media (max-width: 1200px) {._a_cht889400042kio{padding-right:371px !important;}}
  @media (max-width: 1200px) {._a_cht88940001q07u{padding-bottom:371px !important;}}
  @media (max-width: 1200px) {._a_cht88940002xcqh{padding-left:371px !important;}}
  @media (max-width: 1200px) {._a_0p2f08r0001p82m{overflow-x:hidden;}}
  @media (max-width: 1200px) {._a_0p2f08r00027qfj{overflow-y:hidden;}}
  @media (max-width: 1200px) {._a_0p2f06f0002de6v{row-gap:391px;}}
  @media (max-width: 1200px) {._a_0p2f06f0001j773{-webkit-column-gap:391px;column-gap:391px;}}
  @media (max-width: 1200px) {._a_0p2f071000869cv{top:401px;}}
  @media (max-width: 1200px) {._a_0p2f0710004nxlc{right:401px;}}
  @media (max-width: 1200px) {._a_0p2f0710001waae{bottom:401px;}}
  @media (max-width: 1200px) {._a_0p2f07100024hp9{left:401px;}}
  @media (max-width: 1200px) {._a_0p2f07p00080r2a{margin-top:421px;}}
  @media (max-width: 1200px) {._a_0p2f07p0004f8br{margin-right:422px;}}
  @media (max-width: 1200px) {._a_0p2f07p0001bnot{margin-bottom:423px;}}
  @media (max-width: 1200px) {._a_0p2f07p000252bz{margin-left:422px;}}
  @media (max-width: 1200px) {._a_0p2f09500023kx0{padding-block-start:431px;}}
  @media (max-width: 1200px) {._a_0p2f0950001ys6c{padding-block-end:431px;}}
  @media (max-width: 1200px) {._a_0p2f0940008eb57{padding-top:451px;}}
  @media (max-width: 1200px) {._a_0p2f0940004cajy{padding-right:451px;}}
  @media (max-width: 1200px) {._a_0p2f0940001bpli{padding-bottom:451px;}}
  @media (max-width: 1200px) {._a_0p2f0940002xtrs{padding-left:451px;}}
  @media (max-width: 1200px) {._a_0p2f0940008cake{padding-top:461px;}}
  @media (max-width: 1200px) {._a_0p2f0940004ukb6{padding-right:461px;}}
  @media (max-width: 1200px) {._a_0p2f0940001vd13{padding-bottom:461px;}}
  @media (max-width: 1200px) {._a_0p2f0940002j6gd{padding-left:461px;}}
  @media (max-width: 1200px) {._a_0p2f0940008trvt{padding-top:512px;}}
  @media (max-width: 1200px) {._a_0p2f0940008skge{padding-top:532px;}}
  @media (max-width: 1200px) {._a_0p2f0940004w6hr{padding-right:532px;}}
  @media (max-width: 1200px) {._a_0p2f094000130j7{padding-bottom:532px;}}
  @media (max-width: 1200px) {._a_0p2f09400022e78{padding-left:532px;}}
  @media (max-width: 1200px) {._a_0p2f09400080t2g{padding-top:542px;}}
  @media (max-width: 1200px) {._a_0p2f0940004vjzs{padding-right:542px;}}
  @media (max-width: 1200px) {._a_0p2f0940001mt0y{padding-bottom:542px;}}
  @media (max-width: 1200px) {._a_0p2f0940002lcic{padding-left:542px;}}
  @media (max-width: 1200px) {._a_0p2f0940008o9gy{padding-top:552px;}}
  @media (max-width: 1200px) {._a_0p2f0940008mwf2{padding-top:562px;}}
  @media (max-width: 1200px) {._a_0p2f09400082uxx{padding-top:572px;}}
  @media (max-width: 1200px) {._a_0p2f0940008bn02{padding-top:581px;}}
  @media (max-width: 1200px) {._a_0p2f0940008qcle{padding-top:591px;}}
  @media (max-width: 1200px) {._a_0p2f0940004ugg1{padding-right:591px;}}
  @media (max-width: 1200px) {._a_0p2f0940001arec{padding-bottom:591px;}}
  @media (max-width: 1200px) {._a_0p2f09400022q28{padding-left:591px;}}
  @media (max-width: 1200px) {._a_0p2f0940008ybd4{padding-top:602px;}}
  @media (max-width: 1200px) {._a_0p2f09400048jty{padding-right:602px;}}
  @media (max-width: 1200px) {._a_0p2f0940001v8e5{padding-bottom:602px;}}
  @media (max-width: 1200px) {._a_0p2f0940002qysh{padding-left:602px;}}
  @container app-main (max-width: 1000px) {._a_0crm3940008pn2p{padding-top:411px;}}
  @container app-main (max-width: 1000px) {._a_0crm3940004mjdw{padding-right:411px;}}
  @container app-main (max-width: 1000px) {._a_0crm39400015tw7{padding-bottom:411px;}}
  @container app-main (max-width: 1000px) {._a_0crm3940002o7um{padding-left:411px;}}
  @media (max-width: 1200px) {._a_0p2f03h1ekgdkvk{border-top-width:501px;}}
  @media (max-width: 1200px) {._a_0p2f03h06bkepi5{border-right-width:501px;}}
  @media (max-width: 1200px) {._a_0p2f03h0004g6ai{border-bottom-width:501px;}}
  @media (max-width: 1200px) {._a_0p2f03h00sg1sx4{border-left-width:501px;}}
