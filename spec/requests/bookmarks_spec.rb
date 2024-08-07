require 'rails_helper'

RSpec.describe "Bookmarks", type: :request do
  describe "GET /new" do
    it "returns http success" do
      get "/bookmarks/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/bookmarks/edit"
      expect(response).to have_http_status(:success)
    end
  end

end
