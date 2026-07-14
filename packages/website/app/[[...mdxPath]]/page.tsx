import { notFound } from "next/navigation";
import { generateStaticParamsFor, importPage } from "nextra/pages";
import { useMDXComponents as getMDXComponents } from "../../mdx-components";

export const generateStaticParams = generateStaticParamsFor("mdxPath");

type PageProps = Readonly<{
  params: Promise<{ mdxPath?: string[] }>;
}>;

async function loadPage(mdxPath?: string[]) {
  try {
    return await importPage(mdxPath);
  } catch {
    notFound();
  }
}

export async function generateMetadata({ params }: PageProps) {
  const { mdxPath } = await params;
  const { metadata } = await loadPage(mdxPath);
  return metadata;
}

const Wrapper = getMDXComponents().wrapper!;

export default async function Page({ params }: PageProps) {
  const { mdxPath } = await params;
  const {
    default: MDXContent,
    toc,
    metadata,
    sourceCode,
  } = await loadPage(mdxPath);
  return (
    <Wrapper toc={toc} metadata={metadata} sourceCode={sourceCode}>
      <MDXContent params={params} />
    </Wrapper>
  );
}
