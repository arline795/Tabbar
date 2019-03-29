import { fetch2 } from '../services/fetch2';

export default class Search extends React.Component {
  constructor(props) {
    super(props);

    this.state = { query: '', productsCount: 0, usersCount: 0 };

    this.handleInputChange = this.handleInputChange.bind(this);
    this.reloadListsCount = this.reloadListsCount.bind(this);
  }

  handleInputChange() {
    this.setState({
      query: this.refs.inputValue.value,
    }, this.reloadListsCount);
  }

  reloadListsCount() {
    const { query } = this.state;

    fetch2('/api/v1/search', { queryParams: { query } })
      .then((response) => {
        if (response.status === 200 && this.state.query === query) {
          response.json().then((data) => {
            this.setState({
              productsCount: data.products_count,
              usersCount: data.users_count,
            });
          });
        }
      });
  }

  renderSuggestions() {
    const { query, productsCount, usersCount } = this.state;

    if (productsCount == 0 && usersCount == 0) {
      return '';
    }

    let productSection = '';
    let userSection = '';

    if (productsCount > 0) {
      productSection = (
        <a href={`/search/products?query=${query}`} className="block">
          <span className="bold">
            {productsCount}
          </span>
          <span> products found</span>
        </a>
      )
    }

    if (usersCount > 0) {
      userSection = (
        <a href={`/search/users?query=${query}`} className="block">
          <span className="bold">
            {usersCount}
          </span>
          <span> users found</span>
        </a>
      )
    }

    return (
      <div className="bg-white p4 absolute suggestions">
        {productSection}
        {userSection}
      </div>
    )
  }

  render() {
    const { query } = this.state;

    return (
      <div className="flex items-center relative Search">
        <input
          className="bg-transparent search center-align"
          placeholder="Search"
          type="text"
          value={query}
          ref="inputValue"
          onChange={this.handleInputChange} />
        <i className="fa fa-search text-grey-dark search-icon"></i>
        {this.renderSuggestions()}
      </div>
    );
  }
}
