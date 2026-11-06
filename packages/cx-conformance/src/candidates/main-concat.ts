import type { Candidate, Case } from "../case.ts";
import type { Cover } from "../coverage.ts";
import { mergeOf, renderTree } from "../css.ts";
import { atomCss, atomize } from "./model.ts";

export function mainConcat(cover: Cover): Candidate {
  return {
    name: "main-concat",
    async render(c: Case, order: Record<string, string[]>) {
      const { atomsOf, atoms, bindingIds } = atomize(c, cover, { refs: "atom-chain", normalize: "none", bundles: false, siblingIds: false, vars: "baked" });
      const css = atoms.map(atomCss).join("\n");
      const html = renderTree(c.tree, (el) => {
        const names = mergeOf(el, order);
        const classes = names.flatMap((n) => [
          ...atomsOf.get(n)!.map((a) => a.cls),
          ...(c.blocks[n]!.trim() === "" ? [bindingIds.get(n)!] : []),
        ]);
        return [...new Set(classes)].join(" ");
      });
      return { css, html };
    },
  };
}
