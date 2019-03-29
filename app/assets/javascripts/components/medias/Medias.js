import InfiniteScroll from 'react-infinite-scroller';
import { fetch2 } from '../services/fetch2';

export default class Medias extends React.Component {
  static propTypes = {
    medias: PropTypes.array,
    username: PropTypes.string,
  }

  constructor(props) {
    super(props);
    this.state = {
      medias: [],
      mediaIds: [],
      nextMaxId: null,
      hasMore: false,
      loading: false
    }

    this.loadMoreMedias = this.loadMoreMedias.bind(this);
    this.loadMedias = this.loadMedias.bind(this);
  }

  componentDidMount() {
    this.loadMoreMedias();
  }

  loadMoreMedias() {
    this.setState({ loading: true }, this.loadMedias);
  }

  loadMedias() {
    const { username } = this.props;
    const { medias, mediaIds, nextMaxId } = this.state;

    fetch2(`/${username}/instagram_images.json`, { queryParams: { max_id: nextMaxId } })
      .then((response) => {
        if (response.status === 200) {
          response.json().then((data) => {
            this.setState({
              medias: medias.concat(data.medias.filter((media) => mediaIds.indexOf(media.media_id) < 0)),
              nextMaxId: data.next_max_id,
              hasMore: data.has_more,
              loading: false
            });
          });
        }
      });
  }

  render() {
    const { taggedImages, selecting, medias, nextMaxId, hasMore, loading } = this.state;
    const cols = [[], [], []];

    medias.map((media, index) => {
      cols[index % 3].push(media);
    });

    return (
      <div className="container-no-padding pt4">
        <InfiniteScroll
          pageStart={0}
          loadMore={this.loadMoreMedias}
          hasMore={hasMore && !loading}
          loader={<div className="loading"></div>}
          className="flex flex-wrap justify-between cell-list masonry"
          useWindow
        >
          {cols.map((col, index) =>
            <div className="c1in3 p3 flex flex-column" key={index}>
              {col.map((media) =>
                <Media key={media.media_id} media={media} />
              )}
            </div>
          )}
        </InfiniteScroll>
      </div>
    );
  }
}