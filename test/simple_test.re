open Test_framework;
open Re_styled_ppx;

/* module Component = {
     [@react.component]
     let make = (~children) => {
       <div />;
     };
   };
    */

describe("Test", ({test, describe, _}) => {
  test("Should be able to transform a easy one", ({expect}) =>
    {
      /*     let StyledComponent = [%re_styled_ppx.div
               {|
                 display: block;
                 color: red;
               |}
             ];

             expect.equal(Component, StyledComponent); */
    }
  )
});
