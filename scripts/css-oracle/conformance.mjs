/**
 * Generates the spec-conformance cram test from the coverage oracle,
 * turning packages/css-grammar/data/coverage.md into an executable claim:
 *
 *   - supported.re:   every property the registry supports must compile
 *                     with the simplest expansion of its @webref/css
 *                     value-definition syntax (keywords and zero-values).
 *   - unsupported.re: every spec property the registry does not support
 *                     must fail to compile, so undocumented partial
 *                     support cannot creep in unnoticed.
 *
 * Usage:  node scripts/css-oracle/conformance.mjs <registry-dump-file>
 * Output: packages/ppx/test/css-support/spec-conformance.t/
 *         (committed; CI checks it is in sync via `make css-oracle-check`;
 *         executed by `make test-css-support`).
 */
import { writeFileSync, mkdirSync } from "node:fs";
import { join } from "node:path";
import { root, loadOracle } from "./data.mjs";

const outDir = join(
  root, "packages", "ppx", "test", "css-support", "spec-conformance.t",
);

/* ------------------------------------------------------------------ */
/* Exceptions.                                                         */
/* ------------------------------------------------------------------ */

/* Registered properties whose grammar rejects the spec's simplest legal
   value. These are pre-existing css-grammar bugs surfaced by this
   generator, excluded here so the conformance suite stays green while
   they are fixed; each entry names the spec-legal value that fails. */
const compileExceptions = new Map([]);

/* Spec properties the registry does not register under their own name
   but that nevertheless compile (legacy aliasing inside the parser).
   Excluded from the expect-error file; each entry documents why. */
const errorExceptions = new Map([
  /* filled in below once the first generation run reports failures */
]);

/* ------------------------------------------------------------------ */
/* Value-definition syntax: parser.                                    */
/*                                                                     */
/* Parses raw CSS VDS (https://drafts.csswg.org/css-values/#value-defs)*/
/* precedence, loosest to tightest: ` | ` alternation, `||` any-of,    */
/* `&&` all-of, juxtaposition; components carry `?` `*` `+` `#` `{m,n}`*/
/* `!` multipliers; `[ ... ]` groups; `<type [range]>` references.     */
/* ------------------------------------------------------------------ */

const tokenize = (syntax) => {
  const tokens = [];
  let i = 0;
  const s = syntax;
  while (i < s.length) {
    const c = s[i];
    if (/\s/.test(c)) { i += 1; continue; }
    if (c === "|" && s[i + 1] === "|") { tokens.push({ t: "||" }); i += 2; continue; }
    if (c === "|") { tokens.push({ t: "|" }); i += 1; continue; }
    if (c === "&" && s[i + 1] === "&") { tokens.push({ t: "&&" }); i += 2; continue; }
    if (c === "[") {
      /* `[` opens either a group or a bracketed range (webref writes
         ranges both inside and outside the <type>: `<length [0,∞]>`
         and `<length> [0,∞]`). Ranges never nest and never contain
         combinators; recognise them by shape. */
      let depth = 0;
      let end = i;
      do {
        if (s[end] === "[") depth += 1;
        if (s[end] === "]") depth -= 1;
        end += 1;
      } while (end < s.length && depth > 0);
      const inner = s.slice(i, end);
      if (/^\[\s*[-−+]?[\d∞.a-zA-Z%]+\s*,\s*[-−+]?[\d∞.a-zA-Z%]+\s*\]$/.test(inner)) {
        tokens.push({ t: "range", v: inner });
        i = end;
        continue;
      }
      tokens.push({ t: "[" });
      i += 1;
      continue;
    }
    if (c === "]") { tokens.push({ t: "]" }); i += 1; continue; }
    if (c === "<") {
      const end = s.indexOf(">", i);
      if (end === -1) throw new Error(`unterminated <> in: ${s}`);
      tokens.push({ t: "type", v: s.slice(i + 1, end).trim() });
      i = end + 1;
      continue;
    }
    if (c === "?" || c === "*" || c === "+" || c === "!") {
      tokens.push({ t: "mult", v: c });
      i += 1;
      continue;
    }
    if (c === "#") {
      /* `#` optionally followed by {m,n}; the brace part is consumed as
         its own mult token right after and merged during parsing. */
      tokens.push({ t: "mult", v: "#" });
      i += 1;
      continue;
    }
    if (c === "{") {
      const end = s.indexOf("}", i);
      if (end === -1) throw new Error(`unterminated {} in: ${s}`);
      tokens.push({ t: "mult", v: s.slice(i, end + 1) });
      i = end + 1;
      continue;
    }
    if (c === "/" || c === ",") { tokens.push({ t: "literal", v: c }); i += 1; continue; }
    if (c === "'" || c === '"') {
      const end = s.indexOf(c, i + 1);
      if (end === -1) throw new Error(`unterminated string in: ${s}`);
      tokens.push({ t: "string", v: s.slice(i + 1, end) });
      i = end + 1;
      continue;
    }
    const ident = /^[-+]?[A-Za-z0-9_][-A-Za-z0-9_.]*/.exec(s.slice(i));
    if (ident) {
      const word = ident[0];
      i += word.length;
      if (s[i] === "(") {
        /* function notation: consume balanced parens; never expandable */
        let depth = 0;
        const start = i;
        do {
          if (s[i] === "(") depth += 1;
          if (s[i] === ")") depth -= 1;
          i += 1;
        } while (i < s.length && depth > 0);
        tokens.push({ t: "func", v: word + s.slice(start, i) });
        continue;
      }
      tokens.push({ t: "ident", v: word });
      continue;
    }
    throw new Error(`unexpected character '${c}' in: ${s}`);
  }
  return tokens;
};

