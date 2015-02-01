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
  	password_digest Faker::Internet.password(8)
    username Faker::Internet.user_name
    email Faker::Internet.safe_email
    phone_number ['',Faker::Number.number(10)].sample
    phone_provider ['verizion','att'].sample
    about_me "test bio"
    customer_id ''
  end
end
