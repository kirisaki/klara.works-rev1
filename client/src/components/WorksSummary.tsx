import React, { useEffect, useState } from 'react'

import style from './WorksSummary.css'
import { Work } from '../types'

type Props = {
  work: Work,
}

export const WorksSummary: React.FC<Props> = ({ work }) => {
  const thumbLand = '/assets/thumbnails/' + work.id + '-land.jpg'
  const thumbPort = '/assets/thumbnails/' + work.id + '-port.jpg'
  const year = work.id.substring(0, 4)
  const month= work.id.substring(4, 6)
  const day = work.id.substring(6, 8)
  const date = `${year}-${month}-${day}`
  return (
      <div className={style.summary}>
        <picture>
          <source media="(max-width: 480px)" srcSet={thumbPort} sizes="100vw" />
          <img src={thumbLand} />
        </picture>
        <p>
          {date}
        </p>
        <p>
          {work.meta.title}
        </p>
      </div>
  )
}

export default WorksSummary



