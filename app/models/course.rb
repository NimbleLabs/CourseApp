class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  validates_presence_of :title
  validates_presence_of :description

  has_one_attached :image
  has_many :units, dependent: :destroy
end
