class Admin::MasqueradesController < Devise::MasqueradesController
  protected

  def masquerade_authorized?
    current_user.admin? || user_masquerade?
  end

  def find_resource
    masqueraded_resource_class.friendly.find(params[:id])
  end
end
