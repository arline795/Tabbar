require 'rails_helper'

RSpec.describe ObjectDetectors::ProductImageService, type: :service do
  let!(:product) { create(:product) }

  let!(:user_category_dress) { create(:user_category, user: product.user, category: category_0_0) }
  let!(:category_0_0) { create(:category, name: 'dresses', ancestry: category_0.id.to_s) }

  let!(:user_category_women) { create(:user_category, user: product.user, category: category_0) }
  let!(:category_0) { create(:category, name: 'women', ancestry: nil) }

  let!(:user_category_product)  do
    create(:user_category_product, user_category: user_category_dress, product: product)
  end

  describe '#all_coordinates' do
    context 'when response has many categories' do
      let(:response) do
        "\nLower_body\t573,375,1109,636\nUpper_body\t298,327,609,682\nFull_body\t298,327,609,682"
      end
      let(:product_image) { product.images.first }
      let(:image_url) { product.images.first.product_image.url }

      before do
        expect_any_instance_of(ObjectDetectors::Base)
          .to receive(:fetch_category_coordinates)
          .and_return(response)
      end

      it 'returns response as hash' do
        expect(described_class.new(product_image, image_url).all_coordinates).to eq(
          [
            { 'lower_body' => %w(573 375 1109 636) },
            { 'upper_body' => %w(298 327 609 682) },
            { 'full_body' => %w(298 327 609 682) }
          ]
        )
      end
    end

    context 'when response has one category' do
      let(:response) do
        'Full_body 50,91,915,630'
      end

      let(:product_image) { product.images.first }
      let(:image_url) { product.images.first.product_image.url }

      before do
        expect_any_instance_of(ObjectDetectors::Base)
          .to receive(:fetch_category_coordinates)
          .and_return(response)
      end

      it 'returns response as hash' do
        expect(described_class.new(product_image, image_url).all_coordinates).to eq(
          [{ 'full_body' => %w(50 91 915 630) }]
        )
      end
    end
  end

  describe '#product_category_coordinates' do
    context 'when response has many categories' do
      let(:response) do
        "\nLower_body\t573,375,1109,636\nUpper_body\t298,327,609,682\nFull_body\t298,327,609,682"
      end
      let(:product_image) { product.images.first }
      let(:image_url) { product.images.first.product_image.url }

      before do
        expect_any_instance_of(ObjectDetectors::Base)
          .to receive(:fetch_category_coordinates)
          .and_return(response)
      end

      it 'returns response as hash' do
        response = described_class.new(product_image, image_url).product_category_coordinates
        expect(response).to eq(%w(298 327 609 682))
      end
    end

    context 'when response has one category' do
      let(:response) do
        'Full_body 50,91,915,630'
      end
      let(:product_image) { product.images.first }
      let(:image_url) { product.images.first.product_image.url }

      before do
        expect_any_instance_of(ObjectDetectors::Base)
          .to receive(:fetch_category_coordinates)
          .and_return(response)
      end

      it 'returns response as hash' do
        expect(described_class.new(product_image, image_url).product_category_coordinates).to eq(
          %w(50 91 915 630)
        )
      end
    end
  end
end
