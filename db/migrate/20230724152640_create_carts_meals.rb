class CreateCartsMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :carts_meals do |t|
      t.references :cart, null: false, foreign_key: true
      t.references :meal, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
  end
end
