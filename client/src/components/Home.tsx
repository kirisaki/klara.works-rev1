import React, {} from 'react'

import { usePage } from '../hooks/page'

import style from './Home.css'

export const Home: React.FC = () => {
  usePage()
  return (
    <article className={style.home}>
      <section className={style.section}>
        <h1 className={style.logo}>
          <span>Klara Works</span>
        </h1>
        <table>
          <tbody>
            <tr><td>name: </td>
            <td>
              <p>霧咲空人（きりさきあきひと）</p>
              <p>Akihito KIRISAKI</p>
            </td></tr>
            <tr><td>Twitter: </td><td><a href="https://twitter.com/A_kirisaki">https://twitter.com/A_kirisaki</a></td></tr>
            <tr><td>pixiv: </td><td><a href="https://pixiv.me/kirisaki">https://pixiv.me/kirisaki</a></td></tr>
            <tr><td>GitHub: </td><td><a href="https://github.com/kirisaki">https://github.com/kirisaki</a></td></tr>
            <tr><td>Facebook: </td><td><a href="https://www.facebook.com/akihito.kirisaki">https://www.facebook.com/akihito.kirisaki</a></td></tr>
            <tr><td>Instagram: </td><td><a href="https://www.instagram.com/akihito.kirisaki/">https://www.instagram.com/akihito.kirisaki/</a></td></tr>
          </tbody>
        </table>
      </section>
    </article>
  )
}

export default Home
