import InfiniteScroll from 'react-infinite-scroller';
import Navbar from './Navbar'
import { fetch2 } from '../services/fetch2';

export default class Navigator extends React.Component {
  static propTypes = {
    user: PropTypes.object.isRequired,
    categoryId: PropTypes.object.isRequired,
    hasMenCategory: PropTypes.bool.isRequired,
    hasWomenCategory: PropTypes.bool.isRequired,
  }

  constructor(props) {
    super(props);

    this.state = {
      products: [],
      categories: [],
      page: 1,
      hasMore: false,
      loading: false,
      hierachy: [{ name: 'All' }],
      categoryId: props.categoryId,
    };

    this.loadMore = this.loadMore.bind(this);
    this.loadProductsAndCategories = this.loadProductsAndCategories.bind(this);
  }

  componentDidMount() {
    const categoryId = this.state.categoryId

    this.reload(categoryId);
  }

  reload(category) {
    this.setState({
      loading: true,
      products: [],
      categoryId: category.id,
      page: 1,
    }, this.loadProductsAndCategories);
  }

  loadProductsAndCategories() {
    const { user } = this.props;
    const { products, page, categoryId } = this.state;
    const productsUrl = categoryId ? `/${user.slug}/categories/${categoryId}/products` : `/${user.slug}`;

    fetch2(productsUrl, { queryParams: { page } })
      .then((response) => {
        if (response.status === 200) {
          response.json().then((data) => {
            this.setState({
              products: products.concat(data.products),
              hasMore: data.has_more,
              loading: false,
            });
          });
        }
      });

    fetch2(`/${user.slug}/categories.json`, { queryParams: { parent: categoryId } })
      .then((response) => {
        if (response.status === 200) {
          response.json().then((data) => {
            this.setState({ categories: data });
          });
        }
      });

    fetch2(`/${user.slug}/categories/hierachy.json`, { queryParams: { id: categoryId } })
      .then((response) => {
        if (response.status === 200) {
          response.json().then((data) => {
            this.setState({ hierachy: data });
          });
        }
      });
  }

  loadMore() {
    if (this.state.products.length > 0) {
      this.setState({ page: this.state.page + 1, loading: true }, this.loadProductsAndCategories);
    }
  }

  setWomenCategory = () => {
    const category = {'id': this.props.womensCategoryId }

    this.setState({
      categoryId: category.id,
    }, this.reload(category))
  }

  setMenCategory = () => {
    const category = {'id': this.props.mensCategoryId }

    this.setState({
      categoryId: category.id,
    }, this.reload(category))
  }

  render() {
    const { user, hasMenCategory, hasWomenCategory } = this.props;
    const { products, hasMore, loading, categories, hierachy, categoryId } = this.state;
    const cols = [[], [], []];
    
    products.map((product, index) => {
      cols[index % 3].push(product);
    });

    return (
      <div>
        <Navbar
          setMenCategory={this.setMenCategory}
          setWomenCategory={this.setWomenCategory}
          hasMenCategory={hasMenCategory}
          hasWomenCategory={hasWomenCategory}
        />
        
        <div className='container flex'>
          <div className='flex flex-column bg-white w25 border-grey-light'>
            <div className='flex py4'>
              {hierachy.map(category => (
                <div
                  className={`breadcrumb-item ${categoryId === category.id && 'active-category'}`}
                  key={category.id}
                >
                  <span onClick={this.reload.bind(this, category)}>
                    {category.capitalized_name}
                  </span>
                </div>
              ))}
            </div>
            {categories.map(category => (
              <div
                key={category.id}
                className={`py2 pr4 pointer flex justify-between ${categoryId === category.id && 'active-category'}`}
                onClick={this.reload.bind(this, category)}
              >
                <span>{category.capitalized_name}</span>
                <span>{category.products_count}</span>
              </div>
            ))}
          </div>

          <div className='w75 mt4 p0'>
            <InfiniteScroll
              hasMore={hasMore && !loading}
              loadMore={this.loadMore}
              pageStart={1}
              loader={<div className="loader">Loading ...</div>}
              className="flex flex-wrap justify-between masonry"
              useWindow
            >
              {cols.map((col, index) =>
                <div className="c1in3 flex flex-column" key={index}>
                  {col.map((product) =>
                    <div className='px2' key={product.uuid} id={`product-${product.uuid}`}>
                      <div className='card bg-white flex flex-column'>
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
                                <div className='absolute w100 vertical-middle bold'>{product.price}</div>
                              </div>
                            </div>
                          </div>
                        </a>
                        <div className='card-footer '>
                          <div className='font-smaller text-black mt1'>
                            {product.title}
                          </div>
                          <div className='font-small bold text-black mt1'>
                            {product.price} {product.currency_code}
                          </div>
                        </div>
                        <div className="flex">
                          { product.images.map(image =>
                              <img className="fit pr1" src={image.cropped_image_url}/>
                            )
                          }
                        </div>
                      </div>
                    </div>
                  )}
                </div>
              )}
            </InfiniteScroll>
          </div>
        </div>
      </div>
    );
  }
}
