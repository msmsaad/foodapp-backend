# frozen_string_literal: true

class OrderedMeal < ApplicationRecord
  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  belongs_to :order
end
