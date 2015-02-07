require 'rails_helper'

RSpec.describe "game_instances/new", :type => :view do
  before(:each) do
    assign(:game_instance, GameInstance.new(
      :game_id => 1,
      :server_name => "MyString",
      :server_address => "MyString",
      :server_port => 1,
      :modlist => "MyText"
    ))
  end

  it "renders new game_instance form" do
    render

    assert_select "form[action=?][method=?]", game_instances_path, "post" do

      assert_select "input#game_instance_game_id[name=?]", "game_instance[game_id]"

      assert_select "input#game_instance_server_name[name=?]", "game_instance[server_name]"

      assert_select "input#game_instance_server_address[name=?]", "game_instance[server_address]"

      assert_select "input#game_instance_server_port[name=?]", "game_instance[server_port]"

      assert_select "textarea#game_instance_modlist[name=?]", "game_instance[modlist]"
    end
  end
end
