# frozen_string_literal: true

FactoryBot.define do
  factory :meal do
    title { Faker::Food.dish }
    thumbnail { Faker::LoremFlickr.image }
    price_cents { 1000 }
  end
end
