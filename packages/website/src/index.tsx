import { ThemeProvider } from 'next-themes'
import type { NextraThemeLayoutProps } from 'nextra'
import { useRouter } from 'nextra/hooks'
import { MDXProvider } from 'nextra/mdx'
import type { ReactElement, ReactNode } from 'react'
import { Banner } from './components/banner'
import { Head } from './components/head'

import {
  ActiveAnchorProvider,
  ConfigProvider,
  useConfig,
  useThemeConfig
} from './contexts'
import { getComponents } from './mdx-components'
import { renderComponent } from './utils'

function InnerLayout({ children }: { children: ReactNode }): ReactElement {
  const themeConfig = useThemeConfig()
  const config = useConfig()
  const { locale, title, description } = useRouter()

  const { direction } =
    themeConfig.i18n.find(l => l.locale === locale) || themeConfig
  const dir = direction === 'rtl' ? 'rtl' : 'ltr'

  const { activeThemeContext: themeContext, topLevelNavbarItems } =
    config.normalizePagesResult

  const components = getComponents({
    isRawLayout: themeContext.layout === 'raw',
    components: themeConfig.components
  })

  return (
    <ThemeProvider
      attribute="class"
      disableTransitionOnChange
      {...themeConfig.nextThemes}
    >
      <div dir={dir}>
        <Head title={title} description={description} />
        <Banner />
        {themeContext.navbar &&
          renderComponent(themeConfig.navbar.component, {
            items: topLevelNavbarItems
          })}
        <ActiveAnchorProvider>
          <MDXProvider disableParentContext components={components}>
            {children}
          </MDXProvider>
        </ActiveAnchorProvider>
        {themeContext.footer &&
          renderComponent(themeConfig.footer.component, {
            menu: config.hideSidebar
          })}
      </div>
    </ThemeProvider>
  )
}

export default function Layout({
  children,
  pageOpts
}: NextraThemeLayoutProps): ReactElement {
  return (
    <ConfigProvider value={pageOpts}>
      <InnerLayout>{children}</InnerLayout>
    </ConfigProvider>
  )
}