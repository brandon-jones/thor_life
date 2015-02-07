require 'rails_helper'

RSpec.describe "perks/index", :type => :view do
  before(:each) do
    assign(:perks, [
      Perk.create!(
        :title => "Title",
        :game_instance_id => 1,
        :description => "MyText",
        :price => 1.5,
        :game_id => 2
      ),
      Perk.create!(
        :title => "Title",
        :game_instance_id => 1,
        :description => "MyText",
        :price => 1.5,
        :game_id => 2
      )
    ])
  end

  it "renders a list of perks" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
