# frozen_string_literal: true

require "rails_helper"

RSpec.describe Api::V1::WebhooksController, type: :controller do
  describe "POST #stripe" do
    before do
      allow(Stripe::Webhook).to receive(:construct_event).with(any_args).and_return(true)
    end

    let(:user) { create(:user) }
    let(:cart) { create(:cart, user: user) }
    let(:meal) { create(:meal) }
    let!(:carts_meal) { create(:carts_meal, cart: cart, meal: meal) }

    let(:stripe_payment_id) { "pi_1J4HM1Ith42PmuG4N4CX8oHd" }
    let(:metadata) { { "cart_id" => cart.id, "user_id" => user.id } }
    let(:params) do
      {
        "data" => {
          "object" => {
            "payment_intent" => stripe_payment_id,
            "metadata" => metadata,
          },
        },
      }
    end

    context "when cart and user are found" do
      it "creates an order and returns success message" do
        post :stripe, params: params
        expect(response).to have_http_status(:ok)
        expect(response.parsed_body["message"]).to eq("Order created successfully.")
        expect(Order.exists?(stripe_payment_id: stripe_payment_id)).to be true
        expect(Cart.exists?(cart.id)).to be false
      end
    end

    context "when cart or user is not found" do
      let(:metadata) { { "cart_id" => -1, "user_id" => -1 } }

      it "returns not found error" do
        post :stripe, params: params
        expect(response).to have_http_status(:not_found)
        expect(response.parsed_body["error"]).to eq("Cart or User not found.")
      end
    end

    context "when order creation fails" do
      let(:stripe_payment_id) { nil }

      it "returns unprocessable entity error" do
        post :stripe, params: params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.parsed_body["error"]).to start_with("Failed to create order.")
      end
    end
  end
end
