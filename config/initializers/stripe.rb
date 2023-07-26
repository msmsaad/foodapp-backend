# frozen_string_literal: true

unless Rails.env.test?
  Stripe.api_key = FoodappBackend::Application.credentials[Rails.env.to_sym][:stripe][:secret_key]
end