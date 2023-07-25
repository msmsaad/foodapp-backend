# frozen_string_literal: true

Stripe.api_key = FoodappBackend::Application.credentials[Rails.env.to_sym][:stripe][:secret_key]
