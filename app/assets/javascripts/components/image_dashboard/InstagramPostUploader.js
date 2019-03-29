import React, { Component } from 'react';
import ImageOfInterestService from '../services/ImageOfInterestService';
import FetchInstagramPost from '../services/FetchInstagramPost';
import Loader from '../shared/Loader'

export default class InstagramPostUploader extends Component {
  static propTypes = {
    auth_token: PropTypes.string,
  }

  constructor(props) {
    super(props);

    this.state = {
      instagramPostUrl: "",
      isLoading: false,
    }

    this.createImageOfInterest = new ImageOfInterestService()
    this.fetchInstagramPost = new FetchInstagramPost()
  }

  handleInputChange = async () => {
    this.setState({
      instagramPostUrl: this.refs.inputValue.value,
      isLoading: true,
    })

    const { auth_token } = this.props;
    const params = {
      instagram_post_url: this.refs.inputValue.value
    }

    const response = await this.fetchInstagramPost.index(params, auth_token)
    this.instagramPostDetails(response)    
  }

  async instagramPostDetails(response) {
    const { auth_token } = this.props;
    const params = {
      image_of_interest: {
        image: response.image_url
      }
    }

    const res = await this.createImageOfInterest.create(params, auth_token)
    this.setState({
      isLoading: false,
    }, location.reload())
  }

  render() {
    const { instagramPostUrl, isLoading } = this.state;

    if (isLoading) {
      return(
        <div className="pt4">
          <Loader />
        </div>
      )
    } else {
      return (
        <div className="flex items-center relative">
          <input
            className="bg-white center-align w100"
            id="instagram_post"
            placeholder="Copy past instagram post url"
            type="text"
            value={instagramPostUrl}
            ref="inputValue"
            onChange={this.handleInputChange} 
          />
        </div>
      )
    }
  }
}
