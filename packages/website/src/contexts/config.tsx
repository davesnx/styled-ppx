import { usePathname } from "next/navigation";
import type { PageMapItem } from "nextra";
import { normalizePages } from "nextra/normalize-pages";
import type { ReactElement, ReactNode } from "react";
import { createContext, useContext, useEffect, useMemo, useState } from "react";
import { MenuProvider } from "./menu";

type Config = {
  hideSidebar: boolean;
  normalizePagesResult: ReturnType<typeof normalizePages>;
};

const ConfigContext = createContext<Config>({
  hideSidebar: false,
  normalizePagesResult: {} as ReturnType<typeof normalizePages>,
});
ConfigContext.displayName = "Config";

export function useConfig() {
  return useContext(ConfigContext);
}

export function ConfigProvider({
  children,
  pageMap,
}: {
  children: ReactNode;
  pageMap: PageMapItem[];
}): ReactElement {
  const [menu, setMenu] = useState(false);
  const pathname = usePathname() ?? "/";

  const normalizePagesResult = useMemo(
    () => normalizePages({ list: pageMap, route: pathname }),
    [pageMap, pathname]
  );

  const { activeType, activeThemeContext: themeContext } = normalizePagesResult;

  const config: Config = {
    hideSidebar:
      !themeContext.sidebar ||
      themeContext.layout === "raw" ||
      activeType === "page",
    normalizePagesResult,
  };

  useEffect(() => {
    setMenu(false);
  }, [pathname]);

  useEffect(() => {
    document.body.classList.toggle("max-md:_overflow-hidden", menu);
  }, [menu]);

  useEffect(() => {
    let resizeTimer: number;

    function addResizingClass() {
      document.body.classList.add("resizing");
      clearTimeout(resizeTimer);
      resizeTimer = window.setTimeout(() => {
        document.body.classList.remove("resizing");
      }, 200);
    }

    window.addEventListener("resize", addResizingClass);
    return () => {
      window.removeEventListener("resize", addResizingClass);
    };
  }, []);

  const menuValue = useMemo(() => ({ menu, setMenu }), [menu]);

  return (
    <ConfigContext.Provider value={config}>
      <MenuProvider value={menuValue}>{children}</MenuProvider>
    </ConfigContext.Provider>
  );
}
