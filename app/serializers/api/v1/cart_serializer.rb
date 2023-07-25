# frozen_string_literal: true

module Api
  module V1
    class CartSerializer < ActiveModel::Serializer
      attributes :id, :created_at, :updated_at

      has_many :carts_meals
    end
  end
end
