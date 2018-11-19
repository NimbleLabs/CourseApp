class ApplicationController < ActionController::Base

  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  private

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def ensure_admin
    return true if user_signed_in? && current_user.admin?

    redirect_to root_path, flash: {alert: "You don't have enough permissions to proceed"}
    return false
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:email, :password, :password_confirmation, :full_name)
    end
  end

end
