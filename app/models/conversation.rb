# == Schema Information
#
# Table name: conversations
#
#  id         :bigint(8)        not null, primary key
#  status     :string
#  uuid       :string
#  user_id    :integer
#  visitor_id :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Conversation < ApplicationRecord
  has_many :messages

  validates_uniqueness_of :user_id, scope: :visitor_id
  validates_uniqueness_of :visitor_id

  before_create :on_before_create

  def on_before_create
    begin
      self.uuid = SecureRandom.hex.to_s
    end while self.class.exists?(uuid: uuid)
  end

  def participant_type
    visitor_id.present? ? 'Visitor' : 'User'
  end

  def participant_id
    visitor_id.present? ? visitor_id : user_id
  end

  def new_message(message)
    if user_id.present?
      return Message.create(conversation: self, status: 'created', user_id: user_id, body: message)
    end

    Message.create(conversation: self, status: 'created', visitor_id: visitor_id, body: message)
  end

  def message_from_user(user, message)
    Message.create(conversation: self, status: 'created', user_id: user.id, body: message)
  end

  def message_from_visitor(visit, message)
    Message.create(conversation: self, status: 'created', visitor_id: visit.visitor_id, body: message)
  end

  def self.from_user(user)
    where(user_id: user.id).first
  end

  def self.from_visit(visitor_id)
    where(visitor_id: visitor_id).first
  end
end
