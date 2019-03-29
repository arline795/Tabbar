export default class TaddarVisionSeddrvice {
  similarProducts(authToken, imageUrl, gender, category) {
    const params = {
      image_url: imageUrl,
      keywords: "",
    }

    return fetch("/api/v1/similar_products", {
      body: JSON.stringify(params),
      headers: new Headers({
        'Content-Type': 'application/json',
        'X-AUTH-TOKEN': authToken,
      }),
      method: "POST"
    })
      .then(res => {
        return res.json();
      })
  };
}
