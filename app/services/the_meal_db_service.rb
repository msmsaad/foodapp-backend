# frozen_string_literal: true

class TheMealDbService
  attr_reader :url

  def initialize
    @url = "https://www.themealdb.com/api/json/v1/1"
  end

  def categories
    response = ::HTTParty.get("#{url}/categories.php")

    JSON.parse(response.body)
  rescue => e
    Rails.logger.error "Error getting data from Category API: #{e.message}"
    []
  end

  def meals(category:)
    response = ::HTTParty.get("#{url}/filter.php?c=#{category}")

    JSON.parse(response.body)
  rescue => e
    Rails.logger.error "Error getting data from Meal API: #{e.message}"
    []
  end
end
