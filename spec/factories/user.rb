# This will guess the User class
FactoryGirl.define do
  factory :user do
    email "email@email.com"
    password "password"
    password_confirmation "password"
    confirmed_at DateTime.now
  end
end
