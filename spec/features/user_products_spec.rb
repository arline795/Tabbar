require 'rails_helper'

RSpec.describe 'User Products View', type: :feature, js: true do
  let(:user) { create(:user, country: 'AU') }

  let(:category_0) { create(:category, name: 'women', ancestry: nil) }
  let(:category_1) { create(:category, name: 'men', ancestry: nil, id: 63) }
  let(:category_0_0) { create(:category, name: 'dresses', ancestry: category_0.id.to_s) }
  let(:category_0_1) { create(:category, name: 'tops', ancestry: category_0.id.to_s) }
  let(:category_1_0) { create(:category, name: 'jeans', ancestry: category_1.id.to_s) }
  let(:category_0_0_0) { create(:category, name: 'Child 1', ancestry: "#{category_0.id}/#{category_0_0.id}") }
  let(:category_0_0_1) { create(:category, name: 'Child 2', ancestry: "#{category_0.id}/#{category_0_0.id}") }
  let(:category_0_1_0) { create(:category, name: 'Mens jeans child', ancestry: "#{category_1.id}/#{category_1_0.id}") }

  describe 'when user has women and men category' do
    # women
    let!(:uc_0) { create(:user_category, user: user, category: category_0) }
    let!(:uc_0_1) { create(:user_category, user: user, category: category_0_1) }
    let!(:uc_0_2) { create(:user_category, user: user, category: category_0_0) }

    # men
    let!(:uc_1) { create(:user_category, user: user, category: category_1) }
    let!(:uc_1_0) { create(:user_category, user: user, category: category_1_0) }

    # Womens tops
    let!(:product1) { create(:product, user: user, title: 'Product 1', user_categories: [uc_0, uc_0_1]) }
    let!(:product2) { create(:product, user: user, title: 'Product 2', user_categories: [uc_0, uc_0_1]) }
    # Mens jeans
    let!(:product3) { create(:product, user: user, title: 'Product 3', user_categories: [uc_1, uc_1_0]) }

    before do
      allow_any_instance_of(InstagramController).to receive(:instagram_images).and_return(:nil)
      log_in user
      visit users_product_path(user)
    end

    context 'when viewing profile page page' do
      it 'can view both men and women category' do
        expect(page).to have_content('Women')
        expect(page).to have_content('Men')
      end

      it 'can view child categories' do
        expect(page).to have_content product1.price.to_s
        expect(page).to have_content('Tops2')
        expect(page).to have_content('Dresses0')
      end

      it 'can view womens products' do
        find("#product-#{product1.uuid}").hover
        expect(page).to have_content('Product 1')

        find("#product-#{product2.uuid}").hover
        expect(page).to have_content('Product 2')
        expect(page).to_not have_content('Product 3')
      end
    end
  end

  describe 'when user has men category' do
    let!(:uc_1) { create(:user_category, user: user, category: category_1) }
    let!(:uc_1_0) { create(:user_category, user: user, category: category_1_0) }
    let!(:uc_0_0_0) { create(:user_category, user: user, category: category_0_0_0) }
    let!(:uc_0_1_0) { create(:user_category, user: user, category: category_0_1_0) }

    # Mens jeans
    let!(:product3) { create(:product, user: user, title: 'Product 3', user_categories: [uc_1, uc_1_0]) }
    let!(:product4) { create(:product, user: user, title: 'Product 4', user_categories: [uc_1, uc_0_1_0]) }

    before do
      allow_any_instance_of(InstagramController).to receive(:instagram_images).and_return(:nil)
      log_in user
      visit users_product_path(user)
    end

    context 'when viewing profile page' do
      it 'can view men category only' do
        expect(page).to have_content('Men')
        expect(page).to_not have_content('Women')
      end

      it 'can view child categories' do
        expect(page).to have_content('Jeans2')
      end

      it 'can view mens products' do
        find("#product-#{product3.uuid}").hover
        expect(page).to have_content('Product 3')
        expect(page).to have_content product3.price.to_s

        find("#product-#{product4.uuid}").hover
        expect(page).to have_content('Product 4')
        expect(page).to have_content product4.price.to_s

        expect(page).to_not have_content('Product 1')
        expect(page).to_not have_content('Product 2')
      end
    end
  end
end
