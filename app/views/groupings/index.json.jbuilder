json.array!(@groupings) do |grouping|
  json.extract! grouping, :id, :title
  json.url grouping_url(grouping, format: :json)
end
