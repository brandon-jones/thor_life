require "rails_helper"

RSpec.describe UserGameIdsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/user_game_ids").to route_to("user_game_ids#index")
    end

    it "routes to #new" do
      expect(:get => "/user_game_ids/new").to route_to("user_game_ids#new")
    end

    it "routes to #show" do
      expect(:get => "/user_game_ids/1").to route_to("user_game_ids#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/user_game_ids/1/edit").to route_to("user_game_ids#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/user_game_ids").to route_to("user_game_ids#create")
    end

    it "routes to #update" do
      expect(:put => "/user_game_ids/1").to route_to("user_game_ids#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/user_game_ids/1").to route_to("user_game_ids#destroy", :id => "1")
    end

  end
end
