FactoryBot.define do
  factory :user do
    sequence(:username) { |n| format("user%02d", n) }
    sequence(:email) { |n| format("test%02d@example.com", n) }
    sequence(:password) { |n| "password#{n}" }

    trait :invalid_email do
      email { "invalid_email_format" }
    end
  end
end
