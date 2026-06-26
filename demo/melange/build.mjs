import Esbuild from "esbuild";

/* Minimal argv parser supporting `--key=value`, `--key value` and `--flag`. */
function parseArgv(argv) {
	const args = argv.slice(2);
	const result = { _: [] };

	for (let i = 0; i < args.length; i++) {
		const arg = args[i];

		if (arg.startsWith("--")) {
			const longArg = arg.slice(2);
			if (longArg.includes("=")) {
				const [key, value] = longArg.split("=");
				result[key] = value;
			} else if (i + 1 < args.length && !args[i + 1].startsWith("-")) {
				result[longArg] = args[++i];
			} else {
				result[longArg] = true;
			}
		} else {
			result._.push(arg);
		}
	}

	return result;
}

async function build(entryPoints, { output, env }) {
	const isDev = env === "development";

	try {
		await Esbuild.build({
			entryPoints,
			bundle: true,
			outfile: output,
			platform: "browser",
			format: "esm",
			logLevel: "info",
			treeShaking: !isDev,
			minify: !isDev,
			define: {
				"process.env.NODE_ENV": `"${env}"`,
			},
		});

		console.log(
			`esbuild: bundled ${entryPoints.join(", ")} -> ${output} (${env})`,
		);
	} catch (error) {
		console.error("\nesbuild failed:", error);
		process.exit(1);
	}
}

const flags = parseArgv(process.argv);
const entryPoints = flags._;
const output = flags.output;
const env = flags.env || "production";

if (entryPoints.length === 0 || !output) {
	console.error(
		"Usage: node build.mjs <entrypoint> [...] --output=<file> [--env=development|production]",
	);
	process.exit(1);
}

build(entryPoints, { output, env });
