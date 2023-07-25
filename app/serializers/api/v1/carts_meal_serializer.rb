# frozen_string_literal: true

module Api
  module V1
    class CartsMealSerializer < ActiveModel::Serializer
      attributes :id, :quantity, :meal

      def meal
        MealSerializer.new(object.meal)
      end
    end
  end
end
