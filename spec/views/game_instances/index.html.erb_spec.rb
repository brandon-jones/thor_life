require 'rails_helper'

RSpec.describe "game_instances/index", :type => :view do
  before(:each) do
    assign(:game_instances, [
      GameInstance.create!(
        :game_id => 1,
        :server_name => "Server Name",
        :server_address => "Server Address",
        :server_port => 2,
        :modlist => "MyText"
      ),
      GameInstance.create!(
        :game_id => 1,
        :server_name => "Server Name",
        :server_address => "Server Address",
        :server_port => 2,
        :modlist => "MyText"
      )
    ])
  end

  it "renders a list of game_instances" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Server Name".to_s, :count => 2
    assert_select "tr>td", :text => "Server Address".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
