import { generateStaticParamsFor, importPage } from "nextra/pages";

export const generateStaticParams = generateStaticParamsFor("mdxPath");

type PageProps = Readonly<{
  params: Promise<{ mdxPath?: string[] }>;
}>;

export async function generateMetadata({ params }: PageProps) {
  const { mdxPath } = await params;
  const { metadata } = await importPage(mdxPath);
  return metadata;
}

export default async function Page({ params }: PageProps) {
  const { mdxPath } = await params;
  const { default: MDXContent } = await importPage(mdxPath);
  return <MDXContent params={params} />;
}
