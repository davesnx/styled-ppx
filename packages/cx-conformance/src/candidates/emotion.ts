import createEmotion from "@emotion/css/create-instance";
import type { Candidate, Case } from "../case.ts";
import { bindingRefs, mergeOf, renderTree, substitute } from "../css.ts";

export const emotion: Candidate = {
  name: "emotion",
  async render(c: Case, order: Record<string, string[]>) {
    const e = createEmotion({ key: "css" });
    const chunks: string[] = [];
    const seen = new Set<string>();
    const collect = () => {
      for (const [key, rules] of Object.entries(e.cache.inserted)) {
        if (seen.has(key)) continue;
        seen.add(key);
        if (typeof rules === "string") chunks.push(rules);
      }
    };
    const referenced = new Set(Object.values(c.blocks).flatMap(bindingRefs));
    const marker = (name: string) => `b-${name}`;
    const classes = new Map<string, string>();
    const classOf = (name: string, stack: string[]): string => {
      const known = classes.get(name);
      if (known) return known;
      if (stack.includes(name)) throw new Error(`${c.id}: cyclic .$(${name})`);
      const css = substitute(c, c.blocks[name]!, (other) => {
        classOf(other, [...stack, name]);
        return marker(other);
      });
      const cls = e.css(css);
      collect();
      classes.set(name, cls);
      return cls;
    };
    const html = renderTree(c.tree, (el) => {
      for (const name of el.merge) classOf(name, []);
      const merge = mergeOf(el, order);
      if (merge.length === 0) return "";
      const cls = e.cx(...merge.map((name) => classOf(name, [])));
      collect();
      const kept = merge.filter((name) => referenced.has(name)).map(marker);
      return [cls, ...new Set(kept)].join(" ");
    });
    for (const name of Object.keys(c.blocks)) classOf(name, []);
    return { css: chunks.join("\n"), html };
  },
};
