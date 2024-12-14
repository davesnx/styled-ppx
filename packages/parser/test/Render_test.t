  $ alias run='./Render_test.exe'

  $ cat <<"EOF" | run
  > ol li {border: 1px dotted gray; background: rgba(255,255,0,0.1);}
  > li:nth-child(1) {width: calc(7em + 6em);}
  > li:nth-child(2) {width: calc(7em+6em);}
  > li:nth-child(3) {width: calc(7em + (1em * 6));}
  > li:nth-child(4) {width: calc(7em + 96px);}
  > li:nth-child(5) {width: calc(7em + 6);}
  > li:nth-child(6) {width: calc(7em + 5s);}
  > li:nth-child(7) {width: calc(7em + calc(4em + 2em));}
  > li:nth-child(8) {width: calc(7em + (4em + 2em));}
  > li:nth-child(9) {width: calc(6.5em * 2);}
  > li:nth-child(10) {width: calc(6.5em*2);}
  > li:nth-child(11) {width: calc(6.5 * 2em);}
  > li:nth-child(12) {width: calc(6.5em * 2em);}
  > li:nth-child(13) {width: calc(6.5em * 0);}
  > li:nth-child(14) {width: calc(26em / 2);}
  > li:nth-child(15) {width: calc(26em/2);}
  > li:nth-child(16) {width: calc(26 / 2em);}
  > li:nth-child(17) {width: calc(26em / 2em);}
  > li:nth-child(18) {width: calc(13em / 0);}
  > EOF