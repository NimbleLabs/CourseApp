class Admin::ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :send_message, :edit, :update, :destroy]

  before_action :authenticate_user!
  before_action :ensure_admin

  layout 'admin'

  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.status = 'new'

    respond_to do |format|
      if @conversation.save
        @message = @conversation.message_from_user(current_user, params[:message])
        format.html {redirect_to @conversation, notice: 'Conversation was successfully created.'}
        format.json {render json: @message, status: :created}
      else
        format.html {render :new}
        format.json {render json: @conversation.errors, status: :unprocessable_entity}
      end
    end
  end

  def send_message
    @message = @conversation.message_from_user(current_user, params[:message])
    render json: @message, status: :created
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html {redirect_to @conversation, notice: 'Conversation was successfully updated.'}
        format.json {render :show, status: :ok, location: @conversation}
      else
        format.html {render :edit}
        format.json {render json: @conversation.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  # def destroy
  #   @conversation.destroy
  #   respond_to do |format|
  #     format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def conversation_params
    params.require(:conversation).permit(:status)
  end
end
