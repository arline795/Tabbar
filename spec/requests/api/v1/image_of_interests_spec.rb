require 'rails_helper'

RSpec.describe Api::V1::ImageOfInterestsController, type: :request do
  include ActionDispatch::TestProcess::FixtureFile
  subject(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }
  let!(:user) { create(:user) }

  describe '#index' do
    let!(:image_of_interest_1) { create(:image_of_interest, user: user) }
    let!(:detected_product_1) { create(:detected_product, image_of_interest: image_of_interest_1) }

    before do
      allow_any_instance_of(CropImages::ImageOfInterest)
        .to receive(:image_url)
        .and_return(dress_url)
    end

    context 'when authenticated user' do
      let(:valid_response) do
        [
          {
            image_url: image_of_interest_1.image.url,
            uuid: image_of_interest_1.uuid,
            user: {
              username: image_of_interest_1.user.username,
              avatar_url: image_of_interest_1.user.avatar_url,
              website_url: image_of_interest_1.user.website_url,
              country: image_of_interest_1.user.country_name,
              uuid: image_of_interest_1.user.uuid
            },
            detected_products: [
              {
                image_url: detected_product_1.image.url,
                thumb_url: detected_product_1.image(:small),
                product_coordinate: [1, 1]
              }
            ]
          }
        ]
      end

      it 'response' do
        sign_in(user)
        get '/api/v1/image_of_interests', headers: auth_headers

        expect(parsed_response).to eq(valid_response)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#create' do
    context 'when authenticated user' do
      let(:file) {  fixture_file_upload('dress.jpg') }

      it 'response' do
        sign_in(user)

        expect do
          post '/api/v1/image_of_interests', { image_of_interest: { image: file } }, auth_headers
        end.to change { ImageOfInterest.count }.from(0).to(1)

        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe '#destroy' do
    let!(:image_of_interest) { create(:image_of_interest) }

    context 'when authenticated user' do
      it 'response' do
        sign_in(user)
        delete "/api/v1/image_of_interests/#{image_of_interest.uuid}", headers: auth_headers

        expect(parsed_response).to eq({ uuid: image_of_interest.uuid })
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
