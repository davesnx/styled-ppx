#!/usr/bin/env node

import { readFileSync } from "node:fs";
import { deepStrictEqual } from "node:assert/strict";

type Spec = readonly [number, number, number]; // [ids, classes/attrs/pseudo-classes, elements/pseudo-elements]

interface Rule {
  wrapper: string; // at-rule prelude text (e.g. "@media (max-width: 992px)"), or ''
  selector: string;
  specificity: Spec;
  property: string;
  value: string;
  line: number;
}

interface FlipRow {
  property: string;
  specificity: Spec;
  wrapper: string;
  a: { selector: string; value: string };
  b: { selector: string; value: string };
  oldWinner: string;
  newWinner: string;
}

function splitTopLevel(s: string, sep: string): string[] {
  const parts: string[] = [];
  let depth = 0;
  let start = 0;
  for (let i = 0; i < s.length; i++) {
    const c = s[i];
    if (c === "(") depth++;
    else if (c === ")") depth = Math.max(0, depth - 1);
    else if (c === sep && depth === 0) {
      parts.push(s.slice(start, i));
      start = i + 1;
    }
  }
  parts.push(s.slice(start));
  return parts;
}

function findMatchingParen(s: string, openIdx: number): number {
  let depth = 0;
  for (let i = openIdx; i < s.length; i++) {
    if (s[i] === "(") depth++;
    else if (s[i] === ")") {
      depth--;
      if (depth === 0) return i;
    }
  }
  return s.length - 1; // malformed input: treat rest of string as the arg
}

function specCompare(x: Spec, y: Spec): number {
  return x[0] - y[0] || x[1] - y[1] || x[2] - y[2];
}

const ID_TOKEN = /^#[-\w\\]+/;
const CLASS_TOKEN = /^\.[-\w\\]+/;
const PSEUDO_TOKEN = /^:{1,2}([A-Za-z-]+)/;
const ELEMENT_TOKEN = /^[A-Za-z][A-Za-z0-9-]*/;
const LEGACY_PSEUDO_ELEMENTS = new Set(["before", "after", "first-line", "first-letter"]);

// Standard CSS specificity: :where() contributes 0; :is()/:not()/:has() take
// their most specific argument; universal selector and combinators are 0.
function calcSpecificity(selector: string): Spec {
  let a = 0, b = 0, c = 0;
  let i = 0;
  const n = selector.length;
  while (i < n) {
    const ch = selector[i];
    if (ch === " " || ch === "\t" || ch === ">" || ch === "+" || ch === "~") {
      i++;
      continue;
    }
    if (ch === "#") {
      const m = ID_TOKEN.exec(selector.slice(i));
      a++;
      i += m ? m[0].length : 1;
      continue;
    }
    if (ch === ".") {
      const m = CLASS_TOKEN.exec(selector.slice(i));
      b++;
      i += m ? m[0].length : 1;
      continue;
    }
    if (ch === "[") {
      const close = selector.indexOf("]", i);
      b++;
      i = close === -1 ? n : close + 1;
      continue;
    }
    if (ch === "*") {
      i++;
      continue;
    }
    if (ch === ":") {
      const nameMatch = PSEUDO_TOKEN.exec(selector.slice(i));
      const name = nameMatch ? nameMatch[1].toLowerCase() : "";
      // :before/:after/:first-line/:first-letter are pseudo-elements even with
      // a single colon (CSS2 legacy syntax); every other pseudo-element needs ::.
      const isPseudoElement = selector[i + 1] === ":" || LEGACY_PSEUDO_ELEMENTS.has(name);
      let consumed = nameMatch ? nameMatch[0].length : 1;
      const argStart = i + consumed;
      const hasParen = selector[argStart] === "(";
      let argEnd = -1;
      if (hasParen) {
        argEnd = findMatchingParen(selector, argStart);
        consumed = argEnd - i + 1;
      }
      if (isPseudoElement) {
        c++;
      } else if (name === "where") {
        // contributes 0; skip its argument entirely
      } else if ((name === "is" || name === "not" || name === "has" || name === "matches") && hasParen) {
        const inner = selector.slice(argStart + 1, argEnd);
        const args = splitTopLevel(inner, ",").map((x) => x.trim()).filter(Boolean);
        let best: Spec = [0, 0, 0];
        for (const arg of args) {
          const s = calcSpecificity(arg);
          if (specCompare(s, best) > 0) best = s;
        }
        a += best[0];
        b += best[1];
        c += best[2];
      } else {
        b++; // ordinary pseudo-class, incl. functional ones like :nth-child(2n+1)
      }
      i += consumed;
      continue;
    }
    const m = ELEMENT_TOKEN.exec(selector.slice(i));
    if (m) {
      c++;
      i += m[0].length;
      continue;
    }
    i++;
  }
  return [a, b, c];
}

