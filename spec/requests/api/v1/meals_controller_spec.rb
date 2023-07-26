# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::MealsController, type: :controller do
  let(:api_service) { instance_double(TheMealDbService) }
  let(:category) { "beef" }
  let(:meals) { JSON.parse(Rails.root.join("spec/fixtures/beef_meals.json").read) }

  before do
    allow(TheMealDbService).to receive(:new).and_return(api_service)
    allow(api_service).to receive(:meals).and_return(meals)
  end

  describe "GET /" do
    it "prices of the meals do not change on multiple requests" do
      get :index, params: { category: category }
      json = response.parsed_body

      first_request_prices = json["meals"].pluck("price")

      get :index, params: { category: category }
      json = response.parsed_body

      second_request_prices = json["meals"].pluck("price")

      expect(first_request_prices).to eq(second_request_prices)
    end
  end
end
