# frozen_string_literal: true

class AddBasicDataColumnsToMeals < ActiveRecord::Migration[7.0]
  def change
    change_table :meals, bulk: true do |t|
      t.string :title
      t.string :thumbnail
    end
  end
end
