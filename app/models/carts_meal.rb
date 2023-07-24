# frozen_string_literal: true

class CartsMeal < ApplicationRecord
  belongs_to :cart
  belongs_to :meal
end
