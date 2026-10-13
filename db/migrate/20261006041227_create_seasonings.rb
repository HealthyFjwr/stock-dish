class CreateSeasonings < ActiveRecord::Migration[8.1]
  def change
    create_table :seasonings do |t|
      t.string :name, null: false
      t.integer :category, null:false
      t.integer :min_expiry_days
      t.integer :max_expiry_days

      t.timestamps
    end

    add_index :seasonings, :name, unique: true
  end
end
