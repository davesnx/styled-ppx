import { DiscordIcon, GitHubIcon } from 'nextra/icons'
import { PagefindSearch } from './components/pagefind-search'
import { ThemeSwitch } from './components/theme-switch'
import { TOC } from './components/toc'
import { getGitIssueUrl } from './git-url'
import type { DocsThemeConfig } from './schemas'

export const DEFAULT_LOCALE = 'en-US'

export type { DocsThemeConfig, PartialDocsThemeConfig } from './schemas'

export const repoLink = 'https://github.com/davesnx/styled-ppx';

export const DEFAULT_THEME: DocsThemeConfig = {
  color: {
    hue: {
      dark: 204,
      light: 212
    },
    lightness: {
      dark: 55,
      light: 45
    },
    saturation: 100
  },
  darkMode: true,
  backgroundColor: {
    dark: '17,17,17',
    light: '250,250,250'
  },
  banner: {
    dismissible: true,
    key: 'nextra-banner'
  },
  chat: {
    icon: (
      <>
        {/* nextra v4 icons ship without intrinsic dimensions */}
        <DiscordIcon height="24" />
        <span className="_sr-only">Discord</span>
      </>
    )
  },
  direction: 'ltr',
  docsRepositoryBase: repoLink + "/tree/main/packages/website",
  feedback: {
    content: 'Question? Give us feedback →',
    labels: 'feedback',
    useLink() {
      return getGitIssueUrl({
        labels: 'feedback',
        repository: repoLink,
        title: `Feedback for “styled-ppx”`
      })
    }
  },
  gitTimestamp: function GitTimestamp({ timestamp }) {
    const locale = DEFAULT_LOCALE
    return (
      <>
        Last updated on{' '}
        <time dateTime={timestamp.toISOString()}>
          {timestamp.toLocaleDateString(locale, {
            day: 'numeric',
            month: 'long',
            year: 'numeric'
          })}
        </time>
      </>
    )
  },
  i18n: [],
  notFound: {
    content: 'Submit an issue about broken link →',
    labels: 'bug'
  },
  project: {
    link: repoLink,
    icon: (
      <>
        {/* nextra v4 icons ship without intrinsic dimensions */}
        <GitHubIcon height="24" />
        <span className="_sr-only">GitHub</span>
      </>
    )
  },
  search: {
    component: PagefindSearch,
    emptyResult: (
      <span className="_block _select-none _p-8 _text-center _text-sm _text-gray-400">
        No results found.
      </span>
    ),
    error: 'Failed to load search index.',
    loading: 'Loading…',
    placeholder: 'Search documentation…'
  },
  sidebar: {
    defaultMenuCollapseLevel: 2,
  },
  themeSwitch: {
    component: ThemeSwitch,
    useOptions: { dark: 'Dark', light: 'Light', system: 'System' }
  },
  toc: {
    backToTop: 'Scroll to top',
    component: TOC,
    float: true,
    title: 'On This Page'
  }
}
