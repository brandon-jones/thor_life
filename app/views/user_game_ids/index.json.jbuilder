json.array!(@user_game_ids) do |user_game_id|
  json.extract! user_game_id, :id, :game_id, :in_game_name, :user_id, :banned, :permma_banned, :user_verified, :verified_by
  json.url user_game_id_url(user_game_id, format: :json)
end
