# == Schema Information
#
# Table name: credit_cards
#
#  id            :bigint(8)        not null, primary key
#  name_on_card  :string
#  card_number   :string
#  exp_month     :integer
#  exp_year      :integer
#  cvc           :string
#  zip_code      :string
#  card_type     :string
#  stripe_id     :string
#  last_4_digits :string
#  cvc_check     :string
#  user_id       :bigint(8)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CreditCard < ActiveRecord::Base
  belongs_to :user
  # validates_presence_of :name_on_card
  validates_presence_of :card_number
  validates_presence_of :exp_month
  validates_presence_of :exp_year
  validates_presence_of :cvc
end
