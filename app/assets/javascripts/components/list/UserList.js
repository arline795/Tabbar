import InfiniteScroll from 'react-infinite-scroller';
import { fetch2 } from '../services/fetch2';

export default class UserList extends React.Component {
  static propTypes = {
    query: PropTypes.string,
  }

  constructor(props) {
    super(props);

    this.state = {
      users: [],
      page: 1,
      hasMore: false,
      loading: false
    };

    this.loadMore = this.loadMore.bind(this);
    this.loadUsers = this.loadUsers.bind(this);
    this.reloadUsers = this.reloadUsers.bind(this);
  }

  componentDidMount() {
    this.reloadUsers();
  }

  reloadUsers() {
    this.setState({
      loading: true,
      users: [],
      page: 1
    }, this.loadUsers);
  }

  loadUsers() {
    const { query } = this.props;
    const { users, page, categoryId } = this.state;

    fetch2('/api/v1/search/users', { queryParams: { page, query } })
      .then((response) => {
        if (response.status === 200) {
          response.json().then((data) => {
            this.setState({
              users: users.concat(data),
              hasMore: data.has_more,
              loading: false
            });
          });
        }
      });
  }

  loadMore() {
    if (this.state.users.length > 0) {
      this.setState({ page: this.state.page + 1, loading: true }, this.loadUsers);
    }
  }

  render() {
    const { query } = this.props;
    const { users, hasMore, loading } = this.state;
    const cols = [[], [], []];
    
    users.map((user, index) => {
      cols[index % 3].push(user);
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
          useWindow
        >
          {users.map((user) =>
            <a href={`/${user.username}`} key={user.id}>
              <div className="bg-white py2">
                <div className="flex justify-center items-center">
                  <img className="avatar mr2" src={user.image_url} />
                  <div className="bold">
                    {user.username}
                  </div>
                </div>
              </div>
            </a>
          )}
        </InfiniteScroll>
      </div>
    );
  }
}
