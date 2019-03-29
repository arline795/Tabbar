class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i(show images_count products)
  before_action :set_user, only: %i(update edit)
  before_action :set_user_by_username, only: %i(products about_me images_count)
  before_action :redirect_unauthorized_user, only: %i(edit update)

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = 'Profile updated'
    else
      flash[:danger] = errors(current_user)
    end
    redirect_to my_account_users_path(current_user)
  end

  def destroy
    close_account = CloseAccountService.new(current_user).close!
    if close_account.errors.any?
      flash[:danger] = close_account.errors.to_sentence
    else
      flash[:success] = 'Account successfully closed'
    end
    redirect_to root_path
  end

  def destroy_avatar
    if current_user.avatar?
      current_user.avatar.destroy
      current_user.save
      flash[:success] = 'Avatar deleted'
    else
      flash[:danger] = 'Avatar did not delete'
    end
    redirect_back(fallback_location: root_path)
  end

  def my_account
    @user = current_user
  end

  def medias
    @user = User.friendly.find(params[:username])
    @medias = @user.medias.map(&:product_show_json)
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def set_user_by_username
    @user = User.friendly.find(params[:username])
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :date_of_birth, :website_url,
      :first_name, :last_name, :avatar, :header_image, :description, :country,
      :instagram_username, :account_name
    )
  end

  def redirect_unauthorized_user
    redirect_to root_path unless current_user == @user
  end
end
