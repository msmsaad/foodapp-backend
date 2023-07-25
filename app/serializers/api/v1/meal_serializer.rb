# frozen_string_literal: true

module Api
  module V1
    class MealSerializer < ActiveModel::Serializer
      attributes :id, :title, :thumbnail, :price

      def price
        object.price.to_f
      end
    end
  end
end
