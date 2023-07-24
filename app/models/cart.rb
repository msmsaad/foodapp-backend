# frozen_string_literal: true

class Cart < ApplicationRecord
  belongs_to :user

  has_many :carts_meals, dependent: :destroy
end
