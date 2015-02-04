require "rails_helper"

RSpec.describe GroupingsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/groupings").to route_to("groupings#index")
    end

    it "routes to #new" do
      expect(:get => "/groupings/new").to route_to("groupings#new")
    end

    it "routes to #show" do
      expect(:get => "/groupings/1").to route_to("groupings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/groupings/1/edit").to route_to("groupings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/groupings").to route_to("groupings#create")
    end

    it "routes to #update" do
      expect(:put => "/groupings/1").to route_to("groupings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/groupings/1").to route_to("groupings#destroy", :id => "1")
    end

  end
end
