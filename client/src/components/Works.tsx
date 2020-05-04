import React, { useEffect, useState } from 'react'

import style from './Works.css'
import { usePage } from '../hooks/page'
import { req } from '../lib/req'
import { Work } from '../types'
import WorksSummary from './WorksSummary'

export const Works: React.FC = () => {
  usePage('Works')
  const [works, setWorks] = useState<Work[]>([])
  useEffect(() => {
    const f = async () => {
      const result = await req<Work[]>('/api/v0/works/jpn')
      setWorks(result)
    }
    f()
  }, [])
  return (
    <article className={style.works}>
      {works.map(work => <WorksSummary work={work} />)}
    </article>
  )
}

export default Works


