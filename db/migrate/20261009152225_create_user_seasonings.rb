class CreateUserSeasonings < ActiveRecord::Migration[8.1]
  def change
    create_table :user_seasonings do |t|
      t.references :user, null: false, foreign_key: true
      t.references :seasoning, null: false, foreign_key: true
      t.date :expiry_date

      t.timestamps
    end

    add_index :user_seasonings, [:user_id, :seasoning_id], unique: true
  end
end
