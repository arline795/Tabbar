require 'rails_helper'

RSpec.describe 'Search', type: :feature, js: true do
  let!(:product1) { create(:product, title: 'Long milo') }
  let!(:product2) { create(:product, title: 'Mall Str') }
  let!(:product3) { create(:product, title: 'mill imetre') }
  let!(:product4) { create(:product, title: 'Something Mill') }
  let!(:user1) { create(:user, :admin, username: 'Milson Dr') }
  let!(:user2) { create(:user, :admin, username: 'Mill-enium') }
  let!(:user3) { create(:user, :admin, username: 'Wind miLL') }
  let!(:user4) { create(:user, :admin, username: 'Enium Mill') }
  let(:client) { double }

  before do
    InstagramController.any_instance.stub(:instagram_images).and_return([{}])

    log_in user2
    visit root_path
    # any page that requires authenticated user will do
    first('.Search input.search').set('mill')
  end

  it 'shows search results' do
    expect(page).to have_content '2 products found'
    expect(page).to have_content '3 users found'
  end

  it 'shows search products when clicking on products' do
    click_on '2 products found'
    expect(page).to have_content product3.title
    expect(page).to have_content product4.title
    expect(page).not_to have_content product1.title
    expect(page).not_to have_content product2.title
  end

  it 'shows search users when clicking on users' do
    click_on '3 users found'
    expect(page).to have_content user2.username
    expect(page).to have_content user3.username
    expect(page).to have_content user4.username
    expect(page).not_to have_content user1.username
  end
end