const AT_RULE_NAME = /^@([A-Za-z-]+)/;
// Conditional/grouping at-rules wrap other rules and matter for cascade order.
// @layer is a wrapper only in its block form (`@layer name {...}`); its
// statement form (`@layer a, b;`) just declares layer order, like @import.
// Everything else (@font-face, @page, @import, @keyframes, @property, ...)
// has no selector to compete for cascade priority, so it's skipped by design.
const WRAPPER_AT_RULES = new Set(["media", "supports", "container", "scope"]);

function parseLine(rawLine: string, lineNo: number): { rules: Rule[]; skippedByDesign: boolean; unparsed: boolean } {
  const trimmed = rawLine.trim();
  if (!trimmed || trimmed.startsWith("/*")) return { rules: [], skippedByDesign: false, unparsed: false };

  let wrapper = "";
  let ruleText = trimmed;

  if (ruleText.startsWith("@")) {
    const atMatch = AT_RULE_NAME.exec(ruleText);
    const atName = atMatch ? atMatch[1].toLowerCase() : "";
    const braceIdx = ruleText.indexOf("{");
    const isWrapper = WRAPPER_AT_RULES.has(atName) || (atName === "layer" && braceIdx !== -1);
    if (!isWrapper) {
      return { rules: [], skippedByDesign: true, unparsed: false };
    }
    if (braceIdx === -1 || !ruleText.endsWith("}")) return { rules: [], skippedByDesign: false, unparsed: true };
    wrapper = ruleText.slice(0, braceIdx).trim();
    ruleText = ruleText.slice(braceIdx + 1, ruleText.length - 1).trim();
  }

  const selBraceIdx = ruleText.indexOf("{");
  if (selBraceIdx === -1 || !ruleText.endsWith("}")) return { rules: [], skippedByDesign: false, unparsed: true };

  const selectorsRaw = ruleText.slice(0, selBraceIdx).trim();
  const bodyRaw = ruleText.slice(selBraceIdx + 1, ruleText.length - 1);
  const selectors = splitTopLevel(selectorsRaw, ",").map((s) => s.trim()).filter(Boolean);
  const decls = splitTopLevel(bodyRaw, ";").map((s) => s.trim()).filter(Boolean);
  if (selectors.length === 0) return { rules: [], skippedByDesign: false, unparsed: true };

  const rules: Rule[] = [];
  for (const selector of selectors) {
    const specificity = calcSpecificity(selector);
    for (const decl of decls) {
      const colonIdx = decl.indexOf(":");
      if (colonIdx === -1) continue;
      const property = decl.slice(0, colonIdx).trim();
      const value = decl.slice(colonIdx + 1).trim();
      rules.push({ wrapper, selector, specificity, property, value, line: lineNo });
    }
  }
  return { rules, skippedByDesign: false, unparsed: false };
}

