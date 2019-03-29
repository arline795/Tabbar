require 'rails_helper'

RSpec.describe UserCategory, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:user_category_products).dependent(:destroy) }
    it { is_expected.to have_many(:products).through(:user_category_products) }
  end
end
