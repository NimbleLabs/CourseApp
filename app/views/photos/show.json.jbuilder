json.extract! @photo, :id, :created_at, :updated_at
json.url photo_url(@photo, format: :html)
json.image_url url_for(@photo.image)
