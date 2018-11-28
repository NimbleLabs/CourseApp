class Photo < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]
  has_one_attached :image
  before_validation :on_before_validation

  def on_before_validation
    self.name = image.filename.base if self.name.blank?
    self.slug = self.name.parameterize if self.slug.blank?
  end
end
