"use client";

import { ThemeProvider } from "next-themes";
import type { PageMapItem } from "nextra";
import { normalizePages } from "nextra/normalize-pages";
import { usePathname } from "next/navigation";
import type { ReactElement, ReactNode } from "react";
import { Banner } from "./components/banner";
import { Footer } from "./components/footer";
import { Navbar } from "./components/navbar";
import { ActiveAnchorProvider, ConfigProvider } from "./contexts";
import { getComponents } from "./mdx-components";

type LayoutProps = {
  pageMap: PageMapItem[];
  children: ReactNode;
};

function InnerLayout({ children, pageMap }: LayoutProps): ReactElement {
  const pathname = usePathname() ?? "/";
  const normalizePagesResult = normalizePages({ list: pageMap, route: pathname });
  const { activeThemeContext: themeContext, topLevelNavbarItems } =
    normalizePagesResult;

  const components = getComponents({
    isRawLayout: themeContext.layout === "raw",
    components: {},
  });

  const hideSidebar =
    !themeContext.sidebar ||
    themeContext.layout === "raw" ||
    normalizePagesResult.activeType === "page";

  return (
    <ThemeProvider
      attribute="class"
      disableTransitionOnChange
      defaultTheme="system"
      storageKey="theme"
    >
      <div>
        <Banner />
        <Navbar items={topLevelNavbarItems} />
        <ActiveAnchorProvider>
          {children}
        </ActiveAnchorProvider>
        <Footer menu={hideSidebar} />
      </div>
    </ThemeProvider>
  );
}

export function Layout({ children, pageMap }: LayoutProps): ReactElement {
  return (
    <ConfigProvider pageMap={pageMap}>
      <InnerLayout pageMap={pageMap}>{children}</InnerLayout>
    </ConfigProvider>
  );
}
