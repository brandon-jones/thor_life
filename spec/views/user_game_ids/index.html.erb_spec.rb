require 'rails_helper'

RSpec.describe "user_game_ids/index", :type => :view do
  before(:each) do
    assign(:user_game_ids, [
      UserGameId.create!(
        :game_id => 1,
        :in_game_name => "In Game Name",
        :user_id => 2,
        :banned => false,
        :permma_banned => false,
        :user_verified => false,
        :verified_by => 3
      ),
      UserGameId.create!(
        :game_id => 1,
        :in_game_name => "In Game Name",
        :user_id => 2,
        :banned => false,
        :permma_banned => false,
        :user_verified => false,
        :verified_by => 3
      )
    ])
  end

  it "renders a list of user_game_ids" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "In Game Name".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
