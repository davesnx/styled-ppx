import type { FC, ReactNode } from 'react'
import type { NavBarProps } from './components/navbar'
import type { TOCProps } from './components/toc'

type I18nEntry = {
  direction?: 'ltr' | 'rtl'
  locale: string
  name: string
}

export type ThemeOptions = {
  light: string
  dark: string
  system: string
}

type PerScheme = { dark: number; light: number }

export type DocsThemeConfig = {
  banner: {
    content?: ReactNode | FC
    dismissible: boolean
    key: string
  }
  backgroundColor: {
    dark: string
    light: string
  }
  chat: {
    icon: ReactNode | FC
    link?: string
  }
  components?: Record<string, FC>
  darkMode: boolean
  direction: 'ltr' | 'rtl'
  docsRepositoryBase: string
  editLink: {
    component: FC<{
      children: ReactNode
      className?: string
      filePath?: string
    }> | null
    content: ReactNode | FC
  }
  faviconGlyph?: string
  feedback: {
    content: ReactNode | FC
    labels: string
    useLink: () => string
  }
  footer: {
    component: ReactNode | FC<{ menu: boolean }>
    content: ReactNode | FC
  }
  gitTimestamp: ReactNode | FC<{ timestamp: Date }>
  head: ReactNode | FC
  i18n: I18nEntry[]
  logo: ReactNode | FC
  logoLink: boolean | string
  main?: FC<{ children: ReactNode }>
  navbar: {
    component: ReactNode | FC<NavBarProps>
    extraContent?: ReactNode | FC
  }
  navigation:
    | boolean
    | {
        next: boolean
        prev: boolean
      }
  nextThemes: {
    defaultTheme: string
    forcedTheme?: string
    storageKey: string
  }
  notFound: {
    content: ReactNode | FC
    labels: string
  }
  color: {
    hue: number | PerScheme
    saturation: number | PerScheme
    lightness: number | PerScheme
  }
  project: {
    icon: ReactNode | FC
    link?: string
  }
  search: {
    component: ReactNode | FC<{ className?: string }>
    emptyResult: ReactNode | FC
    error: string | (() => string)
    loading: ReactNode | FC
    // Can't be React component
    placeholder: string | (() => string)
  }
  sidebar: {
    autoCollapse?: boolean
    defaultMenuCollapseLevel: number
    toggleButton: boolean
  }
  themeSwitch: {
    component: ReactNode | FC<{ lite?: boolean; className?: string }>
    useOptions: ThemeOptions | (() => ThemeOptions)
  }
  toc: {
    backToTop: ReactNode | FC
    component: ReactNode | FC<TOCProps>
    extraContent: ReactNode | FC
    float: boolean
    title: ReactNode | FC
  }
}

type DeepPartial<T> = T extends (...args: never[]) => unknown
  ? T
  : T extends readonly unknown[]
    ? T
    : T extends object
      ? { [K in keyof T]?: DeepPartial<T[K]> }
      : T

export type PartialDocsThemeConfig = DeepPartial<DocsThemeConfig> & {
  // keep `locale` and `name` as required properties of each entry
  i18n?: I18nEntry[]
}
