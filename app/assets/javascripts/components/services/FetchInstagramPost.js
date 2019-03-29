export default class FetchInstagramPost {
  index(params, authToken) {
    return fetch(`/api/v1/instagram_posts?instagram_post_url=${params.instagram_post_url}`, {
      method: 'GET',
      headers: {
        'Content-Type': 'application/json',
        'X-auth-token': authToken,
      }
    })
      .then(res => {
        return res.json();
      })
  };
}
