require 'rails_helper'

RSpec.describe "Drivers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/drivers/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/drivers/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/drivers/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/drivers/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /cancel" do
    it "returns http success" do
      get "/drivers/cancel"
      expect(response).to have_http_status(:success)
    end
  end

end
