import { PropTypes } from 'prop-types';
import React, { Component } from 'react';
import Dropzone from 'react-dropzone';
import { PulseLoader } from 'react-spinners';

export default class Loader extends Component {
  render() {
    return(
      <div className='sweet-loading center-align'>
        <p>Powered by</p>
        <h3 className="typographica">taddar vision</h3>
        <PulseLoader
          color={'#000000'}
          loading={true}
        />
      </div>
    )
  }
}
