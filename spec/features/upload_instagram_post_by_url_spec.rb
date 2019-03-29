require 'rails_helper'

RSpec.describe 'Upload instagram post by url', type: :feature, js: true do
  let!(:user) { create(:user) }
  let!(:influencer) { create(:user, :influencer) }
  let!(:instgram_post_url) { 'https://www.instagram.com/p/Bkcgz1ylyWm/' }
  let!(:image_url) { dress_url }
  let!(:valid_results_from_scraper) do
    {
      username: influencer.username,
      image_url: image_url
    }
  end

  before do
    allow_any_instance_of(InstagramController).to receive(:instagram_images).and_return(:nil)
    expect_any_instance_of(Scrapers::InstagramPost).to receive(:set_machanize).and_return(Mechanize.new)
    expect_any_instance_of(Scrapers::InstagramPost).to receive(:call).and_return(valid_results_from_scraper)

    log_in user
  end

  describe 'when user copy and pasts instagram post url' do
    let(:created_image_of_interest) { ImageOfInterest.last }

    it 'creates an image of interest and can view similar products' do
      fill_in 'instagram_post', with: instgram_post_url

      sleep 3

      expect(find(:xpath, "//img[@class='image-of-interest']")['src'])
        .to include(created_image_of_interest.image.url)
    end
  end
end
