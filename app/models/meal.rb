# frozen_string_literal: true

class Meal < ApplicationRecord
  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  after_create :create_product_and_price_on_stripe
  has_many :carts_meals, dependent: :destroy

  validates :title, :thumbnail, presence: true

  private

  def create_product_and_price_on_stripe
    MealStripeJob.perform_later(meal_id: id)
  end
end