const parse = (tokens) => {
  let pos = 0;
  const peek = () => tokens[pos];
  const next = () => tokens[pos++];

  const parseComponent = () => {
    const tok = next();
    let node;
    if (tok.t === "[") {
      node = { k: "group", body: parseAlternation() };
      if (!peek() || next().t !== "]") throw new Error("expected ]");
    } else if (tok.t === "type") {
      node = { k: "type", v: tok.v };
      if (peek() && peek().t === "range") node.v += ` ${next().v}`;
    } else if (tok.t === "range") {
      node = { k: "opaque", v: tok.v };
    } else if (tok.t === "ident") {
      node = { k: "keyword", v: tok.v };
    } else if (tok.t === "literal") {
      node = { k: "literal", v: tok.v };
    } else if (tok.t === "string" || tok.t === "func") {
      node = { k: "opaque", v: tok.v };
    } else {
      throw new Error(`unexpected token ${tok.t}`);
    }
    while (peek() && peek().t === "mult") {
      const m = next().v;
      if (m === "#" && peek() && peek().t === "mult" && peek().v.startsWith("{")) {
        node = { k: "mult", v: "#" + next().v, body: node };
      } else {
        node = { k: "mult", v: m, body: node };
      }
    }
    return node;
  };

  const parseJuxtaposition = () => {
    const parts = [parseComponent()];
    while (peek() && !["|", "||", "&&", "]"].includes(peek().t)) {
      parts.push(parseComponent());
    }
    return parts.length === 1 ? parts[0] : { k: "juxt", parts };
  };

  const parseAllOf = () => {
    const parts = [parseJuxtaposition()];
    while (peek() && peek().t === "&&") { next(); parts.push(parseJuxtaposition()); }
    return parts.length === 1 ? parts[0] : { k: "&&", parts };
  };

  const parseAnyOf = () => {
    const parts = [parseAllOf()];
    while (peek() && peek().t === "||") { next(); parts.push(parseAllOf()); }
    return parts.length === 1 ? parts[0] : { k: "||", parts };
  };

  const parseAlternation = () => {
    const parts = [parseAnyOf()];
    while (peek() && peek().t === "|") { next(); parts.push(parseAnyOf()); }
    return parts.length === 1 ? parts[0] : { k: "|", parts };
  };

  const ast = parseAlternation();
  if (pos !== tokens.length) throw new Error("trailing tokens");
  return ast;
};

/* ------------------------------------------------------------------ */
/* Value-definition syntax: simplest expansion.                        */
/*                                                                     */
/* Returns a string (possibly "" for fully-optional nodes) or null     */
/* when the node has no keywords-and-zero-values expansion.            */
/* ------------------------------------------------------------------ */

