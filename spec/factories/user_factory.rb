FactoryGirl.define do
  factory :user do
    name "John Doe"
    password "password"
    password_confirmation "password"
    sequence(:email) { |n| "johndoe#{n}@example.com" }
  end
end
