

import * as React from "react";

function Index$P(Props) {
  var children = Props.children;
  return React.createElement("p", {
              className: "mb-2"
            }, children);
}

var P = {
  make: Index$P
};

function Index(Props) {
  return React.createElement("div", undefined, React.createElement("h1", {
                  className: "text-3xl font-semibold"
                }, "What is this about?"), React.createElement(Index$P, {
                  children: " This is a simple template for a Next\n      project using Reason & TailwindCSS."
                }), React.createElement("h2", {
                  className: "text-2xl font-semibold mt-5"
                }, "Quick Start"), React.createElement(Index$P, {
                  children: React.createElement("pre", undefined, "git clone https://github.com/ryyppy/nextjs-default.git my-project\ncd my-project\nrm -rf .git")
                }));
}

var make = Index;

var $$default = Index;

export {
  P ,
  make ,
  $$default ,
  $$default as default,
  
}
/* react Not a pure module */
