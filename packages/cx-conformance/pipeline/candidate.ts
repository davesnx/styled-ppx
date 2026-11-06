import { spawn, type ChildProcessWithoutNullStreams } from "node:child_process";
import { createRequire } from "node:module";
import { join } from "node:path";
import { createInterface } from "node:readline";
import { pathToFileURL } from "node:url";
import type { Candidate, Case, El, Rendered } from "../src/case.ts";
import { buildCases, caseKey, type BuildResult, type CaseBuild, type Env } from "./build.ts";

export type FailureKind = "compile" | "hydration" | "runtime";

export class CandidateError extends Error {
  kind: FailureKind;
  rendered?: Rendered;
  constructor(kind: FailureKind, message: string, rendered?: Rendered) {
    super(message);
    this.name = "CandidateError";
    this.kind = kind;
    this.rendered = rendered;
  }
}

export type PpxCandidate = Candidate & {
  prepare(cases: Case[]): Promise<void>;
  close(): Promise<void>;
};

type Request = { case: string; tree: El[] };
type Reply = { html?: string; error?: string };

class NativeDriver {
  private child: ChildProcessWithoutNullStreams;
  private pending: Array<(reply: Reply) => void> = [];

  constructor(exe: string) {
    this.child = spawn(exe, [], { stdio: ["pipe", "pipe", "pipe"] });
    let stderr = "";
    this.child.stderr.on("data", (chunk: Buffer) => (stderr += chunk.toString()));
    createInterface({ input: this.child.stdout }).on("line", (line) => {
      this.pending.shift()?.(JSON.parse(line) as Reply);
    });
    this.child.on("close", (code) => {
      for (const resolve of this.pending.splice(0)) {
        resolve({ error: `native driver exited with ${code}: ${stderr}` });
      }
    });
  }

  render(request: Request): Promise<Reply> {
    return new Promise((resolve) => {
      this.pending.push(resolve);
      this.child.stdin.write(JSON.stringify(request) + "\n");
    });
  }

  close(): Promise<void> {
    if (this.child.exitCode !== null) return Promise.resolve();
    return new Promise((resolve) => {
      this.child.on("close", () => resolve());
      this.child.stdin.end();
    });
  }
}

type Carrier = [string, Record<string, string>];
type CaseModule = { cx_conformance_bindings: Array<[string, Carrier]> };
type Client = {
  merge: (a: Carrier, b: Carrier) => Carrier;
  createElement: (tag: string, props: object, ...children: unknown[]) => unknown;
  renderToStaticMarkup: (element: unknown) => string;
};

async function loadClient(emitDir: string): Promise<Client> {
  const require = createRequire(join(emitDir, "index.js"));
  const css = (await import(
    pathToFileURL(join(emitDir, "node_modules", "styled-ppx.melange", "CSS.mjs")).href
  )) as { merge: Client["merge"] };
  const react = require("react") as { createElement: Client["createElement"] };
  const server = require("react-dom/server") as { renderToStaticMarkup: Client["renderToStaticMarkup"] };
  return {
    merge: css.merge,
    createElement: react.createElement,
    renderToStaticMarkup: server.renderToStaticMarkup,
  };
}

function renderClient(client: Client, mod: CaseModule, tree: El[]): string {
  const bindings = new Map(mod.cx_conformance_bindings);
  const lookup = (name: string): Carrier => {
    const carrier = bindings.get(name);
    if (!carrier) throw new Error(`unknown binding ${name}`);
    return carrier;
  };
  const element = (el: El): unknown => {
    const [first, ...rest] = el.merge;
    const carrier = first === undefined ? undefined : rest.reduce((acc, n) => client.merge(acc, lookup(n)), lookup(first));
    const props: Record<string, unknown> = { id: el.id };
    if (el.dir) props.dir = el.dir;
    if (carrier) {
      props.className = carrier[0];
      props.style = carrier[1];
    }
    return client.createElement(el.tag ?? "div", props, ...(el.children ?? []).map(element));
  };
  return client.renderToStaticMarkup(client.createElement("div", {}, ...tree.map(element)));
}

type Attrs = { class: string; style: string };

