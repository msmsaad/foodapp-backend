# frozen_string_literal: true

class AddStripePaymentIdToOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :orders, :stripe_payment_id, :string
    add_index :orders, :stripe_payment_id, unique: true
  end
end
