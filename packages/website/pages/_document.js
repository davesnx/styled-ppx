import React from 'react';
import NextDocument, { Html, Main, Head, NextScript } from 'next/document';
import { SkipNavLink } from '@reach/skip-nav';
import Meta from '../components/meta';

class Document extends NextDocument {
  render() {
    return (
      <Html lang="en">
        <Head>
          <link
            rel="preload"
            href="/fonts/SFMono/SFMono-Medium.ttf"
            as="font"
            crossOrigin=""
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
