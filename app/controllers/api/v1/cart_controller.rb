# frozen_string_literal: true

module Api
  module V1
    class CartController < BaseController
      before_action :authenticate_user!
      before_action :find_cart

      def show
        render json: @cart
      end

      def update
        if @cart.update(cart_params)
          render json: @cart
        else
          render json: { errors: @cart.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def cart_params
        params.require(:carts_meals).permit(carts_meals_attributes: [:id, :meal_id, :quantity, :_destroy])
      end

      def find_cart
        @cart = current_user.cart || Cart.new(user: current_user)
      end
    end
  end
end
