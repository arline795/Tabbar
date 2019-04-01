import React, { Component } from 'react'
import { BrowserRouter as Router, Link } from "react-router-dom"
import playStore from '../assets/img/googleplay.png'
import appStore from '../assets/img/appstore.png'
import fb from '../assets/img/fb.png'
import mobile from '../assets/img/mobile.png'
import instagram from '../assets/img/instagram.png'
import mail from '../assets/img/mail.png'

export default class Body extends Component {
    render() {
        return (
            <Router>
                <div className="banner wi-100">
                    <div className="container">
                        <div className="row">
                            <div className="col-lg-6 col-md-12 col-sm-12 col-12">
                                <div className="banner-text wi-100">
                                    <div className="title">
                                        <h1 className="montserrat f-50 font-weight-bold">Shop Your Screenshots</h1>
                                    </div>
                                    <div className="description">
                                        <p className="nunito-sans">Upload or use an @taddar_app comment on any Instagram image and Taddar will give you a collection of similar fashion items from big name brands.</p>
                                    </div>
                                    <div className="instabtn">
                                        <Link to="/" className="instaText">Signup with Instagram</Link>
                                    </div>
                                    <div className="agree">
                                        <p className="mb-0">By continuing, you agree to Taddars's <Link to="/" className="conditions"><b>Terms of Service</b></Link>, and <Link to="/" className="conditions"><b>Privacy Policy</b></Link></p>
                                        <p>Already using Taddar? <Link to="/" className="signin">Sign in</Link></p>
                                    </div>
                                    <div className="badges">
                                        <Link to="/">
                                            <img src={appStore} alt="app store" />
                                        </Link>
                                        <Link to="/">
                                            <img src={playStore} alt="play store" />
                                        </Link>
                                    </div>
                                    <div className="social">
                                        <Link to="/"><img className="spacing" src={fb} alt="facebook" /></Link>
                                        <Link to="/"><img className="spacing" src={instagram} alt="instagram" /></Link>
                                        <Link to="/"><img src={mail} alt="mail" /></Link>
                                    </div>
                                </div>
                            </div>
                            <div className="col-lg-6 col-md-12 col-sm-12 col-12 nopadding">
                                <div className="screen text-lg-right text-md-center text-sm-center wi-100">
                                    <img className= "shadow" src={mobile} alt="mobile" />
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </Router>
        )
    }
}
