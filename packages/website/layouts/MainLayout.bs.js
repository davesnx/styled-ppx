

import * as React from "react";
import * as Link from "next/link";

function MainLayout$Navigation(Props) {
  return React.createElement("nav", {
              className: "p-2 h-12 flex border-b border-gray-200 justify-between items-center text-sm"
            }, React.createElement(Link.default, {
                  href: "/",
                  children: React.createElement("a", {
                        className: "flex items-center w-1/3"
                      }, React.createElement("img", {
                            className: "w-5",
                            src: "/static/zeit-black-triangle.svg"
                          }), React.createElement("span", {
                            className: "text-xl ml-2 align-middle font-semibold"
                          }, "Next", React.createElement("span", {
                                className: "text-orange-800"
                              }, "RE")))
                }), React.createElement("div", {
                  className: "flex w-2/3 justify-end"
                }, React.createElement(Link.default, {
                      href: "/",
                      children: React.createElement("a", {
                            className: "px-3"
                          }, "Home")
                    }), React.createElement(Link.default, {
                      href: "/examples",
                      children: React.createElement("a", {
                            className: "px-3"
                          }, "Examples")
                    }), React.createElement("a", {
                      className: "px-3 font-bold",
                      href: "https://github.com/ryyppy/nextjs-default",
                      target: "_blank"
                    }, "Github")));
}

var Navigation = {
  make: MainLayout$Navigation
};

function MainLayout(Props) {
  var children = Props.children;
  var minWidth = {
    minWidth: "20rem"
  };
  return React.createElement("div", {
              className: "flex lg:justify-center",
              style: minWidth
            }, React.createElement("div", {
                  className: "max-w-5xl w-full lg:w-3/4 text-gray-900 font-base"
                }, React.createElement(MainLayout$Navigation, { }), React.createElement("main", {
                      className: "mt-4 mx-4"
                    }, children)));
}

var Link$1 = /* alias */0;

var make = MainLayout;

export {
  Link$1 as Link,
  Navigation ,
  make ,
  
}
/* react Not a pure module */