function parseStylesheet(text: string): { rules: Rule[]; parsedLines: number; unparsedLines: number[] } {
  const lines = text.split(/\r?\n/);
  const rules: Rule[] = [];
  let parsedLines = 0;
  const unparsedLines: number[] = [];
  for (let idx = 1; idx < lines.length; idx++) { // idx 0 is the header comment
    const lineNo = idx + 1;
    const result = parseLine(lines[idx], lineNo);
    if (!lines[idx].trim()) continue;
    if (result.unparsed) {
      unparsedLines.push(lineNo);
      continue;
    }
    parsedLines++;
    rules.push(...result.rules);
  }
  return { rules, parsedLines, unparsedLines };
}

// JSON.stringify of a tuple gives an unambiguous key (quoting/escaping keeps
// fields from bleeding into each other) without picking a delimiter character
// that CSS text might itself contain.
function identity(r: Rule): string {
  return JSON.stringify([r.wrapper, r.selector, r.property, r.value]);
}

function groupKey(r: Rule): string {
  return JSON.stringify([r.property, r.specificity, r.wrapper]);
}

function dedupeByIdentity(rules: Rule[]): Map<string, Rule> {
  // last occurrence of a given (wrapper, selector, property, value) wins,
  // matching how a real stylesheet would apply a repeated identical declaration.
  const byIdentity = new Map<string, Rule>();
  for (const r of rules) byIdentity.set(identity(r), r);
  return byIdentity;
}

function diffWinners(oldRules: Rule[], newRules: Rule[]): { flips: FlipRow[]; compared: number } {
  const oldById = dedupeByIdentity(oldRules);
  const newById = dedupeByIdentity(newRules);

  const groups = new Map<string, { old: Rule; new: Rule }[]>();
  for (const [id, oldRule] of oldById) {
    const newRule = newById.get(id);
    if (!newRule) continue;
    const key = groupKey(oldRule);
    const entry = { old: oldRule, new: newRule };
    const list = groups.get(key);
    if (list) list.push(entry);
    else groups.set(key, [entry]);
  }

  const flips: FlipRow[] = [];
  let compared = 0;
  for (const list of groups.values()) {
    if (list.length < 2) continue;
    for (let i = 0; i < list.length; i++) {
      for (let j = i + 1; j < list.length; j++) {
        const ea = list[i], eb = list[j];
        if (ea.old.selector === eb.old.selector) continue;
        compared++;
        const oldWinner = ea.old.line > eb.old.line ? ea.old.selector : eb.old.selector;
        const newWinner = ea.new.line > eb.new.line ? ea.new.selector : eb.new.selector;
        if (oldWinner === newWinner) continue;
        flips.push({
          property: ea.old.property,
          specificity: ea.old.specificity,
          wrapper: ea.old.wrapper,
          a: { selector: ea.old.selector, value: ea.old.value },
          b: { selector: eb.old.selector, value: eb.old.value },
          oldWinner,
          newWinner,
        });
      }
    }
  }
  return { flips, compared };
}

function ruleText(wrapper: string, selector: string, property: string, value: string): string {
  const decl = `${selector}{${property}:${value};}`;
  return wrapper ? `${wrapper} {${decl}}` : decl;
}

