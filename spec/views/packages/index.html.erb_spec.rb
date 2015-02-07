require 'rails_helper'

RSpec.describe "packages/index", :type => :view do
  before(:each) do
    assign(:packages, [
      Package.create!(
        :title => "Title",
        :price => 1.5,
        :perk_ids => "Perk Ids"
      ),
      Package.create!(
        :title => "Title",
        :price => 1.5,
        :perk_ids => "Perk Ids"
      )
    ])
  end

  it "renders a list of packages" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => "Perk Ids".to_s, :count => 2
  end
end
