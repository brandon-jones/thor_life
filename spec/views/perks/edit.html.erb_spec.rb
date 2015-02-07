require 'rails_helper'

RSpec.describe "perks/edit", :type => :view do
  before(:each) do
    @perk = assign(:perk, Perk.create!(
      :title => "MyString",
      :game_instance_id => 1,
      :description => "MyText",
      :price => 1.5,
      :game_id => 1
    ))
  end

  it "renders the edit perk form" do
    render

    assert_select "form[action=?][method=?]", perk_path(@perk), "post" do

      assert_select "input#perk_title[name=?]", "perk[title]"

      assert_select "input#perk_game_instance_id[name=?]", "perk[game_instance_id]"

      assert_select "textarea#perk_description[name=?]", "perk[description]"

      assert_select "input#perk_price[name=?]", "perk[price]"

      assert_select "input#perk_game_id[name=?]", "perk[game_id]"
    end
  end
end
