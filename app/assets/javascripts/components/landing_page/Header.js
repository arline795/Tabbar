import React, { Component } from 'react'
import { BrowserRouter as Router, Link } from "react-router-dom"
import logo from '../../../images/';

export default class Header extends Component {
    render() {
        return (
            <Router>
                <div className="header wi-100">
                    <div className="container">
                        <div className="row">
                            <div className="col-12">
                                <div className="logo wi-100">
                                    <Link to="/">
                                        <img src={logo} alt="logo" />
                                    </Link>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </Router>
        )
    }
}
