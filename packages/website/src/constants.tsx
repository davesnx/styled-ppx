import { useRouter } from 'nextra/hooks'
import cn from 'clsx'
import { DiscordIcon, GitHubIcon } from 'nextra/icons'
import { isValidElement } from 'react'
import type { z } from 'zod'
import { Anchor } from './components/anchor'
import { Flexsearch } from './components/flexsearch'
import { Footer } from './components/footer'
import { Navbar } from './components/navbar'
import { ThemeSwitch } from './components/theme-switch'
import { TOC } from './components/toc'
import type { publicThemeSchema, themeSchema } from './schemas'
import { getGitIssueUrl, useGitEditUrl } from './utils'
import { useConfig } from './contexts/config'
import { useLanguage } from './utils/use-language'

export const DEFAULT_LOCALE = 'en-US'

export type DocsThemeConfig = z.infer<typeof themeSchema>
export type PartialDocsThemeConfig = z.infer<typeof publicThemeSchema>

let Logo = () => {
  return (
    <svg
      width="140"
      height="40"
      viewBox="0 0 152 35"
      xmlns="http://www.w3.org/2000/svg"
      className="logo"
    >
      <path
        fill="currentColor"
        d="M7.868 27.476C5.684 27.476 3.976 27.028 2.744 26.132C1.512 25.236 0.858667 23.976 0.784 22.352H4.76C4.83467 22.8373 5.124 23.276 5.628 23.668C6.15067 24.0413 6.92533 24.228 7.952 24.228C8.736 24.228 9.38 24.0973 9.884 23.836C10.4067 23.556 10.668 23.164 10.668 22.66C10.668 22.212 10.472 21.8573 10.08 21.596C9.688 21.316 8.988 21.12 7.98 21.008L6.776 20.896C4.928 20.7093 3.53733 20.196 2.604 19.356C1.68933 18.516 1.232 17.4427 1.232 16.136C1.232 15.0533 1.50267 14.148 2.044 13.42C2.58533 12.692 3.332 12.1413 4.284 11.768C5.25467 11.3947 6.356 11.208 7.588 11.208C9.56667 11.208 11.1627 11.6467 12.376 12.524C13.5893 13.3827 14.224 14.6333 14.28 16.276H10.304C10.2293 15.772 9.968 15.352 9.52 15.016C9.072 14.6613 8.40933 14.484 7.532 14.484C6.84133 14.484 6.29067 14.6147 5.88 14.876C5.46933 15.1373 5.264 15.492 5.264 15.94C5.264 16.3693 5.44133 16.696 5.796 16.92C6.15067 17.144 6.72933 17.3027 7.532 17.396L8.736 17.508C10.6213 17.7133 12.0867 18.236 13.132 19.076C14.1773 19.916 14.7 21.0453 14.7 22.464C14.7 23.4907 14.42 24.3867 13.86 25.152C13.3 25.8987 12.5067 26.4773 11.48 26.888C10.4533 27.28 9.24933 27.476 7.868 27.476ZM24.5746 27.196C23.0253 27.196 21.7746 27.0093 20.8226 26.636C19.8706 26.244 19.1706 25.6 18.7226 24.704C18.2933 23.7893 18.0786 22.5573 18.0786 21.008V7.512H22.2506V21.176C22.2506 21.904 22.4373 22.464 22.8106 22.856C23.2026 23.2293 23.7533 23.416 24.4626 23.416H26.7306V27.196H24.5746ZM15.7546 14.932V11.656H26.7306V14.932H15.7546ZM29.5752 33.076V29.268H32.7672C33.2526 29.268 33.6632 29.2027 33.9992 29.072C34.3352 28.96 34.6059 28.764 34.8112 28.484C35.0166 28.204 35.1846 27.8213 35.3152 27.336L39.0952 11.656H43.3512L39.0672 28.232C38.7686 29.4267 38.3486 30.3787 37.8072 31.088C37.2846 31.7973 36.5752 32.3013 35.6792 32.6C34.8019 32.9173 33.6819 33.076 32.3192 33.076H29.5752ZM34.3912 26.664V23.164H37.6392V26.664H34.3912ZM32.5432 26.664L27.8392 11.656H32.3472L36.7992 26.664H32.5432ZM45.908 27V6.56H50.416V27H45.908ZM44.088 9.864V6.56H50.416V9.864H44.088ZM61.572 27.532C60.2653 27.532 59.108 27.308 58.1 26.86C57.1107 26.412 56.28 25.8147 55.608 25.068C54.9547 24.3027 54.4507 23.4533 54.096 22.52C53.76 21.568 53.592 20.5973 53.592 19.608V19.048C53.592 18.0213 53.76 17.0413 54.096 16.108C54.4507 15.156 54.9547 14.3067 55.608 13.56C56.2613 12.8133 57.0733 12.2253 58.044 11.796C59.0333 11.348 60.1533 11.124 61.404 11.124C63.0467 11.124 64.428 11.4973 65.548 12.244C66.6867 12.972 67.5547 13.9333 68.152 15.128C68.7493 16.304 69.048 17.592 69.048 18.992V20.504H55.468V17.956H66.332L64.876 19.132C64.876 18.2173 64.7453 17.4333 64.484 16.78C64.2227 16.1267 63.8307 15.632 63.308 15.296C62.804 14.9413 62.1693 14.764 61.404 14.764C60.62 14.764 59.9573 14.9413 59.416 15.296C58.8747 15.6507 58.464 16.1733 58.184 16.864C57.904 17.536 57.764 18.3667 57.764 19.356C57.764 20.2707 57.8947 21.0733 58.156 21.764C58.4173 22.436 58.828 22.9587 59.388 23.332C59.948 23.7053 60.676 23.892 61.572 23.892C62.3933 23.892 63.0653 23.7333 63.588 23.416C64.1107 23.0987 64.4653 22.7067 64.652 22.24H68.768C68.544 23.2667 68.1053 24.1813 67.452 24.984C66.7987 25.7867 65.9773 26.412 64.988 26.86C63.9987 27.308 62.86 27.532 61.572 27.532ZM78.3447 27.504C77.262 27.504 76.2727 27.308 75.3767 26.916C74.4993 26.524 73.734 25.9827 73.0807 25.292C72.4273 24.5827 71.9233 23.752 71.5687 22.8C71.2327 21.848 71.0647 20.8213 71.0647 19.72V19.076C71.0647 17.9747 71.2233 16.948 71.5407 15.996C71.8767 15.044 72.3527 14.2133 72.9687 13.504C73.6033 12.776 74.3593 12.216 75.2367 11.824C76.114 11.4133 77.094 11.208 78.1767 11.208C79.4087 11.208 80.4727 11.4787 81.3687 12.02C82.2647 12.5427 82.9647 13.3267 83.4687 14.372C83.9727 15.3987 84.2527 16.668 84.3087 18.18L83.1327 17.088V6.56H87.6407V27H84.0847V20.644H84.7007C84.6447 22.1 84.3367 23.3413 83.7767 24.368C83.2353 25.3947 82.498 26.1787 81.5647 26.72C80.6313 27.2427 79.558 27.504 78.3447 27.504ZM79.4647 23.752C80.1553 23.752 80.7807 23.6027 81.3407 23.304C81.9193 22.9867 82.3767 22.5293 82.7127 21.932C83.0673 21.3347 83.2447 20.616 83.2447 19.776V18.74C83.2447 17.9187 83.0673 17.228 82.7127 16.668C82.358 16.108 81.8913 15.6787 81.3127 15.38C80.734 15.0813 80.1087 14.932 79.4367 14.932C78.69 14.932 78.018 15.128 77.4207 15.52C76.842 15.8933 76.3847 16.416 76.0487 17.088C75.7127 17.7413 75.5447 18.5067 75.5447 19.384C75.5447 20.28 75.7127 21.0547 76.0487 21.708C76.3847 22.3613 76.8513 22.8653 77.4487 23.22C78.046 23.5747 78.718 23.752 79.4647 23.752ZM90.1882 24.456V22.752H95.2402V24.456H90.1882ZM97.8096 32.6V11.656H101.366V18.292L100.89 18.264C100.964 16.7333 101.282 15.4453 101.842 14.4C102.402 13.336 103.158 12.5427 104.11 12.02C105.062 11.4787 106.135 11.208 107.33 11.208C108.394 11.208 109.355 11.404 110.214 11.796C111.091 12.188 111.838 12.7387 112.454 13.448C113.088 14.1387 113.564 14.96 113.882 15.912C114.218 16.8453 114.386 17.872 114.386 18.992V19.636C114.386 20.7373 114.227 21.7733 113.91 22.744C113.592 23.696 113.126 24.5267 112.51 25.236C111.912 25.9453 111.175 26.5053 110.298 26.916C109.439 27.308 108.45 27.504 107.33 27.504C106.172 27.504 105.127 27.2707 104.194 26.804C103.279 26.3187 102.542 25.5907 101.982 24.62C101.422 23.6307 101.114 22.38 101.058 20.868L102.29 22.548V32.6H97.8096ZM106.07 23.752C106.835 23.752 107.498 23.5653 108.058 23.192C108.636 22.8187 109.084 22.296 109.402 21.624C109.719 20.952 109.878 20.1773 109.878 19.3C109.878 18.4227 109.719 17.6573 109.402 17.004C109.084 16.3507 108.646 15.8467 108.086 15.492C107.526 15.1187 106.854 14.932 106.07 14.932C105.398 14.932 104.763 15.0907 104.166 15.408C103.568 15.7253 103.083 16.1827 102.71 16.78C102.355 17.3587 102.178 18.068 102.178 18.908V19.944C102.178 20.7467 102.364 21.4373 102.738 22.016C103.13 22.576 103.624 23.0053 104.222 23.304C104.819 23.6027 105.435 23.752 106.07 23.752ZM117.497 32.6V11.656H121.053V18.292L120.577 18.264C120.652 16.7333 120.969 15.4453 121.529 14.4C122.089 13.336 122.845 12.5427 123.797 12.02C124.749 11.4787 125.822 11.208 127.017 11.208C128.081 11.208 129.042 11.404 129.901 11.796C130.778 12.188 131.525 12.7387 132.141 13.448C132.776 14.1387 133.252 14.96 133.569 15.912C133.905 16.8453 134.073 17.872 134.073 18.992V19.636C134.073 20.7373 133.914 21.7733 133.597 22.744C133.28 23.696 132.813 24.5267 132.197 25.236C131.6 25.9453 130.862 26.5053 129.985 26.916C129.126 27.308 128.137 27.504 127.017 27.504C125.86 27.504 124.814 27.2707 123.881 26.804C122.966 26.3187 122.229 25.5907 121.669 24.62C121.109 23.6307 120.801 22.38 120.745 20.868L121.977 22.548V32.6H117.497ZM125.757 23.752C126.522 23.752 127.185 23.5653 127.745 23.192C128.324 22.8187 128.772 22.296 129.089 21.624C129.406 20.952 129.565 20.1773 129.565 19.3C129.565 18.4227 129.406 17.6573 129.089 17.004C128.772 16.3507 128.333 15.8467 127.773 15.492C127.213 15.1187 126.541 14.932 125.757 14.932C125.085 14.932 124.45 15.0907 123.853 15.408C123.256 15.7253 122.77 16.1827 122.397 16.78C122.042 17.3587 121.865 18.068 121.865 18.908V19.944C121.865 20.7467 122.052 21.4373 122.425 22.016C122.817 22.576 123.312 23.0053 123.909 23.304C124.506 23.6027 125.122 23.752 125.757 23.752ZM135.094 27L139.854 18.768L139.742 19.468L135.262 11.656H140.106L142.878 16.864H143.326L145.93 11.656H150.494L146.21 19.524L146.322 18.936L151.362 27H146.49L143.186 21.428H142.738L139.63 27H135.094Z"
      />
    </svg>
  );
};

