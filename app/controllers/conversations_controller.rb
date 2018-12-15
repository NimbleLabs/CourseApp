class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:send_message, :messages]

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.status = 'new'

    if user_signed_in?
      @conversation.user_id = current_user.id
    else

      if current_visit.blank?
        @conversation.visitor_id = cookies[:ahoy_visitor]
      else
        @conversation.visitor_id = current_visit.visitor_id
      end

    end

    if @conversation.save
      @message = @conversation.new_message(params[:message])

      render json: @message, status: :created
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end

  end

  def send_message
    if user_signed_in?
      @message = @conversation.message_from_user(current_user, params[:message])
    else
      @message = @conversation.message_from_visitor(current_visit, params[:message])
    end

    render json: @message, status: :created
  end

  def messages
    render json: @conversation.messages
  end

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
