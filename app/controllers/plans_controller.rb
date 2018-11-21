class PlansController < ApplicationController
  def pro
    if !user_signed_in?
      session[:custom_redirect_url] = pro_plan_path
      redirect_to new_user_registration_path
      return
    end

    @plan = 'pro'
    @credit_card = credit_card
  end

  def lifetime_pro
    if !user_signed_in?
      session[:custom_redirect_url] = lifetime_pro_path
      redirect_to new_user_registration_path
      return
    end

    @plan = 'lifetime-pro'
    @credit_card = credit_card
  end


  private

  def credit_card
    card = CreditCard.new

    if session[:card_errors].present?

      session[:card_errors].each do |card_error|
        name = card_error.first
        message = card_error[1].first
        card.errors.add(name, message)
      end

      session[:card_errors] = nil
    end

    card
  end
end
