json.array!(@cart_items) do |cart_item|
  json.extract! cart_item, :id, :item_id, :item_type, :string, :price, :cart_id
  json.url cart_item_url(cart_item, format: :json)
end
