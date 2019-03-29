require 'rails_helper'

RSpec.describe Api::V1::CroppedProductsController, type: :request do
  subject(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }

  let!(:user) { create(:user) }
  let!(:image_of_interest) { create(:image_of_interest) }

  describe '#create' do
    context 'when authenticated user' do
      context 'cropped product does not exist' do
        let(:create_params) do
          {
            image_of_interest_uuid: image_of_interest.uuid,
            cropped_product: {
              crop_x: 20.96069868995633,
              crop_y: 34.031413612565444,
              crop_w: 53.493449781659386,
              crop_h: 35.602094240837694
            }
          }
        end

        before do
          sign_in(user)
          post '/api/v1/cropped_products', params: create_params, headers: auth_headers
        end

        it 'returns cropped product' do
          image_of_interest.reload

          expect(parsed_response)
            .to eq({ image_url: image_of_interest.cropped_product.image(:large) })
        end
      end
    end
  end
end
