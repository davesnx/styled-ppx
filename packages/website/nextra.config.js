import DocSearch from 'components/docsearch';

const short = 'CSS-in-ReScript';
const description =
  'styled-ppx is the ppx that brings typed styled components to ReScript.';

export default {
  github: 'https://github.com/davesnx/styled-ppx',
  siteGithub: 'https://github.com/davesnx/styled-ppx',
  docsRepositoryBase: "https://github.com/davesnx/styled-ppx/tree/main/packages/website/pages",
  titleSuffix: '- styled-ppx',
  customSearch: () => null,
  logo: <span className="font-mono hidden md:inline font-semibold">styled-ppx</span>,
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
