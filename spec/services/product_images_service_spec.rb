require 'rails_helper'

RSpec.describe ProductImagesService, type: :service do
  let!(:product) { create(:product) }
  let!(:image_urls) { [dress_url] }

  let!(:user_category_dress) { create(:user_category, user: product.user, category: category_0_0) }
  let!(:category_0_0) { create(:category, name: 'dresses', ancestry: category_0.id.to_s) }

  let!(:user_category_women) { create(:user_category, user: product.user, category: category_0) }
  let!(:category_0) { create(:category, name: 'women', ancestry: nil) }

  let!(:user_category_product)  do
    create(:user_category_product, user_category: user_category_dress, product: product)
  end

  describe '#call' do
    before do
      stub_exteral_services_for_product_create_flow

      product.images.destroy_all
    end

    it 'creates an image with a cropped_image for the product' do
      expect do
        described_class.new(product, image_urls).call
      end.to change { ProductImage.count }.from(0).to(1)

      expect(ProductImage.last.cropped_image.present?).to be_truthy
      expect(ProductImage.last.product).to eq product
    end
  end
end
