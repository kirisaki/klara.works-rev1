import React, {} from 'react'
import {
  TransitionGroup,
  CSSTransition
} from 'react-transition-group'
import {
  useLocation,
  Switch,
  Route,
} from 'react-router-dom'

import Nav from './Nav'
import Home from './Home'
import About from './About'

import style from './App.css'

export const App: React.FC = () => {
  const location = useLocation()
  return (
    <>
      <div className={style.container}>
        <TransitionGroup>
          {}
          <CSSTransition key={location.key} classNames="fade" timeout={300}>
            <Switch location={location}>
              <Route path="/" exact>
                <Home />
              </Route>
              <Route path="/about">
                <About />
              </Route>
            </Switch>
          </CSSTransition>
        </TransitionGroup>
      </div>
      <Nav />
    </>
  )
}
