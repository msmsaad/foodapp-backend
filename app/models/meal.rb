# frozen_string_literal: true

class Meal < ApplicationRecord
  monetize :price_cents, numericality: { greater_than_or_equal_to: 0 }

  after_create :create_product_and_price_on_stripe
  has_many :carts_meals, dependent: :destroy

  validates :title, :thumbnail, presence: true

  private

  def create_product_and_price_on_stripe
    # do this in the background job
    product = Stripe::Product.create({ name: title, metadata: { meal_id: id } })
    price = Stripe::Price.create({ unit_amount: price_cents, currency: "usd", product: product.id })

    update(stripe_product_id: product.id, stripe_price_id: price.id)
  end
end
