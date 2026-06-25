import { useTheme } from "next-themes";
import { useEffect, useState } from "react";
import type { ReactElement } from "react";
import { useThemeConfig } from "../contexts";

export function Head(): ReactElement {
  const { resolvedTheme } = useTheme();
  const [mounted, setMounted] = useState(false);
  const themeConfig = useThemeConfig();
  const { hue, saturation, lightness } = themeConfig.color;

  const { dark: darkHue, light: lightHue } =
    typeof hue === "number" ? { dark: hue, light: hue } : hue;
  const { dark: darkSaturation, light: lightSaturation } =
    typeof saturation === "number"
      ? { dark: saturation, light: saturation }
      : saturation;
  const { dark: darkLightness, light: lightLightness } =
    typeof lightness === "number"
      ? { dark: lightness, light: lightness }
      : lightness;

  const bgColor = themeConfig.backgroundColor;

  useEffect(() => {
    setMounted(true);
  }, []);

  return (
    <>
      {mounted ? (
        <meta
          name="theme-color"
          content={resolvedTheme === "dark" ? "#111" : "#fff"}
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
      <style>{`:root{--nextra-primary-hue:${lightHue}deg;--nextra-primary-saturation:${lightSaturation}%;--nextra-primary-lightness:${lightLightness}%;--nextra-navbar-height:74px;--nextra-menu-height:3.75rem;--nextra-banner-height:2.5rem;--nextra-bg:${bgColor.light};}.dark{--nextra-primary-hue:${darkHue}deg;--nextra-primary-saturation:${darkSaturation}%;--nextra-primary-lightness:${darkLightness}%;--nextra-bg:${bgColor.dark};}`}</style>
    </>
  );
}
