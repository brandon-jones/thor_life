FactoryGirl.define do
  factory :cart do
    user_id 1
    total_in_cents 0
    delivered false
  end
end
