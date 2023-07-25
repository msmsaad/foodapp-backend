# frozen_string_literal: true

module Api
  module V1
    class MealsController < BaseController
      def index
        api_service = ::TheMealDbService.new

        @data = api_service.meals(category: params[:category])

        @pagy, @items = pagy_array(@data["meals"], page: params[:page] || 1)

        @items = ::MealPricingService.new(meals: @items, category: params[:page]).call

        render json: {
          pagy: { current_page: @pagy.page, total_pages: @pagy.pages },
          meals: @items,
        }
      end
    end
  end
end
