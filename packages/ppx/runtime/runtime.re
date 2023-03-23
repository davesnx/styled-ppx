let getOrEmpty = str => {
  switch (str) {
  | Some(str) => " " ++ str
  | None => ""
  };
};

/* let deleteProp = [%raw "(newProps, key) => delete newProps[key]"]; */
/* external assign2: (Js.t({..}), Js.t({..}), Js.t({..})) => Js.t({..}) =
   "Object.assign"; */
/* let deleteProp = [%raw "(newProps, key) => delete newProps[key]"] */
/* [@bs.val] [@bs.module "react"] external createVariadicElement:
   (string, Js.t({ .. })) => React.element =
   "createElement"; */