function report(oldFile: string, newFile: string, summary: boolean): void {
  const oldText = readFileSync(oldFile, "utf8");
  const newText = readFileSync(newFile, "utf8");
  const oldParsed = parseStylesheet(oldText);
  const newParsed = parseStylesheet(newText);
  const { flips, compared } = diffWinners(oldParsed.rules, newParsed.rules);

  for (const lineNo of oldParsed.unparsedLines) console.error(`WARN: ${oldFile}:${lineNo}: could not parse rule shape`);
  for (const lineNo of newParsed.unparsedLines) console.error(`WARN: ${newFile}:${lineNo}: could not parse rule shape`);

  if (summary) {
    const byProperty = new Map<string, number>();
    for (const f of flips) byProperty.set(f.property, (byProperty.get(f.property) ?? 0) + 1);
    for (const [property, count] of [...byProperty].sort((x, y) => y[1] - x[1])) {
      console.log(`${property}: ${count} flip(s)`);
    }
  } else {
    for (const f of flips) {
      console.log(`FLIP property=${f.property} specificity=(${f.specificity.join(",")}) wrapper=${f.wrapper || "(none)"}`);
      console.log(`  A: ${ruleText(f.wrapper, f.a.selector, f.property, f.a.value)}`);
      console.log(`  B: ${ruleText(f.wrapper, f.b.selector, f.property, f.b.value)}`);
      console.log(`  old winner: ${f.oldWinner}`);
      console.log(`  new winner: ${f.newWinner}`);
    }
  }

  console.log(`rules parsed: old=${oldParsed.parsedLines} new=${newParsed.parsedLines}`);
  console.log(`conflicting pairs compared: ${compared}`);
  console.log(`pairs flipped: ${flips.length}`);
}

function assertEqual(actual: unknown, expected: unknown, msg: string): void {
  try {
    deepStrictEqual(actual, expected);
  } catch {
    // JSON.stringify is only for the error text; a Set/Map would stringify to
    // "{}" and hide a real mismatch, so the comparison itself uses deepStrictEqual.
    throw new Error(`FAIL: ${msg}: expected ${JSON.stringify(expected)}, got ${JSON.stringify(actual)}`);
  }
}

