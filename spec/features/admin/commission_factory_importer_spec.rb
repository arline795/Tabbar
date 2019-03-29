require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.inline!

RSpec.describe 'Commssion Factory Importer', type: :feature do
  let!(:admin) { create(:user, :admin) }
  let!(:user) { create(:user) }

  let!(:category_0) { create(:category, name: 'women', ancestry: nil) }
  let!(:category_1) { create(:category, name: 'men', ancestry: nil, id: 63) }
  let!(:category_0_0) { create(:category, name: 'dresses', ancestry: category_0.id.to_s) }
  let!(:category_0_1) { create(:category, name: 'tops', ancestry: category_0.id.to_s) }
  let(:user_category) { UserCategory.find_by(user: user, category: category_0_0) }

  before do
    stub_exteral_services_for_product_create_flow
  end

  describe 'when admin' do
    before do
      log_in(admin)
      click_link 'Commission Factory'
    end

    context 'create new cralwer' do
      before do
        click_link 'Create'
        select user.username, from: 'commission_factory_importer[user_id]'
        click_button 'Save'
      end

      it 'creates new commission factory importer' do
        expect(page).to have_content(user.username)
        expect(page).to have_link('Edit')
        expect(page).to have_link('Delete')
      end

      it 'upload products to import by csv and set up crawler and run it' do
        # upload csv
        click_link 'Edit'
        attach_file('commission_factory_importer[csv]', Rails.root + 'spec/fixtures/commission_factory_import.csv')
        click_button 'Save'
        click_link 'Edit'
        expect(page).to have_content('commission_factory_import.csv')

        # create womens dress category
        click_link('Women Categories')
        fill_in 'commission_factory_category[query]', with: '>Casual Dresses'
        select 'Women / Dresses', from: 'crawl_category[category_ids][]'
        click_button 'Create Importer'

        # commission factory category importer created
        expect(page).to have_content('>Casual Dresses')
        expect(page).to have_content('Women / Dresses (0)')
        expect(page).to have_link('Import products')
        expect(page).to have_link('Delete products')
        expect(page).to have_link('Delete products and category')

        # import products
        find(:xpath, "(//a[text()='Import products'])[2]").click
        expect(page).to have_content('Women / Dresses (2)')

        # delete products and category
        find(:xpath, "(//a[text()='Delete products and category'])[2]").click
        expect(page).to_not have_content('Women / Dresses (2)')
        expect(page).to_not have_content('>Casual Dresses')
      end
    end
  end
end
