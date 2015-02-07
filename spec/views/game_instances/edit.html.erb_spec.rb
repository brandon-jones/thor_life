require 'rails_helper'

RSpec.describe "game_instances/edit", :type => :view do
  before(:each) do
    @game_instance = assign(:game_instance, GameInstance.create!(
      :game_id => 1,
      :server_name => "MyString",
      :server_address => "MyString",
      :server_port => 1,
      :mod_list => "MyText"
    ))
  end

  it "renders the edit game_instance form" do
    render

    assert_select "form[action=?][method=?]", game_instance_path(@game_instance), "post" do

      assert_select "input#game_instance_game_id[name=?]", "game_instance[game_id]"

      assert_select "input#game_instance_server_name[name=?]", "game_instance[server_name]"

      assert_select "input#game_instance_server_address[name=?]", "game_instance[server_address]"

      assert_select "input#game_instance_server_port[name=?]", "game_instance[server_port]"

      assert_select "textarea#game_instance_mod_list[name=?]", "game_instance[mod_list]"
    end
  end
end