/* `<length [0,∞]>`-style ranges: zero only satisfies the type when the
   range admits it. Unparseable bounds fail closed (null). */
const zeroInRange = (range) => {
  if (range === undefined) return true;
  const m = /^\[\s*([^,]+?)\s*,\s*([^\]]+?)\s*\]$/.exec(range);
  if (!m) return false;
  const bound = (raw, fallback) => {
    if (/^[-−]?(∞|[Ii]nfinity)$/.test(raw)) return fallback;
    const num = parseFloat(raw);
    return Number.isNaN(num) ? null : num;
  };
  const lo = bound(m[1], -Infinity);
  const hi = bound(m[2], Infinity);
  if (lo === null || hi === null) return false;
  return lo <= 0 && 0 <= hi;
};

const expandType = (spec) => {
  const m = /^(\S+?)(?:\s+(\[.*\]))?$/.exec(spec);
  if (!m) return null;
  const [, name, range] = m;
  if (name === "length" || name === "number" || name === "integer") {
    return zeroInRange(range) ? "0" : null;
  }
  if (name === "percentage") return zeroInRange(range) ? "0%" : null;
  return null; /* every other <type> (and <'prop'>) is "fancy": skip */
};

const joinParts = (parts) => {
  let out = "";
  for (const part of parts) {
    if (part === "") continue;
    if (part === ",") out += ",";
    else out += (out === "" ? "" : " ") + part;
  }
  return out;
};

