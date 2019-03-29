require 'rails_helper'

RSpec.describe 'Admin Proxies', type: :feature do
  let!(:user) { create(:user, :admin) }

  before do
    allow_any_instance_of(User)
      .to receive(:images_count).and_return(Faker::Number.number(2))

    log_in user
  end

  let(:ip) { Faker::Internet.ip_v4_address }
  let(:port) { '1234' }
  let(:proxy_user) { Faker::Internet.user_name }
  let(:password) { '123abcXYZ' }
  let(:user_agent) { Faker::Lorem.sentence }

  describe 'creation' do
    before do
      visit admin_proxies_path
      click_on 'New Proxy'
    end

    context 'valid' do
      it 'creates proxy' do
        fill_in 'Ip', with: ip
        fill_in 'Port', with: port
        fill_in 'User', with: proxy_user
        fill_in 'Password', with: password
        fill_in 'User agent', with: user_agent
        click_on 'Create Proxy'
        expect(page).to have_content 'Created'
        expect(page).to have_content "#{ip}:#{port}"
        expect(page).to have_content user_agent
        expect(Proxy).to exist(
          ip: ip, port: port, user: proxy_user, password: password, user_agent: user_agent
        )
      end
    end

    context 'invalid' do
      it 'pops errors' do
        fill_in 'Port', with: port
        fill_in 'User', with: proxy_user
        fill_in 'Password', with: password
        fill_in 'User agent', with: user_agent
        click_on 'Create Proxy'
        expect(page).to have_content "Errors: Ip can't be blank"
        expect(Proxy).not_to exist(
          port: port, user: proxy_user, password: password, user_agent: user_agent
        )
      end
    end
  end

  describe 'update' do
    let(:proxy) { create(:proxy) }

    before do
      visit edit_admin_proxy_path(proxy)
      fill_in 'Ip', with: ip
      click_on 'Update Proxy'
    end

    context 'valid' do
      it 'creates proxy' do
        expect(page).to have_content 'Updated'
        expect(page).to have_content "#{ip}:#{proxy.port}"
        expect(proxy.reload.ip).to eq ip
      end
    end

    context 'invalid' do
      let(:ip) { '' }

      it 'pops errors' do
        expect(page).to have_content "Errors: Ip can't be blank"
        expect(proxy.reload.ip).not_to eq ip
      end
    end
  end

  describe 'delete' do
    let!(:proxy) { create(:proxy) }

    it 'deletes proxy' do
      visit admin_proxies_path
      find('tr', text: proxy.ip).find('a[title="Delete"]').click
      expect(page).to have_content 'Deleted'
      expect(Proxy).not_to exist id: proxy.id
    end
  end
end
