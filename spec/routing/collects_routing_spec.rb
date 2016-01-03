require "rails_helper"

RSpec.describe CollectsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/collects").to route_to("collects#index")
    end

    it "routes to #new" do
      expect(:get => "/collects/new").to route_to("collects#new")
    end

    it "routes to #show" do
      expect(:get => "/collects/1").to route_to("collects#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/collects/1/edit").to route_to("collects#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/collects").to route_to("collects#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/collects/1").to route_to("collects#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/collects/1").to route_to("collects#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/collects/1").to route_to("collects#destroy", :id => "1")
    end

  end
end
