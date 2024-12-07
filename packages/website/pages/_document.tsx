import { Html, Head, Main, NextScript } from 'next/document'

export default function Document() {
  const url = 'https://styled-ppx.vercel.app'

  return (
    <Html lang="en">
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
          href={`${url}/favicon/apple-touch-icon.png`}
        />
        <link
          rel="icon"
          type="image/png"
          sizes="32x32"
          href={`${url}/favicon/favicon-32x32.png`}
        />
        <link
          rel="icon"
          type="image/png"
          sizes="16x16"
          href={`${url}/favicon/favicon-16x16.png`}
        />
        <link rel="manifest" href={`${url}/favicon/site.webmanifest`} />
        <link
          rel="mask-icon"
          href={`${url}/favicon/safari-pinned-tab.svg`}
          color="#000000"
        />
        <script async={true} src="https://cdn.splitbee.io/sb.js"></script>
      </Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  )
}
