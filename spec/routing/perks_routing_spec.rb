require "rails_helper"

RSpec.describe PerksController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/perks").to route_to("perks#index")
    end

    it "routes to #new" do
      expect(:get => "/perks/new").to route_to("perks#new")
    end

    it "routes to #show" do
      expect(:get => "/perks/1").to route_to("perks#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/perks/1/edit").to route_to("perks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/perks").to route_to("perks#create")
    end

    it "routes to #update" do
      expect(:put => "/perks/1").to route_to("perks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/perks/1").to route_to("perks#destroy", :id => "1")
    end

  end
end
