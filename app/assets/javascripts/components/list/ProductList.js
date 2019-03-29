import InfiniteScroll from 'react-infinite-scroller';
import { fetch2 } from '../services/fetch2';

export default class ProductList extends React.Component {
  static propTypes = {
    query: PropTypes.string,
  }

  constructor(props) {
    super(props);

    this.state = {
      products: [],
      page: 1,
      hasMore: false,
      loading: false
    };

    this.loadMore = this.loadMore.bind(this);
    this.loadProducts = this.loadProducts.bind(this);
    this.reloadProducts = this.reloadProducts.bind(this);
  }

  componentDidMount() {
    this.reloadProducts();
  }

  reloadProducts() {
    this.setState({
      loading: true,
      products: [],
      page: 1
    }, this.loadProducts);
  }

  loadProducts() {
    const { query } = this.props;
    const { products, page, categoryId } = this.state;

    fetch2('/api/v1/search/products', { queryParams: { page, query } })
      .then((response) => {
        if (response.status === 200) {
          response.json().then((data) => {
            this.setState({
              products: products.concat(data),
              hasMore: data.has_more,
              loading: false
            });
          });
        }
      });
  }

  loadMore() {
    if (this.state.products.length > 0) {
      this.setState({ page: this.state.page + 1, loading: true }, this.loadProducts);
    }
  }

  render() {
    const { query } = this.props;
    const { products, hasMore, loading } = this.state;
    const cols = [[], [], []];

    products.map((product, index) => {
      cols[index % 3].push(product);
    });

    return (
      <div className="container">
        <div className="font-large-normal py4">
          Search / {query}
        </div>
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
                <div className='py4 px2' key={product.id} id={`product-${product.id}`}>
                  <div className='card square flex flex-column'>
                    <a href={product.redirect_url}>
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
                    <div className="card-footer p0">
                      <div className="font-small right-align truncate">
                        {product.title}
                      </div>
                      <div className="font-small bold right-align">
                        {product.price} {product.currency_code}
                      </div>
                    </div>
                  </div>
                </div>
              )}
            </div>
          )}
        </InfiniteScroll>
      </div>
    );
  }
}
