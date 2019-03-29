export default class Media extends React.Component {
  static propTypes = {
    media: PropTypes.object
  }

  constructor(props) {
    super(props);
  }

  render() {
    const { media } = this.props;

    return (
      <div className="cell-item py3 rounded">
        <div className="card">
          <div className="card-image-container relative">
            <div className="card-image">
              <a href={`/similar_products?image_url=${media.media_img_path}`}>
                <img 
                  className="rounded"
                  src={media.media_img_path}
                />
              </a>
            </div>
          </div>
        </div>
      </div>
    );
  }
}
