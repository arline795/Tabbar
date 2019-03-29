import React, { Component } from 'react';
import Dropzone from 'react-dropzone';
import { PulseLoader } from 'react-spinners';
import ImageOfInterestService from '../services/ImageOfInterestService';

export default class ImageDashboardUploader extends Component {
  static propTypes = {
    auth_token: PropTypes.string,
  }

  constructor(props) {
    super(props);

    this.state = {
      isLoading: false,
    };

    this.imageOfInterestService = new ImageOfInterestService()
  }

  onDrop = async (acceptedFiles) => {
    const { auth_token } = this.props
    const formData = new FormData();
    formData.append('image_of_interest[image]', acceptedFiles[0]);
    this.setState({isLoading: true})

    fetch('/api/v1/image_of_interests', {
      method: 'POST',
      body: formData,
      headers: {
        'X-auth-token': auth_token,
      }
    })
      .then((response) => {
        response.json()
          .then((json) => {
            const { id, url } = json;
            this.setState({
              id,
              url,
              isLoading: false,
            }, location.reload());
          });
      })
  }

  render() {
    const { isLoading } = this.state;

    return (
      isLoading ? <div className="pt8 center-align">
        <p>Uploading image</p>
        <PulseLoader
          color={'#000000'}
          loading={true}
        />
      </div> : <div>
        <Dropzone
          onDrop={this.onDrop}
          style={{
            width: '100%',
            background: 'white',
            cursor: 'pointer',
            border: '1px grey',
          }}
        >
          <div className="flex-column h100 pt8 pb5 center-align">
            <div className="justify-center">
              <i className="block upload-icon fa fa-3x fa-file-image-o"/>
              <h4 className="bold pt4">Drag an image here</h4>
            </div>
          </div>
        </Dropzone>
      </div>
    )
  }
}
