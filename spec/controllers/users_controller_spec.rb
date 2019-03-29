require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:admin) { create(:user, :admin, password: 'Password123') }
  let(:user) { create(:user, password: 'Password456') }
  let(:other_user) { create(:user, password: 'Password456') }

  let(:update_params) do
    { id: user.id, user_id: user.id, user: user }
  end

  let(:users) do
    [admin, user] + Array.new(1) { create(:user) }
  end

  let(:user_params) do
    {
      username: "username#{rand(1000)}",
      email: "user#{rand(1000)}@factory.com",
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      password: 'Password123',
      description: 'Nihil eligendi ab debitis iure.'
    }
  end

  describe 'PATCH #update' do
    it 'user updated' do
      sign_in(user)
      patch :update, params: { id: user.username, user: user_params }
      expect(assigns(:user)).to eq(user.reload)
      expect(response).to redirect_to my_account_users_path(user)
    end

    it 'redirects visitor' do
      patch :update, params: { id: user.username, user: user_params }
      expect(response).to redirect_to(new_user_session_path)
    end

    it 'other_user trys to update user but redirects' do
      sign_in(other_user)
      patch :update, params: { id: user.username, user: user_params }
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'DELETE #destroy' do
    it 'admin deletes' do
      sign_in(admin)
      delete :destroy, params: { id: user }
      expect(response).to redirect_to(root_path)
      expect(flash[:success]).to eq('Account successfully closed')
    end

    it "user can't delete another user unless admin" do
      sign_in(other_user)
      delete :destroy, params: { id: user.username }
      expect(response).to redirect_to(root_path)
    end

    it 'redirects visitor' do
      delete :destroy, params: { id: user.username }
      expect(response).to redirect_to(new_user_session_path)
    end
  end
end
