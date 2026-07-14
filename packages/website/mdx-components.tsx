import type { MDXComponents } from "nextra/mdx-components";
import { useMDXComponents as getNextraComponents } from "nextra/mdx-components";
import {
  Blockquote,
  Code,
  Details,
  H1,
  H2,
  H3,
  H4,
  H5,
  H6,
  Hr,
  Li,
  Link,
  Ol,
  P,
  Pre,
  Summary,
  Td,
  Th,
  ThemedTable,
  Tr,
  Ul,
  Wrapper,
} from "./src/mdx-components";

const themeComponents = {
  h1: H1,
  h2: H2,
  h3: H3,
  h4: H4,
  h5: H5,
  h6: H6,
  ul: Ul,
  ol: Ol,
  li: Li,
  blockquote: Blockquote,
  hr: Hr,
  a: Link,
  table: ThemedTable,
  p: P,
  tr: Tr,
  th: Th,
  td: Td,
  details: Details,
  summary: Summary,
  pre: Pre,
  code: Code,
  wrapper: Wrapper,
};

export function useMDXComponents(components?: MDXComponents): MDXComponents {
  return {
    ...getNextraComponents(),
    ...themeComponents,
    ...components,
  };
}
