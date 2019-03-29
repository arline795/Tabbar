class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def instagram
    instagram_user = InstagramUserCreator.new(user_params)

    if instagram_user.find_or_create
      @user = instagram_user.user

      sign_in @user
      redirect_user
    else
      redirect_to root_path
      flash[:danger] = 'Could not authenticate'
    end
  end

  private

  def user_params
    {
      token: req['credentials']['token'],
      username: req['extra']['raw_info']['username'],
      first_name: req['extra']['raw_info']['full_name'].split(' ')[0],
      last_name: req['extra']['raw_info']['full_name'].split(' ')[1],
      profile_picture: req['extra']['raw_info']['profile_picture'],
      description: req['extra']['raw_info']['bio'],
      website_url: req['extra']['raw_info']['website']
    }
  end

  def req
    @req ||= request.env['omniauth.auth']
  end

  def redirect_user
    if @user.set_up_completed?
      redirect_to root_path
      flash[:success] = 'Successfully authenticated'
    else
      redirect_to setup_users_path @user
    end
  end
end
