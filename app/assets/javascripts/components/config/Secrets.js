const productionLocation = (window.location.host === 'www.taddar.com') || (window.location.host === 'taddar.com');
export const clarifaiApiKey = 'bfa1f9761908410985066ee8ddad49ad'
export const mensClassifierName = 'Mens Fashion Classifier'
export const womenssClassifierName = 'Womens Fashion Classifier'
export const generalClassifierName = 'aaa03c23b3724a16a56b629203edc62c'
export const taddarVisionUrl = 'https://taddarvision.com/api'

// Use below code for when you install staging
// export const taddarVisionUrl = (function() {
//   if (productionLocation) {
//     return 'URL';
//   } else {
//     return 'URL';
//   }
// })();
