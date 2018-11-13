class Course < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: [:slugged, :finders]
end
