# frozen_string_literal: true

class CreateOrderedMeals < ActiveRecord::Migration[7.0]
  def change
    create_table :ordered_meals do |t|
      t.integer :quantity, null: false, default: 1
      t.monetize :price
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
