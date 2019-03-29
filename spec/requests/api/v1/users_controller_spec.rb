require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :request do
  let!(:user) { create(:user) }
  let(:parsed_response) { JSON(response.body) }

  context 'GET #show' do
    context 'when authenticated user' do
      let(:res) do
        {
          'username' => user.username,
          'country' => Country.new(user.country).name,
          'uuid' => user.uuid,
          'avatar_url' => user.avatar.url,
          'website_url' => user.website_url
        }
      end

      it 'returns a user' do
        sign_in(user)
        get "/api/v1/users/#{user.uuid}", headers: auth_headers

        expect(parsed_response).to eq res
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unauthenticated user' do
      it 'returns unauthorized' do
        get "/api/v1/users/#{user.uuid}"

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  context 'PATCH #update' do
    context 'when authenticated user' do
      let(:username) { 'update_username' }
      let(:res) do
        {
          'username' => username,
          'avatar_url' => user.avatar.url,
          'website_url' => user.website_url,
          'country' => Country.new(user.country).name,
          'uuid' => user.uuid
        }
      end

      it 'returns an updated user' do
        sign_in(user)
        patch "/api/v1/users/#{user.uuid}",
              params: { user: { username: username } },
              headers: auth_headers

        user.reload
        # expect(parsed_response).to eq res
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when unauthenticated user' do
      it 'returns unauthorized' do
        get "/api/v1/users/#{user.uuid}"

        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
