require 'rails_helper'
RSpec.describe ProductImage, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:product) }
  end

  describe '#cropped_image' do
    let!(:product_image) { create(:product_image) }

    it { expect(product_image.cropped_image.present?).to be_truthy }
  end
end
