import { spawn } from "node:child_process";
import { createHash } from "node:crypto";
import {
  existsSync,
  mkdirSync,
  readFileSync,
  symlinkSync,
  writeFileSync,
} from "node:fs";
import { dirname, join, resolve } from "node:path";
import { fileURLToPath } from "node:url";
import type { Case } from "../src/case.ts";

export type Env = "production" | "development";

export type CaseBuild = {
  key: string;
  dir: string;
  error?: string;
  css?: string;
  jsError?: string;
  jsModule?: string;
};

export type BuildResult = {
  cases: Map<string, CaseBuild>;
  driverExe?: string;
  driverError?: string;
  emitDir: string;
  seconds: number;
};

const pipelineDir = dirname(fileURLToPath(import.meta.url));
export const repoRoot = resolve(pipelineDir, "../../..");

function findSwitch(): string {
  if (process.env.OPAMSWITCH && existsSync(join(process.env.OPAMSWITCH, "_opam"))) {
    return process.env.OPAMSWITCH;
  }
  for (let dir = repoRoot; dir !== dirname(dir); dir = dirname(dir)) {
    if (existsSync(join(dir, "_opam", "bin", "dune"))) return dir;
  }
  throw new Error(`no local opam switch (_opam) found above ${repoRoot}`);
}

const opamSwitch = findSwitch();
const install = join(repoRoot, "_build", "install", "default");

const toolEnv: NodeJS.ProcessEnv = {
  ...process.env,
  PATH: [join(install, "bin"), join(opamSwitch, "_opam", "bin"), process.env.PATH].join(":"),
  OPAMSWITCH: opamSwitch,
  OCAMLPATH: join(install, "lib"),
  DUNE_PROFILE: "dev",
};

function run(cmd: string, args: string[], cwd: string): Promise<{ code: number; output: string }> {
  return new Promise((done, fail) => {
    const child = spawn(cmd, args, { cwd, env: toolEnv, stdio: ["ignore", "pipe", "pipe"] });
    let output = "";
    child.stdout.on("data", (chunk: Buffer) => (output += chunk.toString()));
    child.stderr.on("data", (chunk: Buffer) => (output += chunk.toString()));
    child.on("error", fail);
    child.on("close", (code) => done({ code: code ?? 1, output }));
  });
}

async function dune(args: string[], cwd: string): Promise<{ code: number; output: string }> {
  for (let attempt = 0; ; attempt++) {
    const result = await run("dune", ["build", "--root", ".", ...args], cwd);
    if (result.code === 0 || !result.output.includes("Another Dune instance") || attempt === 120) return result;
    await new Promise((wait) => setTimeout(wait, 1000));
  }
}

