/*
  let rec rule_to_dict =
    (. dict, rule) => {
      switch (rule) {
      | Declaration(name, value) when name == "content" =>
        dict->Js.Dict.set(name, Js.Json.string(value == "" ? "\"\"" : value))
      | Declaration(name, value) =>
        dict->Js.Dict.set(name, Js.Json.string(value))
      | Selector(name, ruleset) => dict->Js.Dict.set(name, to_object(ruleset))
      | PseudoClass(name, ruleset) =>
        dict->Js.Dict.set(":" ++ name, to_object(ruleset))
      | PseudoClassParam(name, param, ruleset) =>
        dict->Js.Dict.set(
          ":" ++ name ++ "(" ++ param ++ ")",
          to_object(ruleset),
        )
      };
      dict;
    }
  and to_object = rules =>
    rules->Belt.Array.reduceU(Js.Dict.empty(), rule_to_dict)->Js.Json.object_;

  type animationName = string;

  module type MakeResult = {
    type styleEncoding;
    type renderer;

    let insertRule: (. string) => unit;
    let renderRule: (. renderer, string) => unit;

    let global: (. string, array(Rule.t)) => unit;
    let renderGlobal: (. renderer, string, array(Rule.t)) => unit;

    let style: (. array(Rule.t)) => styleEncoding;

    let merge: (. array(styleEncoding)) => styleEncoding;
    let merge2: (. styleEncoding, styleEncoding) => styleEncoding;
    let merge3: (. styleEncoding, styleEncoding, styleEncoding) => styleEncoding;
    let merge4:
      (. styleEncoding, styleEncoding, styleEncoding, styleEncoding) =>
      styleEncoding;

    let keyframes: (. array((int, array(Rule.t)))) => animationName;
    let renderKeyframes:
      (. renderer, array((int, array(Rule.t)))) => animationName;
  };

  module type Interface = {
    type styleEncoding;
    type renderer; // some implementations might need a renderer

    let injectRaw: (. string /* css */) => unit;
    let renderRaw: (. renderer, string /* css */) => unit;

    let injectRules: (. string /* selector */, Js.Json.t) => unit;
    let renderRules: (. renderer, string /* selector */, Js.Json.t) => unit;

    let make: (. Js.Json.t) => styleEncoding;
    let mergeStyles: (. array(styleEncoding)) => styleEncoding;

    let makeKeyframes: (. Js.Dict.t(Js.Json.t)) => string; /* animationName */
    let renderKeyframes: (. renderer, Js.Dict.t(Js.Json.t)) => string; /* animationName */
  };

  module Make =
         (Implementation: Interface)

           : (
             MakeResult with
               type styleEncoding := Implementation.styleEncoding and
               type renderer := Implementation.renderer
         ) => {
    type styleEncoding;
    type renderer;

    let insertRule = (. css) => Implementation.injectRaw(. css);
    let renderRule =
      (. renderer, css) => Implementation.renderRaw(. renderer, css);

    let global =
      (. selector, rules) =>
        Implementation.injectRules(. selector, to_object(rules));

    let renderGlobal =
      (. renderer, selector, rules) =>
        Implementation.renderRules(. renderer, selector, to_object(rules));

    let style = (. rules) => Implementation.make(. to_object(rules));

    let merge = (. styles) => Implementation.mergeStyles(. styles);
    let merge2 = (. s, s2) => merge(. [s, s2]);
    let merge3 = (. s, s2, s3) => merge(. [s, s2, s3]);
    let merge4 = (. s, s2, s3, s4) => merge(. [s, s2, s3, s4]);

    let framesToDict = frames =>
      frames->Belt.Array.reduceU(
        Js.Dict.empty(),
        (. dict, (stop, rules)) => {
          Js.Dict.set(dict, Js.Int.toString(stop) ++ "%", to_object(rules));
          dict;
        },
      );

    let keyframes =
      (. frames) => Implementation.makeKeyframes(. framesToDict(frames));

    let renderKeyframes =
      (. renderer, frames) =>
        Implementation.renderKeyframes(. renderer, framesToDict(frames));
  };

 */
