class ApplicationController < ActionController::Base
  PER_PAGE = 9
  protect_from_forgery prepend: true
  before_action :authenticate_user!
  before_action :masquerade_user!

  def absolute_url(url)
    url.include?('://') ? url : "#{root_url}#{url}"
  end

  protected

  def admin_user
    # TODO: is this method even required?
    redirect_to(root_url) unless current_user.try(:admin?)
  end

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.permit(:sign_up, keys: %i(username first_name last_name date_of_birth))
  # end

  def errors(object)
    object.errors.full_messages.to_sentence
  end

  def render_404
    render file: "#{Rails.root}/public/404", status: :not_found
  end
end
