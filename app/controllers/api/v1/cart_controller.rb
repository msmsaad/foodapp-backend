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

      def checkout
        data = {
          success_url: params[:success_url],
          metadata: {
            cart_id: @cart.id,
            user_id: current_user.id,
          },
          mode: "payment",
          line_items: @cart.carts_meals.map do |carts_meal|
            {
              price: carts_meal.meal.stripe_price_id,
              quantity: carts_meal.quantity,
            }
          end,
        }

        checkout = Stripe::Checkout::Session.create(data)

        render json: { checkout_url: checkout.url }
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