function selfTest(): void {
  const specificityCases: [selector: string, expected: Spec, label: string][] = [
    [".foo", [0, 1, 0], "single class"],
    [".foo.bar", [0, 2, 0], "compound classes"],
    [".css-ho73o9-rowHighlighted.css-4g6ai3-rowClickable", [0, 2, 0], "compound classes with digits/hyphens"],
    [".foo > *", [0, 1, 0], "combinator + universal"],
    [".foo:focus", [0, 2, 0], "pseudo-class"],
    ["div::before", [0, 0, 2], "element + pseudo-element"],
    [":where(.a, #b)", [0, 0, 0], ":where contributes 0"],
    [":is(.a, #b)", [1, 0, 0], ":is takes most specific arg"],
    [":not(.a)", [0, 1, 0], ":not takes its arg's specificity"],
    [":has(> .a)", [0, 1, 0], ":has takes its arg's specificity"],
  ];
  for (const [selector, expected, label] of specificityCases) {
    assertEqual(calcSpecificity(selector), expected, label);
  }
  assertEqual(calcSpecificity(".x:before"), calcSpecificity(".x::before"), "legacy :before equals ::before");

  const oneRule = parseLine(".css-1d33txl-stackChildrenMinHeight > *{min-height:0;}", 2);
  assertEqual(oneRule.rules.length, 1, "child combinator + universal parses to one rule");

  const trailingSpace = parseLine(".css-n57ekt-textareaMinHeight{min-height:var(--minHeight-kxerk4) ;}", 2);
  assertEqual(trailingSpace.rules[0].value, "var(--minHeight-kxerk4)", "trailing space in value is trimmed");

  const media = parseLine("@media (max-width: 992px) {.css-lcaceq-rowCollapseBelow{grid-gap:16px;}}", 2);
  assertEqual(media.rules.length, 1, "@media wrapper yields one rule");
  assertEqual(media.rules[0].wrapper, "@media (max-width: 992px)", "@media wrapper text");
  assertEqual(media.rules[0].selector, ".css-lcaceq-rowCollapseBelow", "@media inner selector");

  const container = parseLine("@container app-main (max-width:768px){.css-x-y{display:none;}}", 2);
  assertEqual(container.rules[0].wrapper, "@container app-main (max-width:768px)", "@container wrapper text (no space before brace)");

  const blockLayer = parseLine("@layer utilities{.css-z{color:red;}}", 2);
  assertEqual(blockLayer.rules[0].wrapper, "@layer utilities", "block-form @layer is a wrapper");

  const skippedAtRules: [css: string, label: string][] = [
    ["@keyframes keyframe-abc{from{opacity:0;}to{opacity:1;}}", "@keyframes"],
    ['@property --var-abc{syntax:"*";inherits:false;}', "@property"],
    ['@font-face {font-family:"X";src:url(a) format("woff2");}', "@font-face"],
    ["@layer reset, base, utilities;", "statement-form @layer"],
  ];
  for (const [css, label] of skippedAtRules) {
    const parsed = parseLine(css, 2);
    assertEqual(parsed.rules.length, 0, `${label} skipped`);
    assertEqual(parsed.skippedByDesign, true, `${label} marked skipped by design, not unparsed`);
  }

  const list = parseLine("a, b{color:red;}", 2);
  assertEqual(list.rules.length, 2, "selector list expands to two rules");
  assertEqual(list.rules.map((r) => r.selector), ["a", "b"], "selector list members");

  const old = [
    "/* header */",
    ".css-3-c{color:green;}",
    ".css-1-a{color:red;}",
    ".css-2-b{color:blue;}",
  ].join("\n");
  const next = [
    "/* header */",
    ".css-3-c{color:green;}",
    ".css-2-b{color:blue;}",
    ".css-1-a{color:red;}",
  ].join("\n");
  const oldParsed = parseStylesheet(old);
  const newParsed = parseStylesheet(next);
  assertEqual(oldParsed.parsedLines, 3, "self-test old: 3 rule lines parsed");
  const { flips, compared } = diffWinners(oldParsed.rules, newParsed.rules);
  assertEqual(compared, 3, "self-test: 3 conflicting pairs (a-b, a-c, b-c)");
  assertEqual(flips.length, 1, "self-test: exactly one flip (a vs b)");
  assertEqual(new Set([flips[0].a.selector, flips[0].b.selector]), new Set([".css-1-a", ".css-2-b"]), "flip involves a and b");
  assertEqual(flips[0].oldWinner, ".css-2-b", "old winner is b (later in old)");
  assertEqual(flips[0].newWinner, ".css-1-a", "new winner is a (later in new)");

  const selfDiff = diffWinners(oldParsed.rules, oldParsed.rules);
  assertEqual(selfDiff.flips.length, 0, "identical file vs itself: 0 flips");

  const perfLines = ["/* header */"];
  const properties = ["color", "background-color", "padding", "margin", "display"];
  for (let i = 0; i < 25000; i++) {
    const prop = properties[i % properties.length];
    perfLines.push(`.css-perf${i}-x{${prop}:${i}px;}`);
  }
  const perfText = perfLines.join("\n");
  const t0 = Date.now();
  const perfParsed = parseStylesheet(perfText);
  const perfDiff = diffWinners(perfParsed.rules, perfParsed.rules);
  const elapsedMs = Date.now() - t0;
  assertEqual(perfDiff.flips.length, 0, "perf test: identical sheet vs itself has 0 flips");
  if (elapsedMs > 10000) throw new Error(`FAIL: perf test took ${elapsedMs}ms, expected well under 10000ms`);
  console.log(`self-test: 25000-rule synthetic diff took ${elapsedMs}ms`);

  console.log("self-test: all assertions passed");
}

function main(): void {
  const argv = process.argv.slice(2);
  if (argv.includes("--self-test")) {
    selfTest();
    process.exit(0);
  }
  const summary = argv.includes("--summary");
  const positional = argv.filter((a) => !a.startsWith("--"));
  if (positional.length !== 2) {
    console.error("Usage: node scripts/css-winner-diff.ts OLD.css NEW.css [--summary]");
    process.exit(1);
  }
  const [oldFile, newFile] = positional;
  report(oldFile, newFile, summary);
  process.exit(0); // report tool, not a gate: exit 0 even when flips are found
}

main();
