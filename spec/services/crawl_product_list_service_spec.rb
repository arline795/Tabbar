require 'rails_helper'

RSpec.describe CrawlProductListService, type: :service do
  include ActiveJob::TestHelper

  subject { described_class.new(crawl_category, modify) }

  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:user_category) { create(:user_category, user: user, category: category) }
  let! :crawler do
    create(:product_crawler,
           product_link_css: 'a', title_css: '#title', price_css: 'a',
           image_css: 'img', image_attribute: 'src', image_regex: '.*\.jpg',
           description_css: '.description li', location: location, user: user)
  end

  let!(:crawl_category) { create(:crawl_category, product_crawler: crawler, category: category) }
  let(:location) { 'US' }
  let(:modify) { false }
  let(:test_html_body) do
    %(
      <html>
        <body>
          <a href='http://test.com/men/suit'>Suit</a>
          <a href='http://test.com/men/vest'>Vest</a>
        </body>
      </html>
    )
  end
  let(:product_page_html) do
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
        <img src="http://google.com/abc.png"/>
      </body>
      </html>
    )
  end

  describe '#call!' do
    let! :old_product_1 do
      create(:product,
             product_crawler: crawler,
             user_categories: [user_category],
             redirect_url: 'http://test.com/men/suit')
    end
    let! :old_product_2 do
      create(:product,
             product_crawler: crawler,
             user_categories: [user_category],
             redirect_url: 'http://gg.com')
    end

    before do
      allow(subject).to receive(:page_html).and_return(test_html_body)
    end

    it 'performs crawl individual product' do
      expect(CrawlProductJob).to receive(:perform_later).once.with(anything, 'http://test.com/men/suit')
      expect(CrawlProductJob).to receive(:perform_later).once.with(anything, 'http://test.com/men/vest')
      subject.call!
    end

    context 'crawl and modify existing products' do
      let(:modify) { true }
      let(:mock_product_image) { double }
      let(:product_image) { create(:product_image, product: old_product_1) }

      it 'updates existing product and removes obsolete products' do
        allow_any_instance_of(CrawlProductService)
          .to receive(:page_html).and_return(product_page_html)
        allow(ProductImage).to receive(:find).and_return(product_image)
        allow_any_instance_of(ProductImage).to receive(:upload_to_s3!).and_return(nil)
        allow_any_instance_of(TaddarVisionJob).to receive(:perform).and_return(nil)

        expect do
          perform_enqueued_jobs do
            subject.call!
          end
        end.not_to change(Product, :count)

        # Create not existing
        expect(Product).to exist redirect_url: 'http://test.com/men/vest'

        # Modify existing
        expect(old_product_1.reload.price.to_f).to eq 20.99

        # Delete obsolete
        expect(Product).not_to exist id: old_product_2.id
      end
    end
  end
end
