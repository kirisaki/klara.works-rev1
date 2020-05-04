import React, {} from 'react'
import { Link, useRouteMatch } from 'react-router-dom'

import style from './NavLink.css'

type Props = {
  to: string
  children: string,
  exact?: boolean,
}

const NavLink: React.FC<Props> = ({to, children, exact}) => {
  const match = useRouteMatch({path: to, exact})
  return (
    <Link
      to={to}
      className={match ? [style.link, style.active].join(' ') : style.link}>
      {children}
    </Link>
  )
}

export default NavLink

