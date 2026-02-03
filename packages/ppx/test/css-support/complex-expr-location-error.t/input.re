type size =
  | Big
  | Small;

let prop = Big;

let _styles = [%cx
  {|
    color: $(switch (prop) {
      | Big => `re
      | Small => CSS.blue
    });
  |}
];
