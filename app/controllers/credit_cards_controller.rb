class CreditCardsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_credit_card, only: [:show, :edit, :update, :destroy]

  # GET /credit_cards
  # GET /credit_cards.json
  def index
    @credit_cards = current_user.credit_cards
  end

  # GET /credit_cards/1
  # GET /credit_cards/1.json
  def show
  end

  # GET /credit_cards/new
  def new
    @credit_card = CreditCard.new
  end

  # GET /credit_cards/1/edit
  def edit
  end

  # POST /credit_cards
  # POST /credit_cards.json
  def create
    @plan = params[:plan]

    if @plan.blank?
      raise 'plan cant be blank' # TODO: fix
      return
    end

    puts 'CreditCard.new'
    @credit_card = CreditCard.new(credit_card_params)

    if !@credit_card.valid?
      session[:card_errors] = @credit_card.errors
      redirect_to request.referer
      return
    end

    puts 'CreditCardService.new'

    #save card information in Stripe Service
    service = CreditCardService.new(current_user)
    @saved_credit_card = service.create_card(credit_card_params)
    puts 'after create_card'

    if @saved_credit_card.blank?
      puts 'CC blank'
      service.copy_errors(@credit_card)
      session[:card_errors] = @credit_card.errors
      redirect_to request.referer
      return
    end

    puts 'service.add_plan, @plan: '+ @plan
    subscription = service.add_plan(@plan)

    if subscription.nil?
      service.copy_errors(@credit_card)
      session[:card_errors] = @credit_card.errors
      redirect_to request.referer
      return
    end

    #user = current_user
    #UserMailer.new_customer(user).deliver_later
    redirect_to root_path, notice: 'Pro subscription created.'
  end

  # PATCH/PUT /credit_cards/1
  # PATCH/PUT /credit_cards/1.json
  def update
    respond_to do |format|
      if @credit_card.update(credit_card_params)
        format.html {redirect_to @credit_card, notice: 'Credit card was successfully updated.'}
        format.json {render :show, status: :ok, location: @credit_card}
      else
        format.html {render :edit}
        format.json {render json: @credit_card.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /credit_cards/1
  # DELETE /credit_cards/1.json
  def destroy
    service = CreditCardService.new(current_user)
    service.delete_card(@credit_card)
    @credit_card.destroy

    respond_to do |format|
      if (service.errors?)
        format.html {redirect_to credit_cards_path, notice: @credit_card.errors.full_messages.first}
        format.json {render json: @credit_card.errors, status: :unprocessable_entity}
      else
        format.html {redirect_to credit_cards_url, notice: 'Credit card was successfully destroyed.'}
        format.json {head :no_content}
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_credit_card
    @credit_card = CreditCard.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def credit_card_params
    params.require(:credit_card).permit(:name_on_card, :card_number, :exp_month, :exp_year, :cvc, :zip_code, :card_type, :user_id)
  end

end
