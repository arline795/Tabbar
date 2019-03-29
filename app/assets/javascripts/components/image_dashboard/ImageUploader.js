import InfiniteScroll from 'react-infinite-scroller';
import TaddarVisionService from '../services/TaddarVisionService';
import Loader from '../shared/Loader'
import RoiSelect from '../image_uploader/RoiSelect';

export default class ImageUploader extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      parentCategories: [],
      products: [],
      page: 1,
      hasMore: false,
      isLoadingProducts: false,
      isLoadingMoreProducts: false,
      uploadingImage: false,
      isResults: null,
      croppedProducts: [],
      imageOfInterest: "",
      concepts: [],
      gender: null,
    };

    this.fetchImageOfInterest()
  }

  componentWillMount() {
    this.taddarVisionService = new TaddarVisionService;
  }

  fetchImageOfInterest() {
    const { uuid, auth_token } = this.props;

    fetch(`/api/v1/image_of_interests/${uuid}`, {
      method: 'GET',
      headers: {
        'X-auth-token': auth_token
      }
    })
      .then((response) => {
        response.json()
          .then((imageOfinterest) => {
            this.setState({
              imageOfInterest: imageOfinterest,
              croppedProducts: imageOfinterest.detected_products,
            });
          });
      })
  }

  productList() {
    const { products, hasMore, isLoadingProducts, isLoadingMoreProducts, isResults } = this.state;
    const cols = [[], []];

    products.map((product, index) => {
      cols[index % 2].push(product);
    });

    if (!isLoadingProducts && isResults) {
      return(
        <InfiniteScroll
          hasMore={hasMore && !isLoadingMoreProducts}
          loadMore={this.loadMore}
          pageStart={1}
          loader={<div className="loader">isLoadingProducts ...</div>}
          className="flex flex-wrap justify-between masonry"
          style={{marginTop: '20px'}}
          useWindow
        >
          { cols.map((col, index) =>
            <div className="c1in2 flex flex-column" key={index}>
              {col.map((product) =>
                <div key={product.uuid} uuid={`product-${product.uuid}`}>
                  <div className='card square flex flex-column px1'>
                    <a href={product.redirect_url} target="_blank">
                      <div className='card-image-container relative'>
                        <div className='card-image'>
                          <img src={product.image_url}/>
                        </div>
                        <div className='card-hover'>
                          <div className='card-title h40 center-align relative'>
                            <div className='absolute w100 bottom-0'>{product.title}</div>
                          </div>
                          <div className='card-price h20 center-align relative'>
                            <div className='absolute w100 vertical-middle bold'>{product.price} {product.currency_code}</div>
                          </div>
                        </div>
                      </div>
                    </a>
                  </div>
                  <div className="pl1 pb4">
                    <div className="font-small left-align truncate">
                      {product.title}
                    </div>
                    <div className="font-base bold left-align">
                      {product.price} {product.currency_code}
                    </div>
                    <div className="font-small left-align">
                      <a href={`/${product.user.username}`}>
                        Sold by: {product.user.username}
                      </a>
                    </div>
                  </div>
                </div>
              )}
            </div>
          )}
        </InfiniteScroll>
      )
    } else if (isResults === false) {
      return(
        <div className="flex justify-center text-grey-xdark mt12">
          <p>No results</p>
        </div>
      )
    }
  }
  
  onRoiSelected = (crop) => {
    const { auth_token } = this.props;
    const { imageOfInterest } = this.state;
    
    const formData = new FormData();
    formData.append('cropped_product[crop_x]', crop.x);
    formData.append('cropped_product[crop_y]', crop.y);
    formData.append('cropped_product[crop_w]', crop.width);
    formData.append('cropped_product[crop_h]', crop.height);
    formData.append('image_of_interest_uuid', imageOfInterest.uuid);
    
    this.setState({ isLoadingProducts: true})

    fetch(`/api/v1/cropped_products`, {
      method: 'POST',
      body: formData,
      headers: {
        'X-auth-token': auth_token,
      }
    })
      .then(response => {
        response.json()
          .then(json => {
            this.similarProducts(json.image_url)
          });
      });
  }

  similarProducts = async (cropped_product_url) => {
    const { auth_token } = this.props;
    
    const similarProducts = await this.taddarVisionService.similarProducts(
      auth_token,
      cropped_product_url,
      'womens',
      '[womens]dresses',
    )

    if (similarProducts.length >= 1) {
      this.setState({
        products: similarProducts,
        isLoadingProducts: false,
        isLoadingMoreProducts: false,
        isResults: similarProducts.length === 0 ? false : true,
      })
    } else {
      this.setState({
        isLoadingProducts: false,
      });
    }
  }

  render() {
    const { imageOfInterest, isLoadingProducts } = this.state;
    
    return (
      <div>
        {
          imageOfInterest.length != "" && <div>
            { 
              <RoiSelect 
                imageUrl={imageOfInterest.image_url}
                onCrop={this.onRoiSelected}
              />
            }
          </div>
        }
        {
          <div>
            {
              isLoadingProducts && <div className="pt1">
                <Loader />
              </div>
            }
            <div className="flex mt4">
              <div className="flex flex-column">
                <div className="">
                  { this.productList() }
                </div>
              </div>
            </div>
          </div>
        }
      </div>
    );
  }
}
