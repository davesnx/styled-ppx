[%css {|display: grid|}];
[%css {|display: inline-grid|}];
[%css {|grid-template-columns: none|}];
[%css {|grid-template-columns: auto|}];
[%css {|grid-template-columns: 100px|}];
[%css {|grid-template-columns: 1fr|}];
[%css {|grid-template-columns: 100px 1fr auto|}];
[%css {|grid-template-columns: repeat(2, 100px)|}];
[%css
  {|grid-template-columns: repeat(4, 10px [col-start] 250px [col-end]) 10px|}
];
[%css
  {|grid-template-columns: 100px 1fr max-content minmax(min-content, 1fr)|}
];
[%css {|grid-template-columns: repeat(auto-fill, minmax(25ch, 1fr))|}];
[%css {|grid-template-columns: 10px [col-start] 250px [col-end]|}];
[%css
  {|grid-template-columns: [first nav-start] 150px [main-start] 1fr [last]|}
];
[%css
  {|grid-template-columns: 10px [col-start] 250px [col-end] 10px [col-start] 250px [col-end] 10px|}
];
[%css
  {|grid-template-columns: [a] auto [b] minmax(min-content, 1fr) [b c d] repeat(2, [e] 40px) repeat(5, auto)|}
];
[%css {|grid-template-columns: 200px repeat(auto-fill, 100px) 300px; |}];
[%css
  {|grid-template-columns: minmax(100px, max-content) repeat(auto-fill, 200px) 20%; |}
];
[%css
  {|grid-template-columns: [linename1] 100px [linename2] repeat(auto-fit, [linename3 linename4] 300px) 100px; |}
];
