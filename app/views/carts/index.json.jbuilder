json.array!(@carts) do |cart|
  json.extract! cart, :id, :user_id, :total, :delivered, :delivered_by
  json.url cart_url(cart, format: :json)
end
