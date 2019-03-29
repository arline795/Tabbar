require 'rails_helper'

RSpec.describe UserCategoryProduct, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user_category) }
    it { is_expected.to belong_to(:product) }
  end
end
