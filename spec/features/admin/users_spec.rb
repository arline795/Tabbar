require 'rails_helper'

RSpec.describe 'Admin Users', type: :feature do
  let!(:user) { create(:user, :admin, username: 'adminuser', instagram_username: 'adminuser', country: 'AU') }
  before do
    allow_any_instance_of(User)
      .to receive(:images_count).and_return(Faker::Number.number(2))
    log_in user
  end

  describe 'create' do
    before do
      visit admin_users_path
      click_on 'New User'
    end

    context 'when valid params' do
      let(:user_name) { Faker::Lorem.word }
      let(:instagram_user_name) { Faker::Lorem.word }
      let(:email) { Faker::Internet.email }
      let(:password) { Faker::Internet.password(8) }
      let(:country) { 'Australia' }
      let(:role) { 'brand' }

      it 'creates user' do
        fill_in 'Username', with: user_name
        fill_in 'Instagram username', with: instagram_user_name
        fill_in 'Email', with: email
        fill_in 'Password', with: password
        select country, from: 'user[country]', match: :first
        select role, from: 'user[roles]'
        click_on 'Create User'
        expect(page).to have_content 'Created'
        expect(User).to exist(
          username: user_name,
          instagram_username: instagram_user_name,
          country: 'AU',
          roles_mask: User.mask_for(role.to_sym)
        )
      end
    end

    context 'invalid' do
      it 'pops errors' do
        fill_in 'Instagram username', with: 'normalinstauser'
        click_on 'Create User'
        expect(page).to have_content 'Errors: '
        expect(User).not_to exist(instagram_username: 'normalinstauser')
      end
    end
  end

  describe 'update' do
    let!(:other_user) { create(:user, username: 'username1') }

    before do
      visit edit_admin_user_path(other_user)
    end

    context 'when valid params' do
      it 'updates user' do
        fill_in 'Username', with: 'normaluser'
        click_on 'Update User'

        expect(page).to have_content 'Updated'
        expect(other_user.reload.username).to eq 'normaluser'
      end
    end

    context 'invalid' do
      it 'pops errors' do
        fill_in 'Username', with: ''
        click_on 'Update User'
        expect(page).to have_content 'Errors: '
        expect(other_user.reload.username).to eq 'username1'
      end
    end
  end

  describe 'delete' do
    let!(:other_user) { create(:user, username: 'username1') }

    it 'deletes user' do
      visit admin_users_path
      find('tr', text: 'username1').find('a[title="Delete"]').click
      expect(page).to have_content 'Deleted'
      expect(User).not_to exist(instagram_username: 'username1')
    end
  end
end
