require 'rails_helper'

RSpec.describe Api::V1::InstagramAuthenticationController, type: :request do
  subject(:parsed_response) { JSON.parse(response.body, symbolize_names: true) }
  let(:user) { build(:user) }

  describe '#token' do
    context 'when valid token' do
      let(:instagram_response) do
        {
          user: {
            username: user.username,
            full_name: 'Foo Bar',
            bio: user.description,
            website_url: user.website_url,
            profile_picture: ''
          },
          token: user.instagram_token
        }
      end

      before do
        allow(Instagram).to receive(:get_access_token).and_return(instagram_response)
      end

      it 'redirects to branch.io with then returns auth_token to the mobile app' do
        pending('Finish spec if we need a mobile app')
        # To undestand how this works go to www.branch.io and search the below
        # link the in the mobile app code
        get '/api/v1/token', { code: 'instagram_auth_code', redirect_uri: api_v1_token_url }

        expect(response.location).to include('https://nqqw.app.link?auth_token')
      end
    end
  end
end
