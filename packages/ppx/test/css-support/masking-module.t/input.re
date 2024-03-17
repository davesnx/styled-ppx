/* CSS Masking Module Level 1 */
[%css {|clip-path: url('#clip')|}];
[%css {|clip-path: inset(50%)|}];
/* [%css {|clip-path: circle()|}]; */
/* [%css {|clip-path: ellipse()|}]; */
/* [%css {|clip-path: polygon(0 10px, 30px 0)|}]; */
[%css {|clip-path: path('M 20 20 H 80 V 30')|}];
/* [%css {|clip-path: circle() border-box|}]; */
[%css {|clip-path: border-box|}];
[%css {|clip-path: padding-box|}];
[%css {|clip-path: content-box|}];
[%css {|clip-path: margin-box|}];
[%css {|clip-path: fill-box|}];
[%css {|clip-path: stroke-box|}];
[%css {|clip-path: view-box|}];
[%css {|clip-path: none|}];
[%css {|clip-rule: nonzero|}];
[%css {|clip-rule: evenodd|}];
[%css {|mask-image: none|}];
[%css {|mask-image: linear-gradient(45deg, blue, red)|}];
[%css {|mask-image: url(image.png)|}];
[%css {|mask-mode: alpha|}];
[%css {|mask-mode: luminance|}];
[%css {|mask-mode: match-source|}];
[%css {|mask-repeat: repeat-x|}];
[%css {|mask-repeat: repeat-y|}];
[%css {|mask-repeat: repeat|}];
[%css {|mask-repeat: space|}];
[%css {|mask-repeat: round|}];
[%css {|mask-repeat: no-repeat|}];
[%css {|mask-repeat: repeat repeat|}];
[%css {|mask-repeat: space repeat|}];
[%css {|mask-repeat: round repeat|}];
[%css {|mask-repeat: no-repeat repeat|}];
[%css {|mask-repeat: repeat space|}];
[%css {|mask-repeat: space space|}];
[%css {|mask-repeat: round space|}];
[%css {|mask-repeat: no-repeat space|}];
[%css {|mask-repeat: repeat round|}];
[%css {|mask-repeat: space round|}];
[%css {|mask-repeat: round round|}];
[%css {|mask-repeat: no-repeat round|}];
[%css {|mask-repeat: repeat no-repeat|}];
[%css {|mask-repeat: space no-repeat|}];
[%css {|mask-repeat: round no-repeat|}];
[%css {|mask-repeat: no-repeat no-repeat|}];
[%css {|mask-position: center|}];
[%css {|mask-position: center center|}];
[%css {|mask-position: left 50%|}];
[%css {|mask-position: bottom 10px right 20px|}];
/* TODO: mask-position is incomplete in Parser.re */
/* [%css {|mask-position: bottom 10px right|}]; */
/* [%css {|mask-position: top right 10px|}]; */
[%css {|mask-clip: border-box|}];
[%css {|mask-clip: padding-box|}];
[%css {|mask-clip: content-box|}];
[%css {|mask-clip: margin-box|}];
[%css {|mask-clip: fill-box|}];
[%css {|mask-clip: stroke-box|}];
[%css {|mask-clip: view-box|}];
[%css {|mask-clip: no-clip|}];
[%css {|mask-origin: border-box|}];
[%css {|mask-origin: padding-box|}];
[%css {|mask-origin: content-box|}];
[%css {|mask-origin: margin-box|}];
[%css {|mask-origin: fill-box|}];
[%css {|mask-origin: stroke-box|}];
[%css {|mask-origin: view-box|}];
[%css {|mask-size: auto|}];
[%css {|mask-size: 10px|}];
[%css {|mask-size: cover|}];
[%css {|mask-size: contain|}];
[%css {|mask-size: 10px|}];
[%css {|mask-size: 50%|}];
[%css {|mask-size: 10px auto|}];
[%css {|mask-size: auto 10%|}];
[%css {|mask-size: 50em 50%|}];
[%css {|mask-composite: add|}];
[%css {|mask-composite: subtract|}];
[%css {|mask-composite: intersect|}];
[%css {|mask-composite: exclude|}];
[%css {|mask: top|}];
[%css {|mask: space|}];
[%css {|mask: url(image.png)|}];
[%css {|mask: url(image.png) luminance|}];
[%css {|mask: url(image.png) luminance top space|}];
[%css {|mask-border-source: none|}];
[%css {|mask-border-source: url(image.png)|}];
[%css {|mask-border-slice: 0 fill|}];
[%css {|mask-border-slice: 50% fill|}];
[%css {|mask-border-slice: 1.1 fill|}];
[%css {|mask-border-slice: 0 1 fill|}];
[%css {|mask-border-slice: 0 1 2 fill|}];
[%css {|mask-border-slice: 0 1 2 3 fill|}];
[%css {|mask-border-width: auto|}];
[%css {|mask-border-width: 10px|}];
[%css {|mask-border-width: 50%|}];
[%css {|mask-border-width: 1|}];
[%css {|mask-border-width: 1.0|}];
[%css {|mask-border-width: auto 1|}];
[%css {|mask-border-width: auto 1 50%|}];
[%css {|mask-border-width: auto 1 50% 1.1|}];
[%css {|mask-border-outset: 0|}];
[%css {|mask-border-outset: 1.1|}];
[%css {|mask-border-outset: 0 1|}];
[%css {|mask-border-outset: 0 1 2|}];
[%css {|mask-border-outset: 0 1 2 3|}];
[%css {|mask-border-repeat: stretch|}];
[%css {|mask-border-repeat: repeat|}];
[%css {|mask-border-repeat: round|}];
[%css {|mask-border-repeat: space|}];
[%css {|mask-border-repeat: stretch stretch|}];
[%css {|mask-border-repeat: repeat stretch|}];
[%css {|mask-border-repeat: round stretch|}];
[%css {|mask-border-repeat: space stretch|}];
[%css {|mask-border-repeat: stretch repeat|}];
[%css {|mask-border-repeat: repeat repeat|}];
[%css {|mask-border-repeat: round repeat|}];
[%css {|mask-border-repeat: space repeat|}];
[%css {|mask-border-repeat: stretch round|}];
[%css {|mask-border-repeat: repeat round|}];
[%css {|mask-border-repeat: round round|}];
[%css {|mask-border-repeat: space round|}];
[%css {|mask-border-repeat: stretch space|}];
[%css {|mask-border-repeat: repeat space|}];
[%css {|mask-border-repeat: round space|}];
[%css {|mask-border-repeat: space space|}];
[%css {|mask-border: url(image.png)|}];
/* TODO: Parser.re is incomplete */
/* [%css {|mask-border: url(image.png) 10px|}]; */
/* [%css {|mask-border: url(image.png) space|}]; */
/* [%css {|mask-border: url(image.png) 1 fill|}]; */
/* [%css {|mask-border: url(image.png) 1 fill 10px|}]; */
/* [%css {|mask-border: url(image.png) 1 fill 10px|}]; */
/* [%css {|mask-border: url(image.png) 1 fill 10px 2|}]; */
[%css {|mask-type: luminance|}];
[%css {|mask-type: alpha|}];