require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  let!(:product1) { create(:product, title: 'Long milo') }
  let!(:product2) { create(:product, title: 'Mall Str') }
  let!(:product3) { create(:product, title: 'mill imetre') }
  let!(:user1) { create(:user, username: 'Milson Dr') }
  let!(:user2) { create(:user, username: 'Mill-enium') }
  let!(:user3) { create(:user, username: 'wind miLL') }
  let(:parsed_response) { JSON(response.body) }

  before { sign_in(user1) }

  describe 'GET index' do
    it 'returns correct products and users counts' do
      get :index, params: { query: 'mill', format: 'json' }

      expect(parsed_response['products_count']).to eq 1
      expect(parsed_response['users_count']).to eq 2
    end
  end

  describe 'GET products' do
    it 'returns filtered products' do
      get :products, params: { query: 'mill', format: 'json' }
      expect(assigns(:products)).to eq [product3]
    end
  end

  describe 'GET users' do
    it 'returns filtered users' do
      get :users, params: { query: 'mill', format: 'json' }
      expect(assigns(:users)).to match_array [user2, user3]
    end
  end
end
