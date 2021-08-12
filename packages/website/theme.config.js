import DocSearch from 'components/docsearch';

const short = 'CSS-in-Reason, OCaml and ReScript';
const description =
  'styled-ppx is a ppx that allows you to write typed styled components in Reason, OCaml and ReScript';

export default {
  github: 'https://github.com/davesnx/styled-ppx',
  siteGithub: 'https://github.com/davesnx/styled-ppx',
  titleSuffix: '- styled-ppx',
  customSearch: <DocSearch />,
  logo: <span className="font-mono hidden md:inline">styled-ppx</span>,
  head: (
    <>
      {/* Favicons, meta */}
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
      <meta name="msapplication-TileColor" content="#ffffff" />
      <meta name="theme-color" content="#ffffff" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta httpEquiv="Content-Language" content="en" />
      <meta name="description" content={description} />
      <meta name="og:description" content={description} />
      <meta name="twitter:card" content="summary_large_image" />
      <meta name="twitter:site" content="@davesnx" />
      <meta
        name="twitter:image"
        content="https://assets.vercel.com/image/upload/v1572282926/swr/twitter-card.jpg"
      />
      <meta name="og:title" content={short} />
      <meta name="og:url" content="https://styled-ppx.vercel.app/" />
      <meta
        name="og:image"
        content="https://assets.vercel.com/image/upload/v1572282926/swr/twitter-card.jpg"
      />
      <meta name="apple-mobile-web-app-title" content="SWR" />
      <link
        rel="stylesheet"
        href="https://cdn.jsdelivr.net/npm/docsearch.js@2/dist/cdn/docsearch.min.css"
        media="print"
        onLoad="this.media='all'"
      />
    </>
  ),
  footerText: `MIT ${new Date().getFullYear()} © David Sancho`,
};
