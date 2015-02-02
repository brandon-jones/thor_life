require "rails_helper"

RSpec.describe AdminRolesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/admin_roles").to route_to("admin_roles#index")
    end

    it "routes to #new" do
      expect(:get => "/admin_roles/new").to route_to("admin_roles#new")
    end

    it "routes to #show" do
      expect(:get => "/admin_roles/1").to route_to("admin_roles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/admin_roles/1/edit").to route_to("admin_roles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/admin_roles").to route_to("admin_roles#create")
    end

    it "routes to #update" do
      expect(:put => "/admin_roles/1").to route_to("admin_roles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/admin_roles/1").to route_to("admin_roles#destroy", :id => "1")
    end

  end
end
