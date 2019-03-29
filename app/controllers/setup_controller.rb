class SetupController < ApplicationController
  layout :layout_for_action
  before_action :redirect_if_missing_fields, only: :update_profile

  def edit
    redirect_to user_profile_path(current_user) if setup_complete?
  end

  def update_profile
    if current_user.update(user_params.merge!(set_up_completed: true))
      redirect_to root_path
    else
      flash[:danger] = errors(current_user)
      redirect_to setup_users_path(current_user)
    end
  end

  def complete
  end

  private

  def user_params
    params.require(:user).permit(:account_name, :country, :email, :website_url)
  end

  def redirect_if_missing_fields
    # TODO: FIx this includes method. Rever to omniauth controller
    # where email is saved
    if user_params[:email].blank? || user_params[:email].include?('@invalidemail.com')
      redirect_back(fallback_location: root_path)
      flash[:danger] = 'Please fill out email'
    end
  end

  def layout_for_action
    action_name == 'complete' ? 'user_setup_complete' : 'user_setup'
  end

  def setup_complete?
    current_user.set_up_completed?
  end
end
