class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:google_oauth2]
  enum role: [:user, :owner, :admin]

  validates_presence_of :full_name
  after_create :on_after_create

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
    user
  end
end
