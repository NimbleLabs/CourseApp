class CreditCardService
  attr_reader :errors

  def initialize(user)
    @user = user
    @errors = []
  end

  def create_card(card_params)
    card_data = {
        number: card_params[:card_number],
        exp_month: card_params[:exp_month],
        exp_year: card_params[:exp_year],
        cvc: card_params[:cvc]
    }

    begin
      if (@user.stripe_customer_id.blank?)
        stripe_customer = Stripe::Customer.create(email: @user.email, description: @user.full_name)
        @user.update_attributes(stripe_customer_id: stripe_customer.id)
      else
        stripe_customer = Stripe::Customer.retrieve(@user.stripe_customer_id)
      end

      stripe_token = Stripe::Token.create(card: card_data)
      stripe_card = stripe_customer.sources.create({:source => stripe_token.id})
      return save_card(stripe_card)
    rescue Stripe::StripeError => exception
      @errors.push(exception.message)
      Rollbar.error(exception)
      return nil
    end
  end

  def save_card(stripe_card)
    Rollbar.info "Stripe::Card", card: stripe_card
    credit_card = CreditCard.new(
        user_id: @user.id,
        stripe_id: stripe_card.id,
        last_4_digits: stripe_card.last4,
        exp_month: stripe_card.exp_month,
        exp_year: stripe_card.exp_year,
        card_type: stripe_card.brand,
        cvc_check: stripe_card.cvc_check,
        card_number: 'REDACTED',
        cvc: 'REDACTED'
    )

    credit_card.save!
    credit_card
  end

  def delete_card(credit_card)
    begin
      stripe_customer = Stripe::Customer.retrieve(@user.stripe_customer_id)
      return stripe_customer.sources.retrieve(credit_card.stripe_id).delete()
    rescue Stripe::StripeError => exception
      if exception.message.index('No such customer').present?
        @user.update_attributes(stripe_customer_id: nil)
      end

      @errors.push(exception.message)
      Rollbar.error(exception)
      return nil
    end
  end

  def add_plan(plan_name)
    subscription = nil

    if plan_name == 'pro'
      subscription = add_pro_plan
    elsif plan_name == 'lifetime-pro'
      return charge
    else
      @errors.push('unrecognized plan: ' + plan_name)
    end

    subscription
  end

  # ***** STANDARD PLANS ******************************************************


  def add_pro_plan
    plan_id = ENV['STRIPE_PRO_PLAN']
    subscribe(plan_id)
  end

  def lifetime_pro_charge
    charge
  end

  def errors?
    @errors.length > 0
  end

  def copy_errors(credit_card)
    @errors.each do |error_message|
      credit_card.errors.add(:base, :issue_with_card, message: error_message)
    end

    credit_card
  end

  def current_subscription
    subscription_id = @user.stripe_subscription_id
    plan = 'Free'
    if subscription_id.present?
      subscription = Stripe::Subscription.retrieve(subscription_id)
      plan = subscription.plan.nickname
    end

    subscription = {
        name: plan
    }

    subscription
  end

  private

  def subscribe(plan_id)
    raise 'plan required' if plan_id.blank?

    begin
      subscription_params = {
          customer: @user.stripe_customer_id,
          items: [{plan: plan_id}]
      }

      stripe_subscription = Stripe::Subscription.create(subscription_params)
      Rollbar.info('Subscription created for: ' + @user.email, subscription: stripe_subscription)
      @user.update_attributes(stripe_subscription_id: stripe_subscription.id)
      return stripe_subscription
    rescue Stripe::StripeError => exception
      @errors.push(exception.message)
      Rollbar.error(exception)
      return nil
    end
  end

  def charge
    amount = 19900 # $199.00

    begin
      stripe_charge = Stripe::Charge.create(
          :amount => amount,
          :currency => "usd",
          :customer => @user.stripe_customer_id,
          :description => "Lifetime Pro for " + @user.email
      )

      Rollbar.info('Stripe charge created for: ' + @user.email, charge: stripe_charge)
      @user.update_attributes(stripe_charge_id: stripe_charge.id)
      return stripe_charge
    rescue Stripe::StripeError => exception
      puts exception.message
      @errors.push(exception.message)
      Rollbar.error(exception)
      return nil
    end
  end

end
