# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ConversationChannel < ApplicationCable::Channel
  def subscribed
    puts 'subscribed event'
    stream_from "conversations_#{params['conversation_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    puts '---------------------------------'
    puts 'send message: ' + data.inspect
    puts '---------------------------------'

    #current_user.messages.create!(body: data['message'], chat_room_id: data['chat_room_id'])
  end

  # def joined_chat(data)
  #   chat_room_id = data['conversation_id']
  #   participant = ChatParticipant.where( email: current_user.email, chat_room_id: chat_room_id ).first_or_create
  #   participant.name = current_user.name
  #   participant.status = 'online'
  #   participant.joined_at = DateTime.now
  #   participant.save
  #   online_count = ChatParticipant.where( chat_room_id: chat_room_id, status: 'online' ).count
  #   OnlineBroadcastJob.perform_later(chat_room_id, current_user.id, 'joined', online_count)
  # end
  #
  # def left_chat(data)
  #   participant = ChatParticipant.where( email: current_user.email, chat_room_id: chat_room_id ).first
  #
  #   if( participant.present? )
  #     participant.status = 'offline'
  #     participant.left_at = DateTime.now
  #     participant.save
  #   end
  #
  #   online_count = ChatParticipant.where( chat_room_id: chat_room_id, status: 'online' ).count
  #   OnlineBroadcastJob.perform_later(data['chat_room_id'], current_user.id, 'left', online_count)
  # end
end