json.array!(@perks) do |perk|
  json.extract! perk, :id, :title, :game_instance_id, :description, :price, :game_id
  json.url perk_url(perk, format: :json)
end
