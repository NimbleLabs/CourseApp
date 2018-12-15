# == Schema Information
#
# Table name: courses
#
#  id          :bigint(8)        not null, primary key
#  title       :string
#  description :text
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  validates_presence_of :title
  validates_presence_of :description

  has_one_attached :image
  has_many :units, dependent: :destroy

  def video_count
    count = 0
    self.units.each { |unit| count += unit.video_count }
    count
  end
end
