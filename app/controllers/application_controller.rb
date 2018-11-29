class ApplicationController < ActionController::Base

  before_action :check_visitor
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_resource

  def after_sign_in_path_for(resource)
    if resource.visitor_id.blank? && cookies[:nhq_vid].present?
      resource.update_attribute(:visitor_id, cookies[:nhq_vid])
      cookies.delete(:nhq_vid)
    end

    if session[:custom_redirect_url].present?
      custom_redirect_url = session[:custom_redirect_url]
      session[:custom_redirect_url] = nil
      return custom_redirect_url
    end

    root_path
  end

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

  def check_visitor
    cookies[:nhq_vid] = SecureRandom.uuid if !user_signed_in? && cookies[:nhq_vid].blank?
    true
  end

end
