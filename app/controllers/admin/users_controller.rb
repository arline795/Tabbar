class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i(edit update destroy execute)

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.merge(instagram_token: SecureRandom.uuid))

    if @user.save
      flash[:success] = 'Created'
      redirect_to admin_users_path
    else
      flash[:danger] = "Errors: #{@user.errors.full_messages.to_sentence}"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_without_password(user_params)
      flash[:success] = 'Updated'
      redirect_to admin_users_path
    else
      @user.reload
      flash[:danger] = "Errors: #{@user.errors.full_messages.to_sentence}"
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = 'Deleted'
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :username, :instagram_username, :country, :description,
      :slug, :website_url, :email, :account_name, :roles, :password
    )
  end
end
