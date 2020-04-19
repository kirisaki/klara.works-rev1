import React, {} from 'react'
import {
  useLocation,
  Switch,
  Route,
} from 'react-router-dom'

import Nav from './Nav'
import Home from './Home'
import About from './About'
import Works from './Works'

import style from './App.css'

export const App: React.FC = () => {
  const location = useLocation()
  return (
    <>
      <div className={style.container}>
        <Switch location={location}>
          <Route path="/" exact>
            <Home />
          </Route>
          <Route path="/about">
            <About />
          </Route>
          <Route path="/works">
            <Works />
          </Route>
        </Switch>
      </div>
      <Nav />
    </>
  )
}
