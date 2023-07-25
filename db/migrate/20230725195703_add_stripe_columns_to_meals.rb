# frozen_string_literal: true

class AddStripeColumnsToMeals < ActiveRecord::Migration[7.0]
  def change
    change_table :meals, bulk: true do |t|
      t.string :stripe_product_id
      t.string :stripe_price_id
    end
  end
end
