# frozen_string_literal: true

module Api
  module V1
    class BaseController < Api::BaseController
      include Pagy::Backend
    end
  end
end