export const DEFAULT_THEME: DocsThemeConfig = {
  backgroundColor: {
    dark: '17,17,17',
    light: '250,250,250'
  },
  banner: {
    dismissible: true,
    key: 'nextra-banner'
  },
  main: ({ children }) => {
    const { frontMatter } = useConfig();
    const { language } = useLanguage();

    return (
      <div
        className={cn(
          `syntax__${language}`,
          frontMatter.showAllLanguage && "show-all-language"
        )}
      >
        {children}
      </div>
    );
  },
  chat: {
    icon: (
      <>
        <DiscordIcon />
        <span className="_sr-only">Discord</span>
      </>
    )
  },
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
  direction: 'ltr',
  docsRepositoryBase:
    "https://github.com/davesnx/styled-ppx/tree/main/packages/website",
  editLink: {
    component: function EditLink({ className, filePath, children }) {
      const editUrl = useGitEditUrl(filePath)
      if (!editUrl) {
        return null
      }
      return (
        <Anchor className={className} href={editUrl}>
          {children}
        </Anchor>
      )
    },
    content: 'Edit this page'
  },
  feedback: {
    content: 'Question? Give us feedback →',
    labels: 'feedback',
    useLink() {
      return getGitIssueUrl({
        labels: 'label',
        repository: 'https://github.com/shuding/nextra',
        title: `Feedback for “styled-ppx”`
      })
    }
  },
  footer: {
    component: Footer,
  },
  gitTimestamp: function GitTimestamp({ timestamp }) {
    const { locale = DEFAULT_LOCALE } = useRouter()
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
  head: () => null,
  /* head: function Head() {
    const { frontMatter, title: pageTitle } = useConfig()

    const title = `${pageTitle} – Nextra`
    const { description, canonical, image } = frontMatter
    return (
      <>
        <title>{title}</title>
        <meta property="og:title" content={title} />
        {description && [
          <meta key={0} name="description" content={description} />,
          <meta key={1} property="og:description" content={description} />
        ]}
        {canonical && <link rel="canonical" href={canonical} />}
        {image && <meta name="og:image" content={image} />}
      </>
    )
  }, */
  i18n: [],
  logo: Logo,
  logoLink: true,
  navbar: {
    component: Navbar
  },
  navigation: true,
  nextThemes: {
    defaultTheme: 'system',
    storageKey: 'theme'
  },
  notFound: {
    content: 'Submit an issue about broken link →',
    labels: 'bug'
  },
  project: {
    link: "https://github.com/davesnx/styled-ppx",
    icon: (
      <>
        <GitHubIcon />
        <span className="_sr-only">GitHub</span>
      </>
    )
  },
  search: {
    component: Flexsearch,
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
    toggleButton: true,
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

export const DEEP_OBJECT_KEYS = Object.entries(DEFAULT_THEME)
  .map(([key, value]) => {
    const isObject =
      value &&
      typeof value === 'object' &&
      !Array.isArray(value) &&
      !isValidElement(value)
    if (isObject) {
      return key
    }
  })
  .filter(Boolean)
