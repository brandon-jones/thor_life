require 'rails_helper'

RSpec.describe "user_game_ids/show", :type => :view do
  before(:each) do
    @user_game_id = assign(:user_game_id, UserGameId.create!(
      :game_id => 1,
      :in_game_name => "In Game Name",
      :user_id => 2,
      :banned => false,
      :permma_banned => false,
      :user_verified => false,
      :verified_by => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/In Game Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/3/)
  end
end
