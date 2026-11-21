import cn from 'clsx'
import type { ReactElement } from 'react'
import { useCallback, useDeferredValue, useEffect, useState } from 'react'
import type { SearchResult } from '../types'
import { Search } from './search'

type PagefindSubResult = {
  title: string
  url: string
  excerpt: string
}

type PagefindResultData = {
  meta: { title?: string }
  sub_results: PagefindSubResult[]
}

type Pagefind = {
  options: (options: { baseUrl: string }) => Promise<void>
  debouncedSearch: (
    query: string
  ) => Promise<{ results: { data: () => Promise<PagefindResultData> }[] } | null>
}

declare global {
  interface Window {
    pagefind?: Pagefind
  }
}

const DEV_SEARCH_NOTICE = (
  <>
    Search isn&rsquo;t available in development: Pagefind indexes the built
    `.html` files. Run `next build` (which runs Pagefind on `postbuild`) and
    restart the dev server or use `next start`.
  </>
)

let pagefindPromise: Promise<void> | undefined

function loadPagefind(): Promise<void> {
  pagefindPromise ??= (async () => {
    window.pagefind = (await import(
      /* webpackIgnore: true */
      // @ts-expect-error -- runtime asset produced by the postbuild script
      '/_pagefind/pagefind.js'
    )) as Pagefind
    await window.pagefind.options({ baseUrl: '/' })
  })()
  pagefindPromise.catch(() => {
    pagefindPromise = undefined
  })
  return pagefindPromise
}

function cleanUrl(url: string): string {
  return url.replace(/\.html$/, '').replace(/\.html#/, '#')
}

function toSearchResults(data: PagefindResultData[]): SearchResult[] {
  return data.flatMap((page, pageIndex) =>
    page.sub_results.map((subResult, subIndex) => ({
      id: `${pageIndex}_${subIndex}`,
      route: cleanUrl(subResult.url),
      prefix: subIndex === 0 && (
        <div
          className={cn(
            '_mx-2.5 _mb-2 [&:not(:first-child)]:_mt-6 _select-none _border-b _border-black/10 _px-2.5 _pb-1.5 _text-xs _font-semibold _uppercase _text-gray-500 dark:_border-white/20 dark:_text-gray-300',
            'contrast-more:_border-gray-600 contrast-more:_text-gray-900 contrast-more:dark:_border-gray-50 contrast-more:dark:_text-gray-50'
          )}
        >
          {page.meta.title}
        </div>
      ),
      children: (
        <>
          <div className="_text-base _font-semibold _leading-5">
            {subResult.title}
          </div>
          <div
            className={cn(
              'excerpt _mt-1 _text-sm _leading-[1.35rem] _text-gray-600 dark:_text-gray-400 contrast-more:dark:_text-gray-50',
              '[&_mark]:_bg-primary-600/80 [&_mark]:_text-white'
            )}
            dangerouslySetInnerHTML={{ __html: subResult.excerpt }}
          />
        </>
      )
    }))
  )
}

export function PagefindSearch({
  className
}: {
  className?: string
}): ReactElement {
  const [loading, setLoading] = useState(false)
  const [error, setError] = useState<ReactElement | string | false>(false)
  const [results, setResults] = useState<SearchResult[]>([])
  const [search, setSearch] = useState('')
  const deferredSearch = useDeferredValue(search)

  const preload = useCallback(async () => {
    if (window.pagefind) return
    setLoading(true)
    try {
      await loadPagefind()
      setError(false)
    } catch (err) {
      setError(
        err instanceof Error && err.message.includes('Failed to fetch')
          ? DEV_SEARCH_NOTICE
          : String(err)
      )
    }
    setLoading(false)
  }, [])

  useEffect(() => {
    let cancelled = false

    async function run() {
      if (!deferredSearch) {
        setResults([])
        return
      }
      await preload()
      if (cancelled || !window.pagefind) return
      const response = await window.pagefind.debouncedSearch(deferredSearch)
      if (!response || cancelled) return
      const data = await Promise.all(
        response.results.map(result => result.data())
      )
      if (cancelled) return
      setResults(toSearchResults(data))
    }

    run()
    return () => {
      cancelled = true
    }
  }, [deferredSearch, preload])

  return (
    <Search
      loading={loading}
      error={error}
      value={search}
      onChange={setSearch}
      onActive={preload}
      className={className}
      results={results}
    />
  )
}
