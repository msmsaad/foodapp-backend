# frozen_string_literal: true

class MealPricingService
  attr_reader :meals, :category

  def initialize(meals:, category:)
    @meals = meals
    @category = category
  end

  def call
    @meals = meals.each do |item|
      meal = Meal.find_or_initialize_by(id: item["idMeal"]) do |new_meal|
        new_meal.price = get_price(category: category)
      end

      meal.save unless meal.persisted?

      item["price"] = meal.price.to_f
    end
  end

  private

  def get_price(category:)
    case category.downcase
    when "lamb"
      rand(50..100)
    when "beef"
      rand(40..50)
    when "pork"
      rand(30..40)
    else
      rand(1..30)
    end
  end
end
