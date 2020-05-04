import React, { useEffect, useState } from 'react'

import style from './WorksSummary.css'
import { Work } from '../types'

type Props = {
  work: Work,
}

export const WorksSummary: React.FC<Props> = ({ work }) => {
  const thumb = '/assets/thumbnails/' + work.id + '.jpg'
  return (
      <div className={style.summary}><img src={thumb} /></div>
  )
}

export default WorksSummary



