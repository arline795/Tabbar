require 'rails_helper'

RSpec.describe Api::V1::SimilarProductsController, type: :request do
  subject(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }
  let(:products) { create_list(:product, 2) }
  let!(:user) { create(:user) }

  let!(:params) do
    {
      image_url: dress_url,
      keywords: 'women dress'
    }
  end

  describe '#index' do
    context 'when authenicated user' do
      context 'when product uuids' do
        let(:index_reponse) do
          products.map do |product|
            {
              uuid: product.uuid,
              title: product.title,
              price: "#{product.display_price} #{product.currency_code}",
              image_url: product.images.first&.image_url,
              redirect_url: product.redirect_url,
              user: {
                username: product.user.username,
                avatar_url: product.user.avatar.url,
                website_url: product.user.website_url,
                country: Country.new(product.user.country).name,
                uuid: product.user.uuid
              },
              images: product.images.map do |product_image|
                {
                  direct_url: product_image.full_direct_url,
                  position: product_image.position,
                  cropped_image_url: product_image.cropped_image.url
                }
              end
            }
          end
        end

        before do
          expect_any_instance_of(TaddarVision::SimilarProducts)
            .to receive(:fetch_similar_product_ids).and_return(products.pluck(:id))

          sign_in(user)
          post '/api/v1/similar_products', params, auth_headers
        end

        it 'returns a list of similar products to the one in the image url' do
          expect(parsed_response).to eq index_reponse
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when unauthenicated user' do
      before do
        post '/api/v1/similar_products', params
      end

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
