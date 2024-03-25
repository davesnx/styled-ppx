import "../fonts.css";
import "../tailwind.css";
import "nextra-theme-docs/style.css";
import "../overrides.css";
import { useLanguage } from "../utils/use-language";

import Head from "next/head";

export default function Nextra({ Component, pageProps }) {
  const { language } = useLanguage();

  return (
    <>
      <Head>
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
      <main id="root" className={`syntax__${language}`}>
        <Component {...pageProps} />
      </main>
    </>
  );
}
