# frozen_string_literal: true

module Api
  module V1
    class MealsController < BaseController
      def index
        api_service = ::TheMealDbService.new

        @meals = api_service.meals(category: params[:category])

        # 1. paginate meals

        # 2. determine prices

        # 3. merge prices and other data

        render json: @meals
      end
    end
  end
end
