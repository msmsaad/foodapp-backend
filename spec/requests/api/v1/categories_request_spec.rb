# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Api::V1::Categories" do
  let(:mocked_data) { Rails.root.join("spec/fixtures/categories.json").read }

  describe "GET /api/v1/categories" do
    before do
      service = instance_double(TheMealDbService)
      allow(TheMealDbService).to receive(:new).and_return(service)
      allow(service).to receive(:categories).and_return(mocked_data)
      get "/api/v1/categories"
    end

    it "returns success status" do
      expect(response).to have_http_status(:success)
    end

    it "returns the correct response body" do
      expect(response.body).to eq(mocked_data)
    end
  end
end
