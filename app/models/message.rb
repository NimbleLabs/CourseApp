# == Schema Information
#
# Table name: messages
#
#  id              :bigint(8)        not null, primary key
#  body            :text
#  status          :string
#  conversation_id :bigint(8)
#  user_id         :integer
#  visitor_id      :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Message < ApplicationRecord
  belongs_to :conversation

  validates_presence_of :conversation_id

  after_create_commit do
    if Rails.env.development?
      channel_name = "conversations_#{conversation_id}_channel"
      ActionCable.server.broadcast channel_name, type: 'chat', message: self
    end
  end

  def from
    return 'Visitor' if visitor_id.present?
    user = User.find(user_id )
    user.full_name
  end
end
