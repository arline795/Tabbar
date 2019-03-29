require 'rails_helper'

RSpec.describe CrawlProductService, type: :service do
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
  let(:product_image) { build(:product_image, product: mock_product) }
  let(:mock_product) { build(:product) }
  let(:url) { 'http://testproductsite/category/product' }
  let(:test_html_body) do
    %(
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
        <img src="http://google.com/xyz.jpg"/>
        <img src="http://google.com/abc.png"/>
      </body>
      </html>
    )
  end

  describe '#call!' do
    let(:new_product) { user.products.last }

    before do
      expect(subject).to receive(:page_html).and_return(test_html_body)
      allow(ProductImage).to receive(:find).and_return(product_image)
    end

    it 'creates new product and delete obsolete products' do
      expect(product_image).to receive(:upload_to_s3!).once
      expect do
        perform_enqueued_jobs do
          subject.call!
        end
      end.to change(user.products, :count).by(1)
      expect(new_product.title).to eq 'A title'
      expect(new_product.price.to_s).to eq '20.99'
      expect(new_product.description).to eq 'Desc 1. Desc 2'
      expect(new_product.location).to eq location
      expect(new_product.images.pluck(:direct_url))
        .to match_array ['http://google.com/abc.jpg']
      expect(new_product.product_crawler).to eq crawler
    end
  end
end
