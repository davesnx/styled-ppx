import type { Browser, CDPSession, Page } from "playwright-core";
import type { Case, PseudoState, Rendered, Viewport } from "./case.ts";
import type { Cover } from "./coverage.ts";
import { declaredProps } from "./css.ts";

export const defaultViewport: Viewport = { width: 1024, height: 768 };

export type ResolvedProbe = {
  el: string;
  viewport: Viewport;
  state: PseudoState[];
  props: string[];
  pseudos: string[];
};

export type Reading = Record<string, string>[];

export function caseProps(c: Case, cover: Cover): string[] {
  return [...new Set(declaredProps(c).flatMap(cover))].sort();
}

export function resolveProbes(c: Case, cover: Cover): ResolvedProbe[] {
  const all = caseProps(c, cover);
  const text = Object.values(c.blocks).join("\n");
  const pseudos = ["::before", "::after"].filter((p) => text.includes(p));
  return c.probes.map((p) => ({
    el: p.el,
    viewport: p.viewport ?? defaultViewport,
    state: p.state ?? [],
    props: p.props ?? all,
    pseudos,
  }));
}

export function describeProbe(p: ResolvedProbe): string {
  const state = p.state.length > 0 ? ":" + p.state.join(":") : "";
  return `#${p.el}${state} @${p.viewport.width}x${p.viewport.height}`;
}

type Slot = { page: Page; cdp: CDPSession; viewport: string };

function readInPage(probes: { el: string; props: string[]; pseudos: string[] }[]): Record<string, string>[] {
  void getComputedStyle(document.documentElement).color;
  for (const a of document.getAnimations()) a.finish();
  return probes.map((p) => {
    const el = document.getElementById(p.el);
    if (!el) throw new Error(`no element #${p.el}`);
    const out: Record<string, string> = {};
    const cs = getComputedStyle(el);
    for (const prop of p.props) out[prop] = cs.getPropertyValue(prop);
    for (const pseudo of p.pseudos) {
      const ps = getComputedStyle(el, pseudo);
      for (const prop of p.props) out[`${pseudo} ${prop}`] = ps.getPropertyValue(prop);
    }
    return out;
  });
}

export class Prober {
  private idle: Slot[] = [];
  private waiting: ((s: Slot) => void)[] = [];

  static async open(browser: Browser, concurrency: number): Promise<Prober> {
    const prober = new Prober();
    const context = await browser.newContext({ viewport: defaultViewport });
    for (let i = 0; i < concurrency; i++) {
      const page = await context.newPage();
      const cdp = await context.newCDPSession(page);
      await cdp.send("DOM.enable");
      await cdp.send("CSS.enable");
      prober.idle.push({ page, cdp, viewport: `${defaultViewport.width}x${defaultViewport.height}` });
    }
    return prober;
  }

  private acquire(): Promise<Slot> {
    const slot = this.idle.pop();
    if (slot) return Promise.resolve(slot);
    return new Promise((resolve) => this.waiting.push(resolve));
  }

  private release(slot: Slot): void {
    const next = this.waiting.shift();
    if (next) next(slot);
    else this.idle.push(slot);
  }

  async read(rendered: Rendered, probes: ResolvedProbe[]): Promise<Reading> {
    const slot = await this.acquire();
    try {
      return await this.readOn(slot, rendered, probes);
    } finally {
      this.release(slot);
    }
  }

  private async readOn(slot: Slot, rendered: Rendered, probes: ResolvedProbe[]): Promise<Reading> {
    const { page, cdp } = slot;
    await page.setContent(
      `<!doctype html><html><head><meta charset="utf-8"><style>${rendered.css}</style></head><body>${rendered.html}</body></html>`,
    );
    const out: Reading = new Array(probes.length);
    let root: number | undefined;
    const nodeId = async (id: string): Promise<number> => {
      root ??= (await cdp.send("DOM.getDocument", { depth: 0 })).root.nodeId;
      const { nodeId } = await cdp.send("DOM.querySelector", { nodeId: root, selector: `[id="${id}"]` });
      if (!nodeId) throw new Error(`no element #${id}`);
      return nodeId;
    };
    const groups = new Map<string, number[]>();
    probes.forEach((p, i) => {
      const key = `${p.viewport.width}x${p.viewport.height}`;
      groups.set(key, [...(groups.get(key) ?? []), i]);
    });
    for (const [key, indices] of groups) {
      if (slot.viewport !== key) {
        await page.setViewportSize(probes[indices[0]!]!.viewport);
        slot.viewport = key;
      }
      const plain = indices.filter((i) => probes[i]!.state.length === 0);
      if (plain.length > 0) {
        const values = await page.evaluate(readInPage, plain.map((i) => probes[i]!));
        plain.forEach((i, k) => (out[i] = values[k]!));
      }
      for (const i of indices.filter((i) => probes[i]!.state.length > 0)) {
        const p = probes[i]!;
        const id = await nodeId(p.el);
        await cdp.send("CSS.forcePseudoState", { nodeId: id, forcedPseudoClasses: p.state });
        out[i] = (await page.evaluate(readInPage, [p]))[0]!;
        await cdp.send("CSS.forcePseudoState", { nodeId: id, forcedPseudoClasses: [] });
      }
    }
    return out;
  }
}

export type Diff = { index: number; probe: string; prop: string; oracle: string; candidate: string };

export function compare(probes: ResolvedProbe[], oracle: Reading, candidate: Reading): Diff[] {
  const diffs: Diff[] = [];
  probes.forEach((p, i) => {
    const o = oracle[i]!, c = candidate[i]!;
    for (const prop of Object.keys(o)) {
      if (o[prop] !== c[prop]) {
        diffs.push({ index: i, probe: describeProbe(p), prop, oracle: o[prop]!, candidate: c[prop] ?? "<missing>" });
      }
    }
  });
  return diffs;
}
