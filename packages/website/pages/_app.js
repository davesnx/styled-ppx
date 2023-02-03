import "../fonts.css";
import "../tailwind.css";
import "nextra-theme-docs/style.css";
import "../overrides.css";

import Head from "next/head";

export default function Nextra({ Component, pageProps }) {
  return (
    <>
      <Head>
        <link
          href="https://fonts.googleapis.com/css2?family=Archivo&display=swap"
          rel="stylesheet"
        />
        <link
          href="https://fonts.googleapis.com/css2?family=Archivo+Black&display=swap"
          rel="stylesheet"
        />
        <link
          rel="apple-touch-icon"
          sizes="180x180"
          href={`/favicon/apple-touch-icon.png`}
        />
        <link
          rel="icon"
          type="image/png"
          sizes="32x32"
          href={`/favicon/favicon-32x32.png`}
        />
        <link
          rel="icon"
          type="image/png"
          sizes="16x16"
          href={`/favicon/favicon-16x16.png`}
        />
        <link rel="manifest" href={`/favicon/site.webmanifest`} />
        <link
          rel="mask-icon"
          href={`/favicon/safari-pinned-tab.svg`}
          color="#000000"
        />
        <script async src="https://cdn.splitbee.io/sb.js"></script>
      </Head>
      <Component {...pageProps} />
    </>
  );
}
