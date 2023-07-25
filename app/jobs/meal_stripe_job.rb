# frozen_string_literal: true

class MealStripeJob < ApplicationJob
  queue_as :default

  def perform(meal_id:)
    # TODO: following code should be in the service
    meal = Meal.find(meal_id)

    product = Stripe::Product.create({ name: meal.title, metadata: { meal_id: meal.id } })
    price = Stripe::Price.create({ unit_amount: meal.price_cents, currency: "usd", product: product.id })

    meal.update(stripe_product_id: product.id, stripe_price_id: price.id)
  end
end
