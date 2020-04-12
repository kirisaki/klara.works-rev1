import React, {} from 'react'
import { Link } from 'react-router-dom'

import style from './Nav.css'


const Nav: React.FC = () => {
  return (
    <nav className={style.nav}>
      <ul>
        <li>
          <Link to="/">home</Link>
        </li>
        <li>
          <Link to="/about">about</Link>
        </li>
      </ul>
    </nav>
  )
}

export default Nav
