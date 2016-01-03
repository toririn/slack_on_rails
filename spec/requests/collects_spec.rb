require 'rails_helper'

RSpec.describe "Collects", type: :request do
  describe "GET /collects" do
    it "works! (now write some real specs)" do
      get collects_path
      expect(response).to have_http_status(200)
    end
  end
end
