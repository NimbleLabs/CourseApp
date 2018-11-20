class RegistrationsController < Devise::RegistrationsController
  prepend_before_action :check_captcha, :configure_permitted_parameters, only: [:create]
  layout 'devise'

  # def create
  #   super
  # end
  #
  # def new
  #   super
  # end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
  end

  def check_captcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate # Look for any other validation errors besides Recaptcha
      respond_with_navigational(resource) { render :new }
    end
  end
end