function attributesById(html: string): Map<string, Attrs> {
  const result = new Map<string, Attrs>();
  for (const tag of html.matchAll(/<[a-zA-Z][\w-]*((?:\s+[\w-]+="[^"]*")*)\s*\/?>/g)) {
    const attrs = new Map([...(tag[1] ?? "").matchAll(/([\w-]+)="([^"]*)"/g)].map((m) => [m[1], m[2]]));
    const id = attrs.get("id");
    if (id !== undefined) result.set(id, { class: attrs.get("class") ?? "", style: attrs.get("style") ?? "" });
  }
  return result;
}

function hydrationDiff(server: string, client: string): string[] {
  const s = attributesById(server);
  const c = attributesById(client);
  const diffs: string[] = [];
  for (const [id, sa] of s) {
    const ca = c.get(id);
    if (!ca) {
      diffs.push(`#${id}: missing in client render`);
      continue;
    }
    for (const attr of ["class", "style"] as const) {
      if (sa[attr] !== ca[attr]) {
        diffs.push(`#${id} ${attr}: native ${JSON.stringify(sa[attr])} vs melange ${JSON.stringify(ca[attr])}`);
      }
    }
  }
  return diffs;
}

function applyOrder(tree: El[], order: Record<string, string[]>): El[] {
  return tree.map((el) => ({
    ...el,
    merge: order[el.id] ?? el.merge,
    children: el.children && applyOrder(el.children, order),
  }));
}

export function makePpx(options: { env?: Env } = {}): PpxCandidate {
  const env = options.env ?? "production";
  const built = new Map<string, CaseBuild>();
  const known = new Map<string, Case>();
  const modules = new Map<string, Promise<CaseModule>>();
  let driver: NativeDriver | undefined;
  let driverError: string | undefined;
  let client: Promise<Client> | undefined;
  let emitDir = "";
  let queue: Promise<void> = Promise.resolve();
  let batch: { promise: Promise<void>; fire: () => void; timer?: NodeJS.Timeout } | undefined;

  const rebuild = async () => {
    const cases = [...known.values()];
    if (cases.every((c) => built.has(caseKey(c)))) return;
    const result: BuildResult = await buildCases(cases, env);
    const failed = [...result.cases.values()].filter((b) => b.error).length;
    process.stderr.write(
      `ppx pipeline (${env}): ${result.cases.size} cases built in ${result.seconds.toFixed(1)}s, ${failed} failed to compile\n`,
    );
    const previous = driver;
    driver = result.driverExe ? new NativeDriver(result.driverExe) : undefined;
    await previous?.close();
    driverError = result.driverError;
    if (emitDir !== result.emitDir) client = undefined;
    emitDir = result.emitDir;
    for (const [key, build] of result.cases) built.set(key, build);
  };

  const schedule = (): Promise<void> => {
    if (!batch) {
      let fire = () => {};
      const gate = new Promise<void>((resolve) => (fire = resolve));
      const promise = gate.then(() => {
        batch = undefined;
        queue = queue.then(rebuild, rebuild);
        return queue;
      });
      batch = { promise, fire };
    }
    clearTimeout(batch.timer);
    batch.timer = setTimeout(batch.fire, 50);
    return batch.promise;
  };

  const prepare = async (cases: Case[]) => {
    for (const c of cases) known.set(caseKey(c), c);
    await schedule();
  };

  const render = async (c: Case, order: Record<string, string[]>): Promise<Rendered> => {
    const key = caseKey(c);
    if (!built.has(key)) await prepare([c]);
    const build = built.get(key);
    if (!build) throw new CandidateError("runtime", `case ${c.id} was not built`);
    if (build.error) throw new CandidateError("compile", build.error);
    if (!driver) throw new CandidateError("runtime", `native driver did not build:\n${driverError ?? ""}`);
    const tree = applyOrder(c.tree, order);
    const reply = await driver.render({ case: key, tree });
    if (reply.error !== undefined || reply.html === undefined) {
      throw new CandidateError("runtime", reply.error ?? "no html from native driver");
    }
    const rendered: Rendered = { css: build.css ?? "", html: reply.html };
    if (build.jsError || !build.jsModule) {
      throw new CandidateError("hydration", `Melange build failed:\n${build.jsError ?? ""}`, rendered);
    }
    const jsModule = build.jsModule;
    client ??= loadClient(emitDir);
    if (!modules.has(key)) modules.set(key, import(pathToFileURL(jsModule).href) as Promise<CaseModule>);
    const clientHtml = renderClient(await client, await modules.get(key)!, tree);
    const diffs = hydrationDiff(rendered.html, clientHtml);
    if (diffs.length > 0) throw new CandidateError("hydration", diffs.join("\n"), rendered);
    return rendered;
  };

  return {
    name: env === "production" ? "ppx" : "ppx-dev",
    render,
    prepare,
    close: async () => {
      await queue;
      await driver?.close();
      driver = undefined;
    },
  };
}

export const ppx: PpxCandidate = makePpx({ env: process.env.CX_PPX_ENV === "development" ? "development" : "production" });
export const candidate: PpxCandidate = ppx;
