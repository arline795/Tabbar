require 'rails_helper'

RSpec.describe CrawlCategory, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:product_crawler) }
  end

  describe 'validation' do
    let(:root_category) { create(:category) }
    let(:child_category) { create(:category, parent: root_category) }

    context 'root category' do
      subject { build(:crawl_category, category: root_category) }

      it { is_expected.not_to validate_presence_of(:url) }
    end

    context 'non root category' do
      subject { build(:crawl_category, category: child_category) }

      it { is_expected.to validate_presence_of(:url) }
    end
  end
end
