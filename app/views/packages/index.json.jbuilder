json.array!(@packages) do |package|
  json.extract! package, :id, :title, :price, :perk_ids
  json.url package_url(package, format: :json)
end
