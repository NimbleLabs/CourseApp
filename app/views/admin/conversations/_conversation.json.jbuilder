json.extract! conversation, :id, :status, :uuid, :created_at, :updated_at
json.url conversation_url(conversation, format: :json)
