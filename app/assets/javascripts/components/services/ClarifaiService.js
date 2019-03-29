import Clarifai from 'clarifai';
import { clarifaiApiKey, mensClassifierName,
         womenssClassifierName, generalClassifierName } from '../config/Secrets'

const clarifaiClient = new Clarifai.App({
  apiKey: clarifaiApiKey,
 });

export default class ClarifaiService {
  womensClassifier(url) {
    return clarifaiClient.models.predict(womenssClassifierName, [url]);
  }

  mensClassifier(url) {
    return clarifaiClient.models.predict(mensClassifierName, [url]);
  }

  genderClassifier(url) {
    return clarifaiClient.models.predict(generalClassifierName, [url])
      .then((res) => {
        return res.outputs[0].data.concepts
      })
      .then((concepts) => {
        const woman = concepts.filter((concept) => concept.name === 'woman')[0]
        const womanValue = woman === undefined ? 0 : woman.value

        const man = concepts.filter((concept) => concept.name === 'man')[0]
        const manValue = man === undefined ? 0 : man.value

        if (womanValue > manValue) {
          return 'woman'
        } else {
          return 'man'
        }
      })
  }
}
