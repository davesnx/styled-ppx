type size =
  | Big
  | Small;

let prop = Big;
let _unused = Small;

let _styles = [%cx
  {|
    color: $(switch (prop) {
      | Big => CSS.red
      | Small => CSS.blue
    });
  |}
];
