FactoryGirl.define do
  factory :cart_item do
    item_id 1
    item_type 'Perk'
    price_in_cents 420
    cart_id 1
  end
end
