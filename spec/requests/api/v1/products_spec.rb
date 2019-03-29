require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :request do
  subject(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }
  let(:products) { create_list(:product, 2) }
  let!(:user) { create(:user) }

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
          sign_in(user)

          get '/api/v1/products', { uuids: products.map(&:uuid) }, auth_headers
        end

        it 'returns products in order of uuids' do
          expect(parsed_response).to eq index_reponse
          expect(response).to have_http_status(:ok)
        end
      end
    end

    context 'when unauthenicated user' do
      before do
        get '/api/v1/products', { uuids: products.map(&:uuid) }
      end

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe '#show' do
    let(:product) { products.first }

    context 'when authenicated user' do
      context 'when valid uuid' do
        let(:show_response) do
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

        it 'response' do
          sign_in(user)
          get "/api/v1/products/#{product.uuid}", headers: auth_headers

          expect(parsed_response).to eq show_response
          expect(response).to have_http_status(:ok)
        end
      end

      context 'when invalid uuid' do
        it 'response' do
          sign_in(user)
          get '/api/v1/products/invalid_uuid', headers: auth_headers

          expect(response.body).to eq("Couldn't find Product")
          expect(response).to have_http_status(:not_found)
        end
      end
    end

    context 'when unauthenicated user' do
      before do
        get "/api/v1/products/#{product.uuid}"
      end

      it 'returns unauthorized' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
