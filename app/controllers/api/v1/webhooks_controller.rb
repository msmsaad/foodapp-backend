# frozen_string_literal: true

module Api
  module V1
    class WebhooksController < BaseController
      before_action :verify_signature_account, only: [:stripe]

      def stripe
        cart = Cart.includes(:carts_meals).find_by(id: params["data"]["object"]["metadata"]["cart_id"])
        user = User.find_by(id: params["data"]["object"]["metadata"]["user_id"])

        return render json: { error: "Cart or User not found." }, status: :not_found unless cart && user

        order = user.orders.build(stripe_payment_id: params[:data]["object"]["payment_intent"])
        cart.carts_meals.each do |carts_meal|
          order.ordered_meals.build(
            quantity: carts_meal.quantity,
            price_cents: carts_meal.meal.price_cents,
            meal: carts_meal.meal
          )
        end

        if order.save
          cart.destroy
          render json: { message: "Order created successfully." }, status: :ok
        else
          render json: { error: "Failed to create order. #{order.errors.full_messages}" }, status: :unprocessable_entity
        end
      end

      private

      def verify_signature_account
        Stripe::Webhook.construct_event(
          request.body.read,
          request.env["HTTP_STRIPE_SIGNATURE"],
          FoodappBackend::Application.credentials[Rails.env.to_sym][:stripe][:wh_secret],
        )
      rescue Stripe::SignatureVerificationError
        render json: { error: "Webhook signature verification failed." }, status: :unauthorized
      end
    end
  end
end
