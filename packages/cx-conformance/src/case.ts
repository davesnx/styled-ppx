export type Viewport = { width: number; height: number };

export type PseudoState =
  | "hover"
  | "focus"
  | "focus-visible"
  | "focus-within"
  | "active"
  | "visited";

export type El = {
  id: string;
  tag?: string;
  dir?: "ltr" | "rtl";
  merge: string[];
  children?: El[];
};

export type Probe = {
  el: string;
  props?: string[];
  viewport?: Viewport;
  state?: PseudoState[];
};

export type Expect =
  | { kind: "pass" }
  | { kind: "known-fail"; reason: string; issue?: string };

export type Case = {
  id: string;
  title: string;
  why: string;
  source?: string;
  blocks: Record<string, string>;
  vars?: Record<string, { css: string; reason: string }>;
  tree: El[];
  probes: Probe[];
  orders?: "as-written" | "all-permutations";
  expect?: Expect;
};

export type Rendered = { css: string; html: string };

export type Candidate = {
  name: string;
  render(c: Case, order: Record<string, string[]>): Promise<Rendered>;
};
