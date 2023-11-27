require "rails_helper"

RSpec.describe "Pages", type: :request do
  describe "GET /" do
    it "will return a 200 response status" do
      get root_path
      expect(response).to have_http_status(:success)
    end

    it "will contain Rails Beginnings" do
      get root_path
      expect(response.body).to include("Rails Beginnings")
    end
  end
end
