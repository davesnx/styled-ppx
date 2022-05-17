import React from 'react';
import { Head as NextHead } from 'next/document';

const Head = (props) => {
  const title = props.title || "Typed styled components in ReScript";
  const prefix = "https://styled-ppx.vercel.app  |  Documentation";
  const description = props.description ? `${prefix} · ${props.description}` : prefix;
  const logo = "https://styled-ppx-git-improve-meta-image-davesnx.vercel.app/meta-img-logo.png";
  const background = "F2F2F2";
  const color = "333333";
  /* const logo = "https://styled-ppx.vercel.app/meta-img-logo.png"; */
  const metaImg = `https://api.metaimg.net/render?design=simple&image=${logo}&title=${title}&description=${description}&align=left&backgroundColor=${background}&textColor=${color}`;

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
