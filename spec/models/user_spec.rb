require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:instagram_username) }
    it { is_expected.to validate_presence_of(:slug) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:user_categories).dependent(:destroy) }
    it { is_expected.to have_many(:categories).through(:user_categories) }
    it { is_expected.to have_many(:products) }
    it { is_expected.to have_many(:product_crawlers) }
  end
end
