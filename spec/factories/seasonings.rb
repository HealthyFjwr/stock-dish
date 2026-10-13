FactoryBot.define do
  factory :seasoning do
    name { "MyString" }
    category { 1 }
    min_expiry_days { 1 }
    max_expiry_days { 1 }
  end
end
