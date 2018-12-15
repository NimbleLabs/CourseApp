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

  def from
    return 'Visitor' if visitor_id.present?
    user = User.find(user_id )
    user.full_name
  end
end
