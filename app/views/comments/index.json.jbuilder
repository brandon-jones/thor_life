json.array!(@comments) do |comment|
  json.extract! comment, :id, :created_by, :body, :topic_id, :deleted, :deleted_by
  json.url comment_url(comment, format: :json)
end
