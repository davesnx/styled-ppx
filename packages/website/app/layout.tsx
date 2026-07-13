import type { Metadata } from "next";
import type { FC, ReactNode } from "react";
import { getPageMap } from "nextra/page-map";
import { Layout } from "../src/index";
import "../src/css/fonts.css";
import "../src/css/global.css";

export const metadata: Metadata = {
  title: {
    absolute: "styled-ppx",
    template: "%s | styled-ppx",
  },
  description: "Typed styled components in ReScript, Melange and OCaml",
};

const RootLayout: FC<{ children: ReactNode }> = async ({ children }) => {
  const pageMap = await getPageMap();
  return (
    <html lang="en" suppressHydrationWarning>
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
        <script async src="https://cdn.splitbee.io/sb.js" />
      </head>
      <body>
        <Layout pageMap={pageMap}>{children}</Layout>
      </body>
    </html>
  );
};

export default RootLayout;
