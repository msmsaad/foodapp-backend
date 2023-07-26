# frozen_string_literal: true

class AddMealToOrderedMeals < ActiveRecord::Migration[7.0]
  def change
    # rubocop:disable Rails/NotNullColumn
    add_reference :ordered_meals, :meal, null: false, foreign_key: true
    # rubocop:enable Rails/NotNullColumn
  end
end
