# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "csv"

CSV.foreach(Rails.root.join("db/seeds/seasonings.csv"), headers: true) do |row|
  seasoning = Seasoning.find_or_initialize_by(name: row["name"])
  seasoning.category = row["category"]
  seasoning.min_expiry_days = row["min_expiry_days"]
  seasoning.max_expiry_days = row["max_expiry_days"]
  seasoning.save!
  puts "#{seasoning.name}を登録/更新"
end

puts "seasonings.csv の登録が正常に完了"