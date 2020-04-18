import * as React from "react"
import * as ReactDOM from "react-dom"
import { BrowserRouter } from 'react-router-dom'
import { App } from "./components/App"

import './style.css'
import './klaraworks.svg'
import './back.svg'
import './favicon.ico'

import './about-react.svg'
import './about-haskell.svg'
import './about-k8s.svg'

ReactDOM.render(
    <BrowserRouter>
      <App/>
    </BrowserRouter>,
    document.getElementById("app")
)
