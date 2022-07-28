import "../fonts.css";
import "../tailwind.css";
import "nextra-theme-docs/style.css";
import "../overrides.css";
import Head from 'next/head'

/* Remove Prism, and prism-react-render after update Nextra to v2,
in favor of shiki and next.config.js commented code */
import Prism from "prism-react-renderer/prism";
(typeof global !== "undefined" ? global : window).Prism = Prism;
require("prismjs/components/prism-rescript");
require("prismjs/components/prism-diff");

export default function Nextra({ Component, pageProps }) {
  const url = "https://styled-ppx.vercel.app";
  const title = pageProps.title || "Typed styled components in ReScript";
  const prefix = `${url}  |  Documentation`;
  const description = pageProps.description
    ? `${prefix} · ${pageProps.description}`
    : prefix;
  const logo = `${url}/meta-img-logo.png`;
  const background = "F2F2F2";
  const color = "333333";
  const metaImg = `https://api.metaimg.net/v1/render?design=simple&image=${logo}&title=${title}&description=${description}&align=left&backgroundColor=${background}&textColor=${color}`;

  return (
  <>
    <Head>
      <title>{"wat"}</title>
      <meta httpEquiv="Content-Language" content="en" />
      <meta name="msapplication-TileColor" content="#ffffff" />
      <meta name="theme-color" content="#ffffff" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta name="og:title" content={title} />
      <meta name="og:description" content={description} />
      <meta name="og:image" content={metaImg} />
      <meta name="og:image:height" content="630" />
      <meta name="og:image:width" content="1200" />
      <meta name="description" content={description} />
      <meta name="twitter:card" content={metaImg} />
      <meta name="twitter:site" content={url} />
      <meta name="twitter:image" content={metaImg} />
      <meta name="og:title" content={title} />
      <meta name="og:url" content={url} />
      <meta name="apple-mobile-web-app-title" content={title} />
    </Head>
    <Component {...pageProps} />
  </>
  );
}
