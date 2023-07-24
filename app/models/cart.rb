class Cart < ApplicationRecord
  belongs_to :user

  has_many :carts_meals
end
