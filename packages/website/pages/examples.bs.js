

import * as React from "react";

function $$default(props) {
  return React.createElement("div", undefined, props.msg, React.createElement("a", {
                  href: props.href,
                  target: "_blank"
                }, "`pages/examples.re`"));
}

function getServerSideProps(_ctx) {
  return Promise.resolve({
              props: {
                msg: "This page was rendered with getServerSideProps. You can find the source code here: ",
                href: "https://github.com/ryyppy/nextjs-default/tree/master/pages/examples.re"
              }
            });
}

export {
  $$default ,
  $$default as default,
  getServerSideProps ,
  
}
/* react Not a pure module */
