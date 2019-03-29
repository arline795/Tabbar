import { PropTypes } from 'prop-types';
import React, { Component } from 'react';
import ImageGallery from 'react-image-gallery';

export default class ImageSlider extends Component {
  static propTypes = {
    images: PropTypes.array,
  };

  constructor(props) {
    super(props)

    this.state = {
      images: [],
    };
  }

  componentDidMount() {
    this.images();
  }

  images() {
    const imageUrls = this.props.images.map(imageUrl =>
      !/^https?:\/\//i.test(imageUrl) ? 'https:' + imageUrl : imageUrl
    )

    this.setState({
      images: imageUrls.map((imageUrl) => {
        return { original: imageUrl, thumbnail: imageUrl };
      })
    });
  }

  render() {
    const { images } = this.state

    return (
      <div className="image-gallery app-image-gallery">
        <ImageGallery
          items={images}
          showFullscreenButton={false}
          showPlayButton={false}
          thumbnailPosition={'left'}
        />
      </div>
    );
  }
}
