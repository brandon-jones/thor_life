require 'rails_helper'

RSpec.describe "user_game_ids/new", :type => :view do
  before(:each) do
    assign(:user_game_id, UserGameId.new(
      :game_id => 1,
      :in_game_name => "MyString",
      :user_id => 1,
      :banned => false,
      :permma_banned => false,
      :user_verified => false,
      :verified_by => 1
    ))
  end

  it "renders new user_game_id form" do
    render

    assert_select "form[action=?][method=?]", user_game_ids_path, "post" do

      assert_select "input#user_game_id_game_id[name=?]", "user_game_id[game_id]"

      assert_select "input#user_game_id_in_game_name[name=?]", "user_game_id[in_game_name]"

      assert_select "input#user_game_id_user_id[name=?]", "user_game_id[user_id]"

      assert_select "input#user_game_id_banned[name=?]", "user_game_id[banned]"

      assert_select "input#user_game_id_permma_banned[name=?]", "user_game_id[permma_banned]"

      assert_select "input#user_game_id_user_verified[name=?]", "user_game_id[user_verified]"

      assert_select "input#user_game_id_verified_by[name=?]", "user_game_id[verified_by]"
    end
  end
end
