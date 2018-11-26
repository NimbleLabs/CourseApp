class Unit < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  validates_presence_of :title
  validates_presence_of :description
  validates_presence_of :course

  belongs_to :course
  has_many :lessons, dependent: :destroy

  def video_count
    self.lessons.select { |lesson|  lesson.video.attached? }.count
  end
end
