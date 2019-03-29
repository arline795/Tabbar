require 'rails_helper'

RSpec.describe Api::V1::InstagramPostsController, type: :request do
  subject(:res_body) { JSON.parse(response.body, symbolize_names: true) }

  let!(:user) { create(:user) }
  let!(:influencer) { create(:user, :influencer) }
  let!(:instgram_post_url) { 'https://www.instagram.com/p/Bkcgz1ylyWm/' }
  let!(:valid_results_from_scraper) do
    {
      username: influencer.username,
      image_url: dress_url
    }
  end

  describe '#index' do
    context 'when instagram post sent in params' do
      before do
        allow_any_instance_of(Scrapers::InstagramPost).to receive(:set_machanize).and_return(Mechanize.new)
        allow_any_instance_of(Scrapers::InstagramPost).to receive(:call).and_return(valid_results_from_scraper)

        sign_in(user)
      end

      it 'returns username and image url from the instagram post web page' do
        get "/api/v1/instagram_posts?instagram_post_url=#{instgram_post_url}", {}, auth_headers

        expect(res_body).to eq(valid_results_from_scraper)
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
