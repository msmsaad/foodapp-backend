# frozen_string_literal: true

class TheMealDbService
  CACHE_EXPIRY = 1.hour

  attr_reader :url

  def initialize
    @url = "https://www.themealdb.com/api/json/v1/1"
  end

  def categories
    Rails.cache.fetch("categories", expires_in: CACHE_EXPIRY) do
      response = ::HTTParty.get("#{url}/categories.php")

      JSON.parse(response.body)
    rescue => e
      Rails.logger.error "Error getting data from Category API: #{e.message}"
      []
    end
  end

  def meals(category:)
    Rails.cache.fetch(category, expires_in: CACHE_EXPIRY) do
      response = ::HTTParty.get("#{url}/filter.php?c=#{category}")

      JSON.parse(response.body)
    rescue => e
      Rails.logger.error "Error getting data from Meal API: #{e.message}"
      []
    end
  end
end
