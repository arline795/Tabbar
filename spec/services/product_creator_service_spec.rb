require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe ProductCreatorService, type: :service do
  let!(:commission_factory_importer) { create(:commission_factory_importer) }
  let!(:user) { commission_factory_importer.user }
  let!(:category_0) { create(:category, name: 'women', ancestry: nil) }
  let!(:category_1) { create(:category, name: 'men', ancestry: nil, id: 63) }
  let!(:category_0_0) { create(:category, name: 'dresses', ancestry: category_0.id.to_s) }
  let!(:category_0_1) { create(:category, name: 'tops', ancestry: category_0.id.to_s) }
  let!(:user_category) { create(:user_category, user: user, category: category_0_0) }
  let(:created_product) { Product.last }
  let(:product_attributes) { build(:product) }
  let(:product_params) do
    DataClumps::ProductsParams.new(
      product_attributes.title,
      product_attributes.description,
      product_attributes.price_in_cents,
      user.country,
      product_attributes.redirect_url,
      [dress_url]
    ).to_hash
  end

  before do
    stub_exteral_services_for_product_create_flow
  end

  describe '#call' do
    context 'when valid params' do
      it 'creates product, product image, user category product and exports to taddar vision' do
        expect do
          described_class.new(user.id, product_params, user_category.id).call
        end.to change { Product.count }.from(0).to(1)
          .and change { ProductImage.count }.from(0).to(1)
          .and change { UserCategoryProduct.count }.from(0).to(1)
      end
    end

    context 'when product is invalid' do
      it 'raises active record error' do
        product_params[:name] = nil

        expect do
          described_class.new(user.id, product_params, user_category.id).call
        end.to raise_error(ActiveRecord::RecordInvalid)
          .and change { Product.count }.by(0)
          .and change { ProductImage.count }.by(0)
          .and change { UserCategoryProduct.count }.by(0)
      end
    end

    context 'when user_category_id is invalid' do
      let(:invalid_category_id) { Faker::Number.number(5) }
      it 'raises active record error' do
        expect do
          described_class.new(user.id, product_params, invalid_category_id).call
        end.to raise_error(ActiveRecord::RecordNotFound)
          .and change { Product.count }.by(0)
          .and change { ProductImage.count }.by(0)
          .and change { UserCategoryProduct.count }.by(0)
      end
    end

    context 'when image urls is empty' do
      it 'raises active record error' do
        product_params[:image_urls] = []

        expect do
          described_class.new(user.id, product_params, user_category.id).call
        end.to raise_error(EmptyArrayError)
          .and change { Product.count }.by(0)
          .and change { ProductImage.count }.by(0)
          .and change { UserCategoryProduct.count }.by(0)
      end
    end

    context 'when product with same redirect url exists' do
      let!(:product_with_same_redirect_url) { create(:product, redirect_url: product_params[:redirect_url]) }
      it 'updates the product and does not create a new one' do
        expect do
          described_class.new(user.id, product_params, user_category.id).call
        end.to_not change { Product.count }

        expect(created_product.title).to eq(product_params[:name])
        expect(created_product.description).to eq(product_params[:description])
        expect(created_product.price_in_cents).to eq(product_params[:price_in_cents])
      end
    end

    context 'when coordinates for image is not available' do
      before do
        ObjectDetectors::ProductImageService
          .any_instance.stub(:product_category_coordinates).and_return([])
      end

      it 'raises no products found error' do
        expect do
          described_class.new(user.id, product_params, user_category.id).call
        end.to raise_error(ProductCoordinatesNotFoundError)
          .and change { Product.count }.by(0)
          .and change { ProductImage.count }.by(0)
          .and change { UserCategoryProduct.count }.by(0)
      end
    end
  end
end