const expand = (node) => {
  switch (node.k) {
    case "keyword":
    case "literal":
      return node.v;
    case "opaque":
      return null;
    case "type":
      return expandType(node.v);
    case "group":
      return expand(node.body);
    case "|": {
      /* one branch is enough: first branch with a non-empty expansion,
         falling back to an empty one if that is all there is */
      let empty = null;
      for (const part of node.parts) {
        const v = expand(part);
        if (v !== null && v !== "") return v;
        if (v === "") empty = v;
      }
      return empty;
    }
    case "||": {
      /* at least one component must be present: pick the first that
         expands to something non-empty */
      for (const part of node.parts) {
        const v = expand(part);
        if (v !== null && v !== "") return v;
      }
      return null;
    }
    case "&&": {
      /* all components required */
      const parts = node.parts.map(expand);
      if (parts.some((p) => p === null)) return null;
      return joinParts(parts);
    }
    case "juxt": {
      const parts = node.parts.map(expand);
      if (parts.some((p) => p === null)) return null;
      return joinParts(parts);
    }
    case "mult": {
      const m = node.v;
      if (m === "?" || m === "*") return ""; /* omit */
      if (m === "+" || m === "#") return expand(node.body); /* one occurrence */
      if (m === "!") {
        const v = expand(node.body);
        return v === "" ? null : v; /* required group must not be empty */
      }
      /* {m,n} / #{m,n}: minimum occurrences, comma-joined for # */
      const counted = /^(#?)\{(\d+)(?:,\s*(\d+|∞)?)?\}$/.exec(m);
      if (counted) {
        const sep = counted[1] === "#" ? ", " : " ";
        const min = parseInt(counted[2], 10);
        if (min === 0) return "";
        const v = expand(node.body);
        if (v === null || v === "") return v;
        return Array.from({ length: min }, () => v).join(sep);
      }
      throw new Error(`unknown multiplier ${m}`);
    }
    default:
      throw new Error(`unknown node kind ${node.k}`);
  }
};

export const expandSyntax = (syntax) => {
  const value = expand(parse(tokenize(syntax)));
  return value === "" ? null : value;
};

/* ------------------------------------------------------------------ */
/* Generation.                                                         */
/* ------------------------------------------------------------------ */

const { webref, properties, stdProps, missing, missingAliases } = loadOracle(
  process.argv[2],
);

const generatedNote = [
  "Generated by `make css-oracle` (scripts/css-oracle/conformance.mjs).",
  "Do not edit by hand: regenerate and commit; `make css-oracle-check`",
  "gates drift.",
];
const reNote = `/* ${generatedNote.join("\n   ")} */`;

/* Supported properties: registry ∩ webref standard properties. */
const supported = [];
const skipped = [];
for (const [name, v] of stdProps) {
  if (!properties.has(name)) continue;
  if (compileExceptions.has(name)) continue;
  const value = v.syntax ? expandSyntax(v.syntax) : null;
  if (value === null) skipped.push(name);
  else supported.push([name, value]);
}

/* Unsupported properties: webref (standard + legacy alias) ∖ registry. */
const unsupported = [...missing, ...missingAliases]
  .filter(([name]) => !errorExceptions.has(name))
  .map(([name, v]) => {
    const value = v.syntax ? expandSyntax(v.syntax) : null;
    return [name, value ?? "inherit"];
  })
  .sort(([a], [b]) => (a < b ? -1 : 1));

const supportedRe = [
  reNote,
  "",
  `/* ${supported.length} properties the registry supports, each with the`,
  "   simplest keywords-and-zero-values expansion of its spec syntax.",
  `   ${skipped.length} supported properties have no such expansion and are`,
  "   exercised by the hand-written css-support suites instead:",
  ...skipped.map((name) => `     ${name}`),
  compileExceptions.size > 0
    ? `   ${compileExceptions.size} properties are excluded as known grammar bugs (see conformance.mjs):`
    : "   no properties are currently excluded as known grammar bugs.",
  ...[...compileExceptions].map(([name, why]) => `     ${name}: ${why}`),
  "*/",
  "",
  ...supported.map(([name, value]) => `[%css {|${name}: ${value}|}];`),
  "",
].join("\n");

const unsupportedRe = [
  reNote,
  "",
  `/* ${unsupported.length} spec properties the registry does not support;`,
  "   every declaration below must fail to compile.",
  errorExceptions.size > 0
    ? `   ${errorExceptions.size} spec properties compile despite not being registered under`
    : "   no properties are currently excluded as compiling-by-alias.",
  ...(errorExceptions.size > 0
    ? ["   their own name and are excluded (see conformance.mjs):"]
    : []),
  ...[...errorExceptions].map(([name, why]) => `     ${name}: ${why}`),
  "*/",
  "",
  ...unsupported.map(([name, value]) => `[%css {|${name}: ${value}|}];`),
  "",
].join("\n");

const runT = `${generatedNote.join("\n")}

Executable form of the coverage report
(packages/css-grammar/data/coverage.md, oracle: ${webref.source} ${webref.version}).

  $ cat > dune-project << EOF
  > (lang dune 3.10)
  > EOF

Every property the css-grammar registry supports compiles with the
simplest expansion of its spec value-definition syntax (${supported.length}
properties; on failure the compiler error below names the offender, and
\`dune describe pp ./supported.re\` shows all offenders at once):

  $ cat > dune << EOF
  > (executable
  >  (name supported)
  >  (modules supported)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune build

Every spec property the registry does not support fails to compile: each
of the ${unsupported.length} declarations must produce exactly one error node and no
generated style, so undocumented partial support cannot creep in:

  $ cat > dune << EOF
  > (executable
  >  (name unsupported)
  >  (modules unsupported)
  >  (libraries styled-ppx.native)
  >  (preprocess (pps styled-ppx)))
  > EOF

  $ dune describe pp ./unsupported.re | grep -c "ocaml.error"
  ${unsupported.length}

  $ dune describe pp ./unsupported.re | grep -c "CSS.make"
  0
  [1]
`;

mkdirSync(outDir, { recursive: true });
writeFileSync(join(outDir, "supported.re"), supportedRe);
writeFileSync(join(outDir, "unsupported.re"), unsupportedRe);
writeFileSync(join(outDir, "run.t"), runT);

console.log(
  `conformance: ${supported.length} compile tests (${skipped.length} skipped: no ` +
    `keywords-and-zero-values expansion, ${compileExceptions.size} known grammar ` +
    `bugs), ${unsupported.length} expect-error tests (${errorExceptions.size} ` +
    `alias exceptions); suite at packages/ppx/test/css-support/spec-conformance.t`,
);
