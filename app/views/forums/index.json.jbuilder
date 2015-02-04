json.array!(@forums) do |forum|
  json.extract! forum, :id, :parent_id, :order, :created_by, :title, :deleted_by, :grouping_id, :locked, :admins_only, :main_feed, :deleted, :last_updated
  json.url forum_url(forum, format: :json)
end
