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

  default_scope {order('index ASC')}

  def free?
    self.availability == Lesson::FREE
  end

  def signed_up?
    self.availability == Lesson::SIGNUP
  end

  def pro?
    self.availability == Lesson::PRO
  end

  def prev?
    self.index > 1
  end

  def next?
    self.index < self.unit.lessons.count
  end

  def prev
    self.unit.lessons.where(index: self.index - 1).first
  end

  def next
    self.unit.lessons.where(index: self.index + 1).first
  end

end
