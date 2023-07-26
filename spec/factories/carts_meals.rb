# frozen_string_literal: true

FactoryBot.define do
  factory :carts_meal do
    quantity { Faker::Number.between(from: 1, to: 10) }
    cart
    meal
  end
end
