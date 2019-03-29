require 'rails_helper'

RSpec.describe JsCrawlProductService, type: :service do
  include ActiveJob::TestHelper

  subject { described_class.new(crawl_category, url) }

  let! :crawler do
    create(:product_crawler,
           title_css: '#title', price_css: 'a', description_css: '.description li',
           image_css: 'img', image_attribute: 'src', image_regex: '.*\.jpg',
           location: location, user: user)
  end
  let!(:crawl_category) { create(:crawl_category, category: category, product_crawler: crawler) }
  let!(:user) { create(:user, categories: [category]) }
  let!(:category) { create(:category) }
  let(:location) { 'US' }
  let(:url) { 'http://testproductsite/category/product' }
  let(:test_capybara_body) do
    Capybara.string <<-HTML
      <html>
      <head></head>
      <body>
        <p id="title">A title</p>
        <a>$20.99</a>
        <ul class="description">
          <li>Desc 1</li>
          <li>Desc 2</li>
        </ul>
        <img src="http://google.com/abc.jpg"/>
        <img src="http://google.com/abc.png"/>
      </body>
      </html>
    HTML
  end

  describe '#call!' do
    let(:new_product) { user.products.last }

    before do
      allow(subject).to receive(:page).and_return(test_capybara_body)
    end

    it 'creates new product' do
      expect(UpdateProductImageJob).to receive(:perform_later).once
      expect do
        subject.call!
      end.to change(user.products, :count).by(1)
      expect(new_product.title).to eq 'A title'
      expect(new_product.price.to_s).to eq '20.99'
      expect(new_product.description).to eq 'Desc 1. Desc 2'
      expect(new_product.location).to eq location
      expect(new_product.images.pluck(:direct_url)).to eq ['http://google.com/abc.jpg']
      expect(new_product.product_crawler).to eq crawler
    end
  end
end
