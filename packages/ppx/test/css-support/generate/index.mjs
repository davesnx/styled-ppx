import { promises as fs } from "fs";
import data from "./data.js";

let wrap = (v) => (Array.isArray(v) ? v : [v]);

let template = ({ name, tests }) => {
  if (!tests) return "";
  const cxTests = tests.map((t) => `[%cx {|${t}|}];`).join("\n");
  return "\n" + "/*" + name + "*/" + "\n" + cxTests;
};

let main = async () => {
  const features = Object.values(data);

  const res = features.map((feature) => {
    if (feature.values) {
      const properties = feature.values.properties;
      const propList = properties && Object.values(properties);
      delete feature.values.properties;

      const tests = propList
        .map((prop) => {
          return Object.values(feature.values)
            .map((value) => {
              return wrap(value.tests).map((t) => `${prop}: ${t};`);
            })
            .flat();
        })
        .flat();

      return {
        name: feature.title,
        tests,
      };
    }

    return {
      name: feature.title,
      tests:
        feature.properties &&
        Object.entries(feature.properties).flatMap(([name, { tests }]) => {
          if (tests == undefined) return "";
          return wrap(tests).map((t) => name + ": " + t);
        }),
    };
  });

  const filteredEmptyTests = res.filter((r) => r.tests);
  let content = filteredEmptyTests.map(template).join("\n");
  await fs.writeFile("./test.re", content);
};

main();
