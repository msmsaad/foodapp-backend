# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  has_many :ordered_meals, dependent: :destroy

  validates :stripe_payment_id, presence: true
  validates :stripe_payment_id, uniqueness: true
end
