# frozen_string_literal: true

FactoryBot.define do
  factory :ordered_meal do
    price_cents { 1000 }
    order
    meal
  end
end
