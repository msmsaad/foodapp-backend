class Meal < ApplicationRecord
  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }
end
