json.extract! lesson, :id, :title, :content, :video_html, :unit_id, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
