class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
  belongs_to :unit
  has_one_attached :image
  has_one_attached :video

  FREE = 'free'
  SIGNUP = 'signup'
  PRO = 'pro'
  AVAILABILITY_OPTIONS = [Lesson::FREE, Lesson::SIGNUP, Lesson::PRO]

  def free?
    self.availability == Lesson::FREE
  end

  def signed_up?
    self.availability == Lesson::SIGNUP
  end

  def pro?
    self.availability == Lesson::PRO
  end

end
