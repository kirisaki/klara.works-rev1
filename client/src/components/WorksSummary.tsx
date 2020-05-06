import React, { useEffect, useState } from 'react'

import style from './WorksSummary.css'
import { Work } from '../types'
import {Link} from 'react-router-dom'

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
      <Link to={`/works/${work.id}`} className={style.summary}>
        <picture className={style.thumbnail}>
          <source media="(max-width: 480px)" srcSet={thumbPort} sizes="100vw" />
          <img src={thumbLand} />
        </picture>
        <p>
            {date}<br />
            {work.meta.title}
        </p>
      </Link>
  )
}

export default WorksSummary



