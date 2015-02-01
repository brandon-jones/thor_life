json.array!(@users) do |user|
  json.extract! user, :id, :password_digest, :name, :email, :email_public, :email_verified, :phone_number, :phone_provider, :about_me, :banned, :permma_banned, :banned_by, :customer_id
  json.url user_url(user, format: :json)
end
