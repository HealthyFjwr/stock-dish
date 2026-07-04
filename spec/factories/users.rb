FactoryBot.define do
  factory :user do
    username { "user01" }
    email { "test01@example.com" }
    password { "password01" }

    trait :invalid_email do
      email { "invalid_email_format" }
    end
  end
end
