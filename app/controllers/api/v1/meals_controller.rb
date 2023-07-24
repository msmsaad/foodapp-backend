# frozen_string_literal: true

module Api
  module V1
    class MealsController < BaseController
      def index
        api_service = ::TheMealDbService.new

        @data = api_service.meals(category: params[:category])

        @pagy, @meals = pagy_array(@data["meals"], page: params[:page] || 1)

        # 2. determine prices

        # 3. merge prices and other data

        render json: {
          pagy: { current_page: @pagy.page, total_pages: @pagy.pages },
          meals: @meals,
        }
      end
    end
  end
end
