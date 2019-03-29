import React, { Component } from 'react';
import { PropTypes } from 'prop-types';

export default class Navbar extends Component {
  static propTypes = {
    setMenCategory: PropTypes.func.isRequired,
    setWomenCategory: PropTypes.func.isRequired,
    hasMenCategory: PropTypes.bool.isRequired,
    hasWomenCategory: PropTypes.bool.isRequired,
  }

  contructor() {
    this.state = {
      menActive: false,
      womenActive: false,
    }
  }

  componentWillMount() {
    this.setActiveButton()
  }

  setActiveButton() {
    const { hasMenCategory, hasWomenCategory } = this.props

    if (hasMenCategory && hasWomenCategory) {
      this.setState({womenActive: true})
    } else if (hasWomenCategory) {
      this.setState({womenActive: true})
    } else {
      this.setState({menActive: true})
    }
  }

  underlineWomen() {
    const { womenActive } = this.state
    if (womenActive) { return 'underline-text bold'}
  }

  underlineMen() {
    const { menActive } = this.state
    if (menActive) { return 'underline-text bold'}
  }

  womenButton() {
    const { hasWomenCategory, setWomenCategory  } = this.props

    return(
      hasWomenCategory &&
      <div className={`py2 mr5 ${this.underlineWomen()}`}>
        <div
          onClick={() => this.setState({menActive: false, womenActive: true}, setWomenCategory)}
        >
          Women
        </div>
      </div>
    )
  }

  menButton() {
    const { hasMenCategory, setMenCategory  } = this.props

    return(
      hasMenCategory &&
      <div className={`py2 mr5 ${this.underlineMen()}`}>
        <div
          onClick={() => this.setState({menActive: true, womenActive: false}, setMenCategory)}
        >
          Men
        </div>
      </div>
    )
  }

  render() {
    return (
      <div className="border-grey-light border-bottom-solid">
        <div className="container flex">
          { this.womenButton() }
          { this.menButton() }
        </div>
      </div>
    );
  }
}
