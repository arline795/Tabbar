require 'rails_helper'

RSpec.describe TaddarVision::ProductService, type: :service do
  let!(:product) { create(:product) }

  let!(:user_category) { create(:user_category, user: product.user, category: category_0_0) }
  let!(:category_0_0) { create(:category, name: 'dresses', ancestry: category_0.id.to_s) }

  let!(:category_0) { create(:category, name: 'women', ancestry: nil) }

  let!(:user_category_product)  do
    create(:user_category_product, user_category: user_category, product: product)
  end

  describe '#call' do
    let(:params) do
      {
        image_url: product.images.first.cropped_image.url(:large),
        key_words: 'women full_body dresses',
        price: product.price_in_cents.to_s,
        product_id: product.id.to_s
      }
    end

    before do
      allow(HTTParty).to receive(:post).with(
        "#{ENV['TADDAR_VISION_REGION_URL']}/product_sets/_0000178/#{ENV['TADDAR_VISION_PRODUCT_SET_ID']}/products",
        body: params.to_json,
        headers: {
          'Content-Type' => 'application/json',
          'X-Ca-Version' => '1.0',
          'X-Ca-Accesskeyid' => '1a9646b2acfce6bb8de1027f41979769'
        }
      ).and_return({ succes: true })
    end

    context 'when valid params' do
      subject { described_class.new(product.id, user_category.id) }

      it 'returns successful response' do
        expect(subject.create).to eq({ succes: true })
      end
    end
  end
end
