FactoryGirl.define do
  factory :forum do
    title: Faker::Lorem.sentence(3, false, 15)
  end
end
