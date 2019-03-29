
require 'rails_helper'
RSpec.describe 'Website crawling', type: :feature do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:category_0) { create(:category, name: 'women', ancestry: nil) }
  let!(:category_1) { create(:category, name: 'men', ancestry: nil) }

  describe '#create' do
    context 'when admin' do
      let(:base_url) { 'www.example.com' }
      let(:country) { 'Australia' }
      let(:product_link) { "[data-auto-id='productTile'] > a" }
      let(:title) { '.product-hero h1' }
      let(:price) { '#aside-content [data-id="current-price"]' }
      let(:description) { '.product-description' }
      let(:image) { 'img.gallery-image' }
      let(:image_attribute) { 'src' }
      let(:regex) { '.*' }
      let(:load_more) { '[data-auto-id="loadMoreProducts"]' }
      let(:crawl_url) { 'www.example.com/dress' }
      let(:mens_crawl_url) { 'www.example.com/shorts' }

      before do
        log_in admin
        visit admin_crawling_product_crawlers_path
      end

      it 'can create crawler' do
        expect(page).to have_content('Website Crawlers')
        click_link 'Create'
        expect(page).to have_content('New Crawler')
        expect(page).to_not have_content('Merchant')
        expect(page).to_not have_content('Viglink crawler?')
        select user.username, from: 'product_crawler[user_id]'
        fill_in 'product_crawler[base_url]', with: base_url
        click_button 'Save'

        expect(page).to have_content(base_url)
        expect(page).to have_content(user.username)
        expect(page).to have_content('Website Crawlers')

        click_on 'Edit'
        select user.username, from: 'product_crawler[user_id]'
        expect(page).to have_content(base_url)
        select country, from: 'product_crawler[location]', match: :first
        fill_in 'product_crawler[product_link_css]', with: product_link
        fill_in 'product_crawler[title_css]', with: title
        fill_in 'product_crawler[price_css]', with: price
        fill_in 'product_crawler[description_css]', with: description
        fill_in 'product_crawler[image_css]', with: image
        fill_in 'product_crawler[image_attribute]', with: image_attribute
        fill_in 'product_crawler[image_regex]', with: regex
        fill_in 'product_crawler[load_more_css]', with: load_more
        expect(page).to have_content('Crawl by javascript?')
        expect(page).to have_content('Crawl page-by-page?')
        click_button 'Save'

        click_on 'Edit'
        expect(page).to have_content(user.username)
        expect(page).to have_content(base_url)
        expect(page).to have_content(country)
        expect(page).to have_field('product_crawler[product_link_css]', with: product_link)
        expect(page).to have_field('product_crawler[title_css]', with: title)
        expect(page).to have_field('product_crawler[price_css]', with: price)
        expect(page).to have_field('product_crawler[description_css]', with: description)
        expect(page).to have_field('product_crawler[image_css]', with: image)
        expect(page).to have_field('product_crawler[image_attribute]', with: image_attribute)
        expect(page).to have_field('product_crawler[image_regex]', with: regex)
        expect(page).to have_field('product_crawler[load_more_css]', with: load_more)

        click_on 'Women Categories'
        fill_in 'crawl_category[url]', with: crawl_url
        click_button 'Create crawl category'
        expect(page).to have_content(crawl_url)

        click_on 'Men Categories'
        fill_in 'crawl_category[url]', with: mens_crawl_url
        click_button 'Create crawl category'
        expect(page).to have_content(mens_crawl_url)

        click_link 'Delete', match: :first
        expect(page).to have_content('Category removed from crawler')
      end
    end

    context 'when visitor' do
      before do
        visit admin_crawling_product_crawlers_path(viglink: true)
      end

      it 'redirects user to sign up' do
        expect(page).to have_content('You need to sign in or sign up before continuing')
      end
    end

    context 'when user' do
      before do
        visit admin_crawling_product_crawlers_path(viglink: true)
      end

      it 'renders 404 page' do
        expect(page).to have_content('You need to sign in or sign up before continuing.')
      end
    end
  end
end
