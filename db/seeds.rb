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
  # use row here...
  Seasoning.find_or_create_by!(name: row["name"]) do |seasoning|
    seasoning.category = row["category"]
    seasoning.min_expiry_days = row["min_expiry_days"]
    seasoning.max_expiry_days = row["max_expiry_days"]
    puts "#{seasoning.name}を追加"
  end
end

puts "seasonings.csv の登録が正常に完了"