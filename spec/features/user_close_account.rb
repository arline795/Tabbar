require 'rails_helper'

RSpec.describe 'Products', type: :feature do
  let!(:user) { create(:user) }
  let!(:user_id) { user.id }
  let!(:product01) { create(:product, user: user) }
  let!(:order01) { create(:order, product: product01, user: user) }

  describe 'when all orders are complete' do
    before do
      order01.update_attributes(aasm_state: 'complete', product: product01)
      log_in user
    end

    context 'user vistis my account' do
      before { visit my_account_users_path(user) }

      it 'closes account' do
        expect(page).to have_link('Close account')
        click_link 'Close account'
        expect(page).to have_content('Account successfully closed')
      end
    end
  end

  describe "when you have an order that's not complete" do
    before do
      order01.update_attributes(aasm_state: 'pending_payment', product: product01)
      log_in user
    end

    context 'user visits my account' do
      before { visit my_account_users_path(user) }

      it 'can not close account' do
        expect(page).to have_link('Close account')
        click_link 'Close account'
        expect(page).to have_content('All orders must be complete')
      end
    end
  end
end
