import type { Metadata } from "next";
import { compileMdx } from "nextra/compile";
import { evaluate } from "nextra/evaluate";
import remarkNormalizeHeadings from "remark-normalize-headings";
// @ts-expect-error -- untyped .mjs module
import { rehypePrettyCodeOptions } from "../../highlighter.mjs";
import { useMDXComponents as getMDXComponents } from "../../mdx-components";

export const metadata: Metadata = {
  title: "Releases",
};

type Release = Readonly<{
  name: string | null;
  tag_name: string;
  html_url: string;
  published_at: string;
  body: string | null;
  draft: boolean;
}>;

const INTRO = `# Releases

\`styled-ppx\` versioning works like semver but without major releases. The
major version is always 0, like \`0.x.x\`. Each minor version can contain
breaking changes.

The full release history also lives on
[GitHub](https://github.com/davesnx/styled-ppx/releases) and in the
repository as
[\`CHANGES.md\`](https://github.com/davesnx/styled-ppx/blob/main/CHANGES.md).`;

async function fetchAllReleases(): Promise<Release[] | null> {
  const headers: Record<string, string> = {
    Accept: "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28",
  };
  const token = process.env.GITHUB_TOKEN;
  if (token) {
    headers.Authorization = `Bearer ${token}`;
  }

  const releases: Release[] = [];
  for (let page = 1; ; page += 1) {
    const response = await fetch(
      `https://api.github.com/repos/davesnx/styled-ppx/releases?per_page=100&page=${page}`,
      { headers, next: { revalidate: 3600 } },
    );
    if (!response.ok) {
      console.error(
        `Failed to fetch styled-ppx releases (page ${page}): ${response.status} ${response.statusText}`,
      );
      return null;
    }
    const batch: Release[] = await response.json();
    releases.push(...batch.filter((release) => !release.draft));
    if (batch.length < 100) {
      return releases;
    }
  }
}

function releaseToMarkdown(release: Release): string {
  const title = release.name || release.tag_name;
  const publishedAt = new Date(release.published_at).toDateString();
  const body = (release.body ?? "")
    .replaceAll("\r\n", "\n")
    .replace(/^CHANGES:\s*\n/, "")
    .trim();
  return `# [${title}](${release.html_url})

_Published on ${publishedAt}_

${body}`;
}

export default async function ReleasesPage() {
  const releases = await fetchAllReleases();
  const markdown = [
    INTRO,
    ...(releases ?? []).map((release) => releaseToMarkdown(release)),
  ].join("\n\n");

  const rawJs = await compileMdx(markdown, {
    filePath: "app/releases/page.tsx",
    mdxOptions: {
      format: "md",
      remarkPlugins: [remarkNormalizeHeadings],
      rehypePrettyCodeOptions,
    },
  });

  const components = getMDXComponents();
  const { default: MDXContent, toc } = evaluate(rawJs, components);
  const Wrapper = components.wrapper!;

  return (
    <Wrapper toc={toc} metadata={{ title: "Releases" }}>
      <MDXContent />
    </Wrapper>
  );
}
