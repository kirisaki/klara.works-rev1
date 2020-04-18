import { useEffect } from 'react'
import { useLocation } from 'react-router-dom'

declare global {
  interface Window {
    gtag: any
  }
}

export const usePage = (title?: string) => {
  const location = useLocation()
  useEffect(() => {
    document.title = title === undefined ? 'Klara Works' : 'Klara Works - ' + title
    window.gtag(
      'config',
      'UA-163141650-1',
      {page_path: location.pathname},
    )
  })
}

