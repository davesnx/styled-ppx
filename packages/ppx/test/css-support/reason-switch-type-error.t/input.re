type size =
  | Big
  | Small;

let prop = Big;

let _styles = [%css
  {|
    color: $(switch (prop) {
      | Big => `re
      | Small => CSS.blue
    });
  |}
];
