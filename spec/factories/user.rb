FactoryGirl.define do
  factory :user do
    password Faker::Internet.password(8)
    email Faker::Internet.safe_email
  end
end
