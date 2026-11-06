import { compile, type Element } from "stylis";
import type { Case, El } from "./case.ts";

export const SELF = "__self__";

const bindingRef = /\.\$\(([A-Za-z_][\w]*)\)/g;
const varRef = /\$\(([A-Za-z_][\w]*)\)/g;

export function bindingRefs(css: string): string[] {
  return [...css.matchAll(bindingRef)].map((m) => m[1]!);
}

export function varRefs(css: string): string[] {
  return [...css.replace(bindingRef, "").matchAll(varRef)].map((m) => m[1]!);
}

export type VarText = (name: string, value: string) => string;

export function substitute(c: Case, css: string, bindingClass: (name: string) => string, varText: VarText = (_, value) => value): string {
  return css
    .replace(bindingRef, (_, name: string) => "." + bindingClass(name))
    .replace(varRef, (_, name: string) => {
      const v = c.vars?.[name];
      if (!v) throw new Error(`${c.id}: unknown var $(${name})`);
      return varText(name, v.css);
    });
}

export type Context = {
  scope: string;
  conditions: string[];
  important: boolean;
};

export type Declaration = {
  context: Context;
  contextKey: string;
  prop: string;
  text: string;
};

export function contextKey(c: Context): string {
  return [c.scope, ...c.conditions, c.important ? "!important" : ""].join(" | ");
}

const normalizeCondition = (c: string) => c.replace(/\s+/g, " ").replace(/\s*([(),:])\s*/g, "$1").trim();

function normalizeSelector(selector: string): string {
  const m = /^(.*?)((?::[a-z-]+)+)$/.exec(selector);
  if (!m || m[1]!.endsWith(":")) return selector;
  return m[1]! + m[2]!.split(":").filter(Boolean).sort().map((p) => ":" + p).join("");
}

export type Normalize = "design" | "none";

export function declarations(css: string, normalize: Normalize = "design"): Declaration[] {
  const out: Declaration[] = [];
  const design = normalize === "design";
  const walk = (nodes: Element[], conditions: string[], scope: string) => {
    for (const n of nodes) {
      if (n.type === "decl") {
        const text = n.value.replace(/;$/, "");
        const sorted = design ? [...conditions].sort() : conditions;
        const context = { scope, conditions: sorted, important: /!\s*important$/i.test(text) };
        out.push({ context, contextKey: contextKey(context), prop: String(n.props), text });
      } else if (n.type === "rule") {
        const selectors = n.props as string[];
        if (design) for (const sel of selectors) walk(n.children as Element[], conditions, normalizeSelector(sel));
        else walk(n.children as Element[], conditions, selectors.join(","));
      } else if (n.type.startsWith("@") && Array.isArray(n.children)) {
        walk(n.children, [...conditions, design ? normalizeCondition(n.value) : n.value], scope);
      }
    }
  };
  walk(compile(`.${SELF}{${css}}`), [], "." + SELF);
  return out;
}

export function declaredProps(c: Case): string[] {
  return Object.values(c.blocks).flatMap((css) =>
    declarations(substitute(c, css, (n) => `b-${n}`)).map((d) => d.prop),
  );
}

export function wrapRule(context: Context, cls: string, body: string): string {
  const selector = context.scope.replaceAll(SELF, cls);
  return context.conditions.reduceRight((inner, cond) => `${cond}{${inner}}`, `${selector}{${body}}`);
}

const escapeAttr = (s: string) =>
  s.replace(/&/g, "&amp;").replace(/"/g, "&quot;").replace(/</g, "&lt;");

export function renderTree(tree: El[], classOf: (el: El) => string, styleOf: (el: El) => string = () => ""): string {
  const one = (el: El): string => {
    const tag = el.tag ?? "div";
    const cls = classOf(el);
    const style = styleOf(el);
    const attrs = [
      `id="${escapeAttr(el.id)}"`,
      el.dir ? `dir="${el.dir}"` : "",
      cls ? `class="${escapeAttr(cls)}"` : "",
      style ? `style="${escapeAttr(style)}"` : "",
    ]
      .filter(Boolean)
      .join(" ");
    return `<${tag} ${attrs}>${(el.children ?? []).map(one).join("")}</${tag}>`;
  };
  return tree.map(one).join("");
}

export function elements(tree: El[]): El[] {
  return tree.flatMap((el) => [el, ...elements(el.children ?? [])]);
}

export function mergeOf(el: El, order: Record<string, string[]>): string[] {
  return order[el.id] ?? el.merge;
}
