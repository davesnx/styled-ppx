/* Regression coverage for dash-prefixed legacy WebKit registry keys. */

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
