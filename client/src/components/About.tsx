import React, {} from 'react'

import style from './About.css'
import { usePage } from '../hooks/page'

export const About: React.FC = () => {
  usePage('About')
  return (
    <article className={style.about}>
      <section>
        <h1>
          About
        </h1>
        <p>
          このサイトは同人サークル「Klara Works（クラーラ・ワークス）」および霧咲空人（きりさきあきひと）の個人ポートフォリオサイトです。
          過去作品の掲載や情報発信行っていく予定です。また、Web技術試行の場ともなっております。
        </p>
      </section>
      <section>
        <h1>
          Technology stack of this site
        </h1>
        <p>
          <img src="/assets/about-react.svg" className={style.react} />
          React + TypeScript
        </p>
        <p>
          <img src="/assets/about-haskell.svg" />
          Haskell
        </p>
        <p>
          <img src="/assets/about-k8s.svg" />
          Kubernetes + Google Cloud Platform
        </p>
      </section>
    </article>
  )
}

export default About

