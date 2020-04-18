import React, {} from 'react'

import NavLink from './NavLink'
import style from './Nav.css'


const Nav: React.FC = () => {
  return (
    <nav className={style.nav}>
      <ul>
        <li>
          <NavLink to="/" exact>home</NavLink>
        </li>
        <li>
          <NavLink to="/about">about</NavLink>
        </li>
      </ul>
    </nav>
  )
}

export default Nav
