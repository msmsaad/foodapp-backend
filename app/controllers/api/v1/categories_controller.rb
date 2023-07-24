# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < BaseController
      def index
        api_service = ::TheMealDbService.new

        @categories = api_service.categories

        render json: @categories
      end
    end
  end
end
