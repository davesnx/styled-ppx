import { rm, symlink } from "node:fs/promises";
import Path from "node:path";

if (process.env.VERCEL) {
  const repositoryRoot = Path.resolve(process.cwd(), "../..");
  const outputPath = Path.join(repositoryRoot, ".next");
  const targetPath = Path.relative(repositoryRoot, Path.resolve(".next"));

  await rm(outputPath, { force: true, recursive: true });
  await symlink(targetPath, outputPath, "dir");
}
