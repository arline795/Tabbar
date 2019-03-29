require 'rails_helper'

RSpec.describe 'Viglink crawling', type: :feature do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }
  let!(:category_0) { create(:category, name: 'women', ancestry: nil) }
  let!(:category_1) { create(:category, name: 'men', ancestry: nil) }

  describe '#create' do
    context 'when admin' do
      let(:merchant) { 'merchant' }
      let(:country) { 'Australia' }
      let(:product_link) { "[data-auto-id='productTile'] > a" }
      let(:title) { '.product-hero h1' }
      let(:price) { '#aside-content [data-id="current-price"]' }
      let(:description) { '.product-description' }
      let(:image) { 'img.gallery-image' }
      let(:image_attribute) { 'src' }
      let(:regex) { '.*' }
      let(:load_more) { '[data-auto-id="loadMoreProducts"]' }
      let(:womens_crawl_category) { "Fashion > Clothing > Women's Clothing" }
      let(:query) { 'Dress' }
      let(:mens_crawl_category) { "Fashion > Clothing > Mens's Clothing" }
      let(:mens_query) { 'Shorts' }

      before do
        log_in(admin)
        visit admin_crawling_product_crawlers_path(viglink: true)
      end

      it 'can create crawler' do
        expect(page).to have_content('Viglink Website Crawlers')
        click_link 'Create'
        expect(page).to have_content('New Crawler')
        fill_in 'product_crawler[base_url]', with: 'merchant'
        click_button 'Save'
        expect(page).to have_content('Viglink Website Crawlers')
        expect(page).to have_content(merchant)

        click_on 'Edit'
        select user.username, from: 'product_crawler[user_id]'
        fill_in 'product_crawler[base_url]', with: 'merchant'
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
        expect(page).to have_content(merchant)
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
        fill_in 'crawl_category[viglink_category]', with: womens_crawl_category
        fill_in 'crawl_category[url]', with: query
        click_button 'Create crawl category'
        expect(page).to have_content(query)

        click_on 'Men Categories'
        fill_in 'crawl_category[viglink_category]', with: mens_crawl_category
        fill_in 'crawl_category[url]', with: mens_query
        click_button 'Create crawl category'
        expect(page).to have_content(mens_query)
      end
    end

    context 'when visitor' do
      before do
        visit admin_crawling_product_crawlers_path(viglink: true)
      end

      it 'redirects user to sign up' do
        expect(page).to have_content('You need to sign in or sign up before continuing.')
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
