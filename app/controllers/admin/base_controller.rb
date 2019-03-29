class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin

  protected

  def authorize_admin
    render_404 unless current_user&.admin?
  end
end
