FactoryGirl.define do
  sequence(:email) { |n| "user#{n}@example.com" }

  factory :user do
    name "username"
    email { generate(:email) }
    password "hunter2"
    password_confirmation "hunter2"
    # sequence(:email) { |n| "johndoe#{n}@example.com" }
    factory :admin_user do
      admin true
    end
  end
end
