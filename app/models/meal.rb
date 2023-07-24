# frozen_string_literal: true

class Meal < ApplicationRecord
  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  has_many :carts_meals, dependent: :destroy
end
