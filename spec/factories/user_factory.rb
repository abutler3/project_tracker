FactoryGirl.define do
  factory :user do
    name "username"
    password "hunter2"
    password_confirmation "hunter2"
    # sequence(:email) { |n| "johndoe#{n}@example.com" }
    email "sample@example.com"

    factory :admin_user do
      admin true
    end
  end
end
