require 'rails_helper'
RSpec.describe Product, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:images) }
    it { is_expected.to have_many(:user_category_products).dependent(:destroy) }
    it { is_expected.to have_many(:user_categories).through(:user_category_products) }
    it { is_expected.to have_many(:categories).through(:user_categories) }
  end

  describe 'validations' do
    it { is_expected.to validate_length_of(:title).is_at_most(described_class::MAX_TITLE_LENGTH) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:redirect_url) }
    it { is_expected.to validate_presence_of(:location) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:price_in_cents) }
  end

  describe '#ensure_absolute_redirect_url' do
    let(:redirect_url) { 'https://test.com/product' }

    subject { create(:product, redirect_url: redirect_url) }

    context 'does not contain protocol' do
      let(:redirect_url) { 'www.citybeach.com' }

      specify { expect(subject.redirect_url).to eq 'http://www.citybeach.com' }
    end

    context 'contain protocol' do
      specify { expect(subject.redirect_url).to eq redirect_url }
    end
  end
end
