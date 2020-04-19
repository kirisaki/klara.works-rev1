import React, {} from 'react'

import style from './Works.css'
import { usePage } from '../hooks/page'

export const Works: React.FC = () => {
  usePage('Works')
  return (
    <article className={style.about}>
      <section>
      </section>
    </article>
  )
}

export default Works


