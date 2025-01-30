import NextHead from 'next/head'
import { useMounted } from 'nextra/hooks'
import type { ReactElement } from 'react'
import { useThemeConfig } from '../contexts'
import { useTheme } from 'next-themes'

export function Head(props): ReactElement {
  const { resolvedTheme } = useTheme()
  const mounted = useMounted()
  const themeConfig = useThemeConfig()
  const { hue, saturation, lightness } = themeConfig.color
  const { dark: darkHue, light: lightHue } =
    typeof hue === 'number' ? { dark: hue, light: hue } : hue
  const { dark: darkSaturation, light: lightSaturation } =
    typeof saturation === 'number'
      ? { dark: saturation, light: saturation }
      : saturation
  const { dark: darkLightness, light: lightLightness } =
    typeof lightness === 'number'
      ? { dark: lightness, light: lightness }
      : lightness

  const bgColor = themeConfig.backgroundColor

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
      {themeConfig.faviconGlyph ? (
        <link
          rel="icon"
          href={`data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 100 100'><text x='50' y='.9em' font-size='90' text-anchor='middle'>${themeConfig.faviconGlyph}</text><style>text{font-family:system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,"Noto Sans",sans-serif,"Apple Color Emoji","Segoe UI Emoji","Segoe UI Symbol","Noto Color Emoji";fill:black}@media(prefers-color-scheme:dark){text{fill:white}}</style></svg>`}
        />
      ) : null}
      {mounted ? (
        <meta
          name="theme-color"
          content={resolvedTheme === 'dark' ? '#111' : '#fff'}
        />
      ) : (
        <>
          <meta
            name="theme-color"
            content="#fff"
            media="(prefers-color-scheme: light)"
          />
          <meta
            name="theme-color"
            content="#111"
            media="(prefers-color-scheme: dark)"
          />
        </>
      )}
      <meta
        name="viewport"
        content="width=device-width, initial-scale=1.0, viewport-fit=cover"
      />
      <style>{`:root{--nextra-primary-hue:${lightHue}deg;--nextra-primary-saturation:${lightSaturation}%;--nextra-primary-lightness:${lightLightness}%;--nextra-navbar-height:74px;--nextra-menu-height:3.75rem;--nextra-banner-height:2.5rem;--nextra-bg:${bgColor.light};}.dark{--nextra-primary-hue:${darkHue}deg;--nextra-primary-saturation:${darkSaturation}%;--nextra-primary-lightness:${darkLightness}%;--nextra-bg:${bgColor.dark};}`}</style>
      <meta name="description" content={description} />
      <meta httpEquiv="Content-Language" content="en" />
      <meta name="msapplication-TileColor" content="#ffffff" />
      <meta name="theme-color" content="#ffffff" />
      <meta name="viewport" content="width=device-width, initial-scale=1.0" />
      <meta name="og:title" content={title} />
      <meta name="og:description" content={description} />
      <meta name="og:image" content={metaImg} />
      <meta name="og:image:height" content="630" />
      <meta name="og:image:width" content="1200" />
      <meta name="twitter:card" content={metaImg} />
      <meta name="twitter:site" content={url} />
      <meta name="twitter:image" content={metaImg} />
      <meta name="og:title" content={title} />
      <meta name="og:url" content={url} />
      <meta name="apple-mobile-web-app-title" content={title} />
    </NextHead>
  )
}
