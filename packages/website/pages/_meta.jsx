import React from 'react';
import { Head as NextHead } from 'next/document';

const Head = (props) => {
  const title = props.title || "Typed styled components in ReScript";
  const description = props.description || "Documentation";
  const logo = "https://raw.githubusercontent.com/davesnx/styled-ppx/main/docs/images/logo.png";
  const metaImg = `https://api.metaimg.net/render?design=simple&image=${logo}&title=${title}&description=${description}&align=left&backgroundColor=FFFFFF&textColor=000000`;

  return (
    <NextHead>
      <title>{title}</title>
      <meta name="og:title" content={title} />
      <meta name="og:description" content={description} />
      <meta name="og:image" content={metaImg} />
      <meta name="description" content={description} />
      <meta name="twitter:card" content={metaImg} />
      <meta name="twitter:site" content={title} />
      <meta
        name="twitter:image"
        content={metaImg}
      />
      <meta name="og:title" content={title} />
      <meta name="og:url" content="https://styled-ppx.vercel.app/" />
      <meta name="apple-mobile-web-app-title" content={title} />
    </NextHead>
  );
}

export default Head
