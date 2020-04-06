import React, {} from 'react'
import {} from 'react'
import style from './App.css'

export const App: React.FC = () => {
  return (
    <div className={style.container}>
      <article>
        <h1>
          <span>Klara Works</span>
        </h1>
        <table>
          <tbody>
            <tr><td>name: </td><td>霧咲空人（きりさきあきひと） / Akihito KIRISAKI</td></tr>
            <tr><td>Twitter: </td><td><a href="https://twitter.com/A_kirisaki">https://twitter.com/A_kirisaki</a></td></tr>
            <tr><td>pixiv: </td><td><a href="https://pixiv.me/kirisaki">https://pixiv.me/kirisaki</a></td></tr>
            <tr><td>GitHub: </td><td><a href="https://github.com/kirisaki">https://github.com/kirisaki</a></td></tr>
          </tbody>
        </table>
      </article>
    </div>
  )
}
