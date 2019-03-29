require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe CommissionFactory::ImportProductsService, type: :service do
  let!(:commission_factory_importer) { create(:commission_factory_importer) }
  let!(:user) { commission_factory_importer.user }
  let!(:category_0) { create(:category, name: 'women', ancestry: nil) }
  let!(:category_1) { create(:category, name: 'men', ancestry: nil, id: 63) }
  let!(:category_0_0) { create(:category, name: 'dresses', ancestry: category_0.id.to_s) }
  let!(:category_0_1) { create(:category, name: 'tops', ancestry: category_0.id.to_s) }
  let(:user_category) { UserCategory.find_by(user: user, category: category_0_0) }
  let(:created_product) { Product.last }
  let(:csv_product_params) do
    csv = Paperclip.io_adapters.for(
      commission_factory_category_1.commission_factory_importer.csv
    ).read

    CSV.parse(csv, headers: true).first.to_h
  end
  let!(:dress_query) { "Women's Clothing>Dresses>Casual Dresses" }
  let!(:existing_product) { create(:product, redirect_url: csv_product_params['Url'], user: user) }
  let!(:commission_factory_category_1) do
    create \
      :commission_factory_category,
      commission_factory_importer_id: commission_factory_importer.id,
      category: category_0_0,
      query: dress_query
  end

  describe '#call' do
    let(:product_first) { Product.first }

    before do
      stub_exteral_services_for_product_create_flow
    end

    it 'creates products where the category column in csv includes the query' do
      described_class.new(commission_factory_category_1).call

      # there are 4 prdocuts in the csv but only 2 include the query in the csv category column
      expect(Product.count).to eq(2)

      # product should have attributes that equal this
      expect(product_first.attributes.symbolize_keys.except!(:created_at, :updated_at)).to eq(
        {
          id: product_first.id,
          title: csv_product_params['Name'],
          description: csv_product_params['Description'],
          user_id: user.id,
          price_in_cents: 2400,
          location: csv_product_params['Country'],
          redirect_url: csv_product_params['Url'],
          product_crawler_id: nil,
          uuid: product_first.uuid,
          commission_factory_category_id: 1,
          crawled: true
        }
      )

      # ensure product display price is correct
      expect(product_first.display_price).to eq('$24.00')

      # ensure commission factory category
      expect(product_first.commission_factory_category_id).to be_present

      # creates products with price_in_cents
      expect(product_first.price_in_cents)
        .to eq(Sanitizers::PriceSanitizer.new(csv_product_params['Price']).dollar_to_price_in_cents.to_i)

      # creates product images with assigned cropped images
      expect(ProductImage.count).to eq(2)
      expect(ProductImage.first.cropped_image.present?).to be_truthy

      # creates user category
      expect(user_category.present?).to be_truthy

      # creates user category product
      expect(UserCategoryProduct.find_by(user_category: user_category, product: created_product)
          .present?).to be_truthy

      # only creates 1 product if the if a product already exists with same redirect_url
      # TODO: expect(existing_product.reload).to raise_error(NotFound) somethign like this
      expect(Product.where(redirect_url: csv_product_params['Url']).count).to eq 1
    end
  end
end
