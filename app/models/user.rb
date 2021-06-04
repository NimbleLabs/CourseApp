# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  role                   :integer          default("user")
#  auth_token             :string
#  stripe_customer_id     :string
#  source                 :string
#  provider               :string
#  uid                    :string
#  image                  :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  full_name              :string
#  stripe_subscription_id :string
#  stripe_charge_id       :string
#  visitor_id             :string
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  # devise :omniauthable, omniauth_providers: [:google_oauth2]
  enum role: [:user, :owner, :admin]
  has_many :credit_cards, dependent: :destroy
  validates_presence_of :full_name
  after_create :on_after_create

  def customer?
    self.stripe_customer_id.present? && (self.stripe_subscription_id.present? || self.stripe_charge_id.present?)
  end

  def on_after_create
    UserMailer.with(user: self).welcome_email.deliver_later
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(
          full_name: data['name'],
          email: data['email'],
          password: Devise.friendly_token[0, 20],
          image: data['image']
      )
    end

    user.update_attributes(full_name: data['name']) if user.full_name.blank?
    user
  end
end
