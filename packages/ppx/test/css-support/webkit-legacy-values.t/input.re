/* Non-standard legacy webkit values.
   Regression test: the registry keys for these value types are dash-prefixed
   (-webkit-gradient-type, -webkit-mask-box-repeat). The specs referencing them
   used to omit the dash, crashing the compiler with
   "Rule not found in registry: webkit-gradient-type". */

/* <-webkit-gradient-type>: 'linear' | 'radial' */
[%css
  {|background: -webkit-gradient(linear, left top, left bottom, from(red), to(blue))|}
];
[%css
  {|background: -webkit-gradient(radial, center center, 0px, center center, 100px, from(blue), to(red))|}
];

/* <-webkit-mask-box-repeat>: 'repeat' | 'stretch' | 'round' */
[%css {|-webkit-mask-box-image: url(mask.png) 10px 10px 10px 10px stretch stretch|}];
[%css {|-webkit-mask-box-image: url(mask.png) 5% 5% 5% 5% round repeat|}];
