json.array!(@topics) do |topic|
  json.extract! topic, :id, :grouping_id, :title, :created_by, :sticky, :order, :body, :locked, :deleted, :deleted_by, :last_updated, :forum_id
  json.url topic_url(topic, format: :json)
end
