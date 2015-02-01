FactoryGirl.define do
  factory :static_user do
    password_digest "password"
    username "username"
    email "email"
    phone_number ""
    phone_provider ""
    about_me "test bio"
    customer_id ''
  end

  factory :user do
    password Faker::Internet.password(8)
    email Faker::Internet.safe_email
  end
end
