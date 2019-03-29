import InfiniteScroll from 'react-infinite-scroller';
import { fetch2 } from '../services/fetch2';
import ImageOfInterestService from '../services/ImageOfInterestService';

export default class ImageOfInterestList extends React.Component {
  static propTypes = {
    auth_token: PropTypes.string,
  }

  constructor(props) {
    super(props);

    this.state = {
      image_of_interests: [],
      page: 1,
      hasMore: false,
      isLoading: false,
      isLoadingMoreProducts: false,
    };

    this.imageOfInterestService = new ImageOfInterestService()
    this.load()
  }

  load = async () => {
    const { auth_token } = this.props;
    const { page } = this.state;
    
    const response = await this.imageOfInterestService.index(page, auth_token)

    this.setState({
      image_of_interests: response.length === 0 ? [] : response,
      hasMore: response.has_more,
      isLoading: false,
      isLoadingMoreProducts: false,
      isResults: response.length === 0 ? false : true,
    });
  }

  loadMore = () => {
    if (this.state.image_of_interests.length > 0) {
      this.setState({ page: this.state.page + 1, isLoadingMoreProducts: true }, this.load);
    }
  }

  destroy = (imageOfInterest) => {
    const { image_of_interests } = this.state;
    const { auth_token } = this.props;

    fetch(`/api/v1/image_of_interests/${imageOfInterest.uuid}`, {
      method: 'DELETE',
      headers: {
        'X-auth-token': auth_token
      }
    })
      .then((response) => {
        response.json()
          .then((json) => {
            this.setState({
              image_of_interests: image_of_interests.filter(ioi => ioi.uuid !== json.uuid)
            });
          });
      })
  }

  render() {
    const { image_of_interests, hasMore, isLoading, isLoadingMoreProducts, isResults } = this.state;
    const cols = [[], [], []];

    image_of_interests.map((image_of_interest, index) => {
      cols[index % 3].push(image_of_interest);
    });

    return(
      <InfiniteScroll
        hasMore={hasMore && !isLoadingMoreProducts}
        loadMore={this.loadMore}
        pageStart={1}
        loader={<div className="loader">isLoading ...</div>}
        className="flex flex-wrap justify-between masonry pt2"
        style={{marginTop: '20px'}}
        useWindow
      >
        {cols.map((col, index) =>
          <div className="c1in3 flex flex-column" key={index}>
            {col.map((image_of_interest) =>
              <div className='card square flex flex-column px1 pb1'>
                <p className="pointer" onClick={() => this.destroy(image_of_interest)}>Delete</p>
                <a href={`/similar_products?uuid=${image_of_interest.uuid}`}>
                  <div className='card-image-container relative'>
                    <div className='card-image'>
                      <img className='image-of-interest' src={image_of_interest.image_url}/>
                    </div>
                  </div>
                </a>
                <div className="flex">
                  { image_of_interest.detected_products.map(detected_product =>
                      <img className="fit pr1" src={detected_product.thumb_url}/>
                    )
                  }
                </div>
              </div>
            )}
          </div>
        )}
      </InfiniteScroll>
    )
  }
}
