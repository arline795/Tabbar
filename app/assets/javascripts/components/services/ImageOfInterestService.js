export default class ImageOfInterestService {
  create(params, authToken) {
    return fetch('/api/v1/image_of_interests', {
      method: 'POST',
      body: JSON.stringify(params),
      headers: new Headers({
        'Content-Type': 'application/json',
        'X-AUTH-TOKEN': authToken,
      })
    })
      .then(res => {
        return res.json();
      })
  };

  index(page, authToken) {
    return fetch(`/api/v1/image_of_interests?page=${page}`, {
      method: 'GET',
      headers: new Headers({
        'Content-Type': 'application/json',
        'X-AUTH-TOKEN': authToken,
      })
    })
      .then(res => {
        return res.json();
      })
  };
}

