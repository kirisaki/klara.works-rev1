import React, { useEffect, useState } from 'react'

import style from './WorksSummary.css'
import { Work } from '../types'

type Props = {
  work: Work,
}

export const WorksSummary: React.FC<Props> = ({ work }) => {
  const thumbLand = '/assets/thumbnails/' + work.id + '-land.jpg'
  const thumbPort = '/assets/thumbnails/' + work.id + '-port.jpg'
  return (
      <div className={style.summary}>
        <picture>
          <source media="(max-width: 480px)" srcSet={thumbPort} sizes="100vw" />
          <img src={thumbLand} />
        </picture>
      </div>
  )
}

export default WorksSummary