const identifier = /^[a-z_][A-Za-z0-9_']*$/;
const bindingRef = /\.\$\(([A-Za-z_][\w']*)\)/g;
const varRef = /(?<!\.)\$\(([A-Za-z_][\w']*)\)/g;

export function caseKey(c: Case): string {
  const content = JSON.stringify([c.blocks, c.vars ?? {}]);
  return "c" + createHash("sha256").update(content).digest("hex").slice(0, 16);
}

export function caseSource(c: Case): string {
  const vars = c.vars ?? {};
  const blocks = new Map(Object.entries(c.blocks));
  const names = [...blocks.keys()];
  for (const name of [...names, ...Object.keys(vars)]) {
    if (!identifier.test(name)) throw new Error(`"${name}" is not a Reason value name`);
  }
  for (const [name, body] of blocks) {
    if (body.includes("|}")) throw new Error(`block "${name}" contains "|}"`);
  }
  const deps = new Map(
    [...blocks].map(([name, body]) => [
      name,
      [...body.matchAll(bindingRef)]
        .map((m) => m[1] ?? "")
        .filter((ref) => blocks.has(ref) && ref !== name),
    ]),
  );
  const referenced = new Set([...blocks.values()].flatMap((body) => [...body.matchAll(varRef)].map((m) => m[1])));
  const varName = (name: string): string => (blocks.has(name) ? `${name}_var` : name);
  const body = (name: string): string =>
    (blocks.get(name) ?? "").replace(varRef, (ref, v: string) => (blocks.has(v) ? `$(${varName(v)})` : ref));
  const sorted: string[] = [];
  const state = new Map<string, "visiting" | "done">();
  const visit = (name: string, path: string[]): void => {
    if (state.get(name) === "done") return;
    if (state.get(name) === "visiting") {
      throw new Error(`blocks reference each other in a cycle: ${[...path, name].join(" -> ")}`);
    }
    state.set(name, "visiting");
    for (const dep of deps.get(name) ?? []) visit(dep, [...path, name]);
    state.set(name, "done");
    sorted.push(name);
  };
  for (const name of names) visit(name, []);

  return [
    ...Object.entries(vars)
      .filter(([name]) => referenced.has(name))
      .map(([name, v]) => `let ${varName(name)} = ${v.reason};`),
    ...sorted.map((name) => `let ${name} = [%css {|${body(name)}|}];`),
    `let cx_conformance_bindings = [|${names.map((n) => `("${n}", ${n})`).join(", ")}|];`,
    "",
  ].join("\n");
}

function writeIfChanged(path: string, content: string): void {
  if (existsSync(path) && readFileSync(path, "utf8") === content) return;
  mkdirSync(dirname(path), { recursive: true });
  writeFileSync(path, content);
}

function caseDuneFiles(key: string, env: Env): { native: string; js: string } {
  const pps = `(preprocess (pps styled-ppx -- --env ${env}))`;
  const jsPps = `(preprocess (pps styled-ppx melange.ppx -- --env ${env}))`;
  return {
    native: `(library (name case_${key}) (modules case)
 (libraries styled-ppx.native server-reason-react.reactDom)
 ${pps})
(rule (target styles.css) (deps case.re.pp.ml)
 (action (with-stdout-to %{target} (run styled-ppx.generate %{deps}))))
`,
    js: `(library (name case_${key}_js) (modes melange) (modules case)
 (libraries styled-ppx.melange reason-react)
 ${jsPps})
`,
  };
}

function driverFiles(native: string[], js: string[]): { dune: string; registry: string } {
  return {
    dune: `(executable (name driver) (modules driver registry)
 (libraries yojson styled-ppx.native server-reason-react.react server-reason-react.reactDom
  ${native.map((k) => `case_${k}`).join(" ")}))
(melange.emit (target emit) (modules)
 (libraries styled-ppx.melange ${js.map((k) => `case_${k}_js`).join(" ")})
 (module_systems (es6 mjs)))
`,
    registry: `let cases = [\n${native
      .map((k) => `  ("${k}", Case_${k}.Case.cx_conformance_bindings);`)
      .join("\n")}\n]\n`,
  };
}

function attributeErrors(output: string): Map<string, string> {
  const errors = new Map<string, string>();
  const chunks = output.split(/^(?=File ")/m);
  for (const chunk of chunks) {
    const match = chunk.match(/^File "cases\/(c[0-9a-f]+)\/(native|js)\//);
    if (!match) continue;
    const id = `${match[1]}/${match[2]}`;
    errors.set(id, (errors.get(id) ?? "") + chunk);
  }
  return errors;
}

let installChecked = false;

async function ensureInstall(): Promise<void> {
  if (installChecked || process.env.CX_PIPELINE_SKIP_INSTALL === "1") return;
  const result = await dune(["@install"], repoRoot);
  if (result.code !== 0) {
    throw new Error(`dune build @install failed in ${repoRoot}:\n${result.output}`);
  }
  installChecked = true;
}

function ensureGenRoot(env: Env): string {
  const gen = join(pipelineDir, "_gen");
  const root = join(gen, env);
  mkdirSync(join(root, "driver"), { recursive: true });
  writeIfChanged(join(root, "dune-project"), "(lang dune 3.8)\n(using melange 0.1)\n");
  writeIfChanged(join(root, "driver", "driver.ml"), readFileSync(join(pipelineDir, "native_driver.ml"), "utf8"));
  const modules = join(gen, "node_modules");
  const demoModules = join(repoRoot, "demo", "melange", "node_modules");
  if (!existsSync(modules)) {
    if (!existsSync(join(demoModules, "react-dom"))) {
      throw new Error(`react-dom not installed; run npm install --prefix demo/melange in ${repoRoot}`);
    }
    symlinkSync(demoModules, modules);
  }
  return root;
}

export async function buildCases(cases: Case[], env: Env): Promise<BuildResult> {
  const started = performance.now();
  await ensureInstall();
  const root = ensureGenRoot(env);
  const builds = new Map<string, CaseBuild>();
  for (const c of cases) {
    const key = caseKey(c);
    if (builds.has(key)) continue;
    const dir = join(root, "cases", key);
    const build: CaseBuild = { key, dir };
    builds.set(key, build);
    try {
      const source = caseSource(c);
      writeIfChanged(join(dir, "native", "case.re"), source);
      writeIfChanged(join(dir, "js", "case.re"), source);
    } catch (e) {
      build.error = (e as Error).message;
      continue;
    }
    const dune = caseDuneFiles(key, env);
    writeIfChanged(join(dir, "native", "dune"), dune.native);
    writeIfChanged(join(dir, "js", "dune"), dune.js);
  }

  const candidates = () => [...builds.values()].filter((b) => !b.error).map((b) => b.key);
  const compile = async (native: string[], js: string[]) => {
    const files = driverFiles(native, js);
    writeIfChanged(join(root, "driver", "dune"), files.dune);
    writeIfChanged(join(root, "driver", "registry.ml"), files.registry);
    const targets = [
      "driver/driver.exe",
      "@driver/melange",
      ...native.map((k) => `cases/${k}/native/styles.css`),
    ];
    return dune(targets, root);
  };

  const keys = candidates();
  let result = await compile(keys, keys);
  if (result.code !== 0) {
    const errors = attributeErrors(result.output);
    for (const key of keys) {
      const build = builds.get(key)!;
      const nativeError = errors.get(`${key}/native`);
      const jsError = errors.get(`${key}/js`);
      if (nativeError) build.error = nativeError;
      if (jsError) build.jsError = jsError;
    }
    const native = candidates();
    const js = keys.filter((k) => !builds.get(k)!.jsError);
    result = await compile(native, js);
  }

  const out = join(root, "_build", "default");
  const emitDir = join(out, "driver", "emit");
  for (const build of builds.values()) {
    if (build.error) continue;
    const cssPath = join(out, "cases", build.key, "native", "styles.css");
    if (existsSync(cssPath)) build.css = readFileSync(cssPath, "utf8");
    else build.error ??= `styles.css not produced:\n${result.output}`;
    const jsModule = join(emitDir, "cases", build.key, "js", "case.mjs");
    if (existsSync(jsModule)) build.jsModule = jsModule;
    else build.jsError ??= `case.mjs not produced:\n${result.output}`;
  }
  const exe = join(out, "driver", "driver.exe");
  return {
    cases: builds,
    driverExe: result.code === 0 ? exe : undefined,
    driverError: result.code === 0 ? undefined : result.output,
    emitDir,
    seconds: (performance.now() - started) / 1000,
  };
}
