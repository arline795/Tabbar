require 'rails_helper'

RSpec.describe 'User sign up and logs out', type: :feature do
  let :fake_auth do
    {
      'credentials' => {
        'token' => instagram_token
      },
      'extra' => {
        'raw_info' => {
          'username' => instagram_username,
          'full_name' => 'Joey Konop',
          'profile_picture' => nil,
          'bio' => description,
          'website_url' => website_url
        }
      }
    }
  end
  let(:instagram_token) { 'instagram_token' }
  let(:username) { 'username' }
  let(:instagram_username) { 'joey_knp' }
  let(:description) { Faker::Lorem.sentence }
  let(:website_url) { 'http://test.com' }
  let(:account_name) { Faker::Lorem.word }

  before do
    allow_any_instance_of(InstagramController).to receive(:instagram_images).and_return([{}])
  end

  describe 'when new regular user signs up' do
    let(:email) { 'test@example.com' }
    let(:created_user) { User.last }

    it 'signs up' do
      visit root_url
      click_link('Sign up with Instagram', match: :first)

      # show validation error when they don't fill out email
      click_button 'Save'
      expect(page).to have_content('Please fill out email')

      # fill out form correctly
      fill_in 'user[email]', with: email
      click_button 'Save'

      # creates regular user
      expect(created_user.email).to eq(email)
      expect(created_user.has_role?(:regular)).to eq(true)

      # logs out
      click_link('Log out', match: :first)
    end
  end

  describe 'when basic user exists' do
    let!(:user) do
      create(:user,
             :regular,
             first_name: 'Joey',
             last_name: 'Konop',
             username: username,
             instagram_username: instagram_username,
             instagram_token: instagram_token)
    end

    context 'log in' do
      it 'logged in but not created' do
        visit root_url
        click_link('Sign up with Instagram', match: :first)
        expect(page).to have_content('Successfully authenticated')
        expect(page).to have_content(username)
        expect { User.count }.to change { User.count }.by(0)
        expect(User.find_by(username: username).has_role?(:regular)).to eq(true)
      end
    end

    context 'logs in' do
      before do
        visit root_url
        click_link('Sign in', match: :first)
      end

      it 'views outfits page' do
        expect(page).to have_content('Successfully authenticated')
        expect(page).to have_link(username)
        expect(page).to have_link('taddar')
        expect(page).to have_link('My Account')
        expect(page).to have_link('Log out')

        # regular user does not have these links
        expect(page).to_not have_link('Delayed jobs')
        expect(page).to_not have_link('Users')
        expect(page).to_not have_link('Product Crawlers')
        expect(page).to_not have_link('Commission Factory')
        expect(page).to_not have_link('Proxies')
      end
    end
  end

  describe 'when admin exists' do
    let!(:admin) do
      create(:user,
             :admin,
             first_name: 'Joey',
             last_name: 'Konop',
             username: instagram_username,
             instagram_username: instagram_username,
             instagram_token: instagram_token)
    end

    context 'logs in' do
      before do
        visit root_url
        click_link('Sign in', match: :first)
      end

      it 'views profile page' do
        expect(page).to have_content('Successfully authenticated')
        expect(page).to have_link(instagram_username)
        expect(page).to have_link('taddar')
        expect(page).to have_link('My Account')
        expect(page).to have_link('Log out')

        # admin has these links
        expect(page).to have_link('Users')
        expect(page).to have_link('Commission Factory')
        expect(page).to have_link('Viglink Crawlers')
        expect(page).to have_link('Sidekiq Dash')
        expect(page).to have_link('Proxies')
      end
    end
  end
end
