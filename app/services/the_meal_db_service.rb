# frozen_string_literal: true

class TheMealDbService
  def initialize
    @url = "https://www.themealdb.com/api/json/v1/1"
  end

  def categories
    response = ::HTTParty.get("#{@url}/categories.php")

    JSON.parse(response.body)
  rescue => e
    Rails.logger.error "Error getting data from API: #{e.message}"
    []
  end
end
