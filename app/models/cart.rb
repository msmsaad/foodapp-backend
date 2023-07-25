# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user

  has_many :carts_meals, dependent: :destroy

  accepts_nested_attributes_for :carts_meals, allow_destroy: true
end
