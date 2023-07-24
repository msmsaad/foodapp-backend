# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user

  has_many :ordered_meals, dependent: :destroy
end
