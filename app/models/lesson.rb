class Lesson < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  belongs_to :unit

  has_one_attached :video
end
