json.array!(@game_instances) do |game_instance|
  json.extract! game_instance, :id, :game_id, :server_name, :server_address, :server_port, :mod_list
  json.url game_instance_url(game_instance, format: :json)
end
