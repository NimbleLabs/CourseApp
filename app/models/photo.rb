# == Schema Information
#
# Table name: photos
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

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
