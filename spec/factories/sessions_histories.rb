# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sessions_history do
    ip "MyString"
    header "MyString"
    user_id 1
  end
end
