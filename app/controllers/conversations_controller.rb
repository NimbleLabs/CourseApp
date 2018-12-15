class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:send_message]

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.status = 'new'

    if user_signed_in?
      @conversation.user_id = current_user.id
    else
      @conversation.visitor_id = current_visit.visitor_id
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
      participant = @conversation.participant_from_user(current_user)
    else
      participant = @conversation.participant_from_visit(current_visit)
    end

    @message = Message.create(conversation: @conversation, status: 'created', conversation_participant: participant, body: params[:message])
    render json: @message, status: :created
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
