import React from "react";
import NextDocument, { Html, Main, Head, NextScript } from "next/document";
import { SkipNavLink } from "@reach/skip-nav";
import Meta from "../components/meta";

class Document extends NextDocument {
  render() {
    return (
      <Html lang="en">
        <Head>
          <link
            href="https://fonts.googleapis.com/css2?family=Archivo&display=swap"
            rel="stylesheet"
          />
          <link
            href="https://fonts.googleapis.com/css2?family=Archivo+Black&display=swap"
            rel="stylesheet"
          />
        </Head>
        <Meta />
        <body>
          <SkipNavLink />
          <Main />
          <NextScript />
          <script
            src="https://cdn.jsdelivr.net/npm/docsearch.js@2/dist/cdn/docsearch.min.js"
            async
            defer
          />
        </body>
      </Html>
    );
  }
}

export default Document;
