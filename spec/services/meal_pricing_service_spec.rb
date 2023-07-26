# frozen_string_literal: true

require "rails_helper"

RSpec.describe MealPricingService do
  let(:meals) { [JSON.parse(Rails.root.join("spec/fixtures/beef_meals.json").read)["meals"].first] }

  describe "#call" do
    context "when the category is lamb" do
      let(:service) { described_class.new(meals: meals, category: "lamb") }

      it "sets the price between 50 and 100" do
        service.call
        price = Meal.last.price
        expect(price.to_f).to be_between(50, 100)
      end
    end

    context "when the category is beef" do
      let(:service) { described_class.new(meals: meals, category: "beef") }

      it "sets the price between 40 and 50" do
        service.call
        price = Meal.last.price
        expect(price.to_f).to be_between(40, 50)
      end
    end

    context "when the category is pork" do
      let(:service) { described_class.new(meals: meals, category: "pork") }

      it "sets the price between 30 and 40" do
        service.call
        price = Meal.last.price
        expect(price.to_f).to be_between(30, 40)
      end
    end

    context "when the category is something else" do
      let(:service) { described_class.new(meals: meals, category: "breakfast") }

      it "sets the price between 1 and 30" do
        service.call
        price = Meal.last.price
        expect(price.to_f).to be_between(1, 30)
      end
    end
  end
end
