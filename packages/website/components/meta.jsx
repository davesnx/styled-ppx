import React from "react";
import { Head as NextHead } from "next/document";

const Head = (props) => {
  const url = "https://styled-ppx.vercel.app";
  const title = props.title || "Typed styled components in ReScript";
  const prefix = `${url}  |  Documentation`;
  const description = props.description
    ? `${prefix} · ${props.description}`
    : prefix;
  const logo = `${url}/meta-img-logo.png`;
  const background = "F2F2F2";
  const color = "333333";
  const metaImg = `https://api.metaimg.net/v1/render?design=simple&image=${logo}&title=${title}&description=${description}&align=left&backgroundColor=${background}&textColor=${color}`;

  return (
    <NextHead>
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
    </NextHead>
  );
};

export default Head;
