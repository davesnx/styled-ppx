import { useMDXComponents as getNextraComponents } from "nextra/mdx-components";

export const useMDXComponents: typeof getNextraComponents = (components) => ({
  ...getNextraComponents({}),
  ...components,
});
