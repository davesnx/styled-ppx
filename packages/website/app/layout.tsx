import type { Metadata, Viewport } from "next";
import type { FC, ReactNode } from "react";
import { getPageMap } from "nextra/page-map";
import { Layout } from "../src/index";
import "../src/css/fonts.css";
import "../src/css/global.css";

export const viewport: Viewport = {
  themeColor: [
    { media: "(prefers-color-scheme: light)", color: "#fff" },
    { media: "(prefers-color-scheme: dark)", color: "#111" },
  ],
};

export const metadata: Metadata = {
  title: {
    absolute: "styled-ppx",
    template: "%s | styled-ppx",
  },
  description: "Typed styled components in ReScript, Melange and OCaml",
};

const RootLayout: FC<{ children: ReactNode }> = async ({ children }) => {
  const pageMap = await getPageMap();
  // `dir` is required: the theme's ltr:/rtl: Tailwind variants compile to
  // `[dir="ltr"] &` selectors, which never match without it.
  return (
    <html lang="en" dir="ltr" suppressHydrationWarning>
      <head>
        <link
          rel="apple-touch-icon"
          sizes="180x180"
          href="/favicon/apple-touch-icon.png"
        />
        <link
          rel="icon"
          type="image/png"
          sizes="32x32"
          href="/favicon/favicon-32x32.png"
        />
        <link
          rel="icon"
          type="image/png"
          sizes="16x16"
          href="/favicon/favicon-16x16.png"
        />
        <link rel="manifest" href="/favicon/site.webmanifest" />
        <link
          rel="mask-icon"
          href="/favicon/safari-pinned-tab.svg"
          color="#000000"
        />
        <link
          href="https://fonts.googleapis.com/css2?family=Archivo&display=swap"
          rel="stylesheet"
        />
        <link
          href="https://fonts.googleapis.com/css2?family=Archivo+Black&display=swap"
          rel="stylesheet"
        />
      </head>
      <body suppressHydrationWarning>
        <Layout pageMap={pageMap}>{children}</Layout>
      </body>
    </html>
  );
};

export default RootLayout;
