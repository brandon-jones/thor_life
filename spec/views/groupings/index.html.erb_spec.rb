require 'rails_helper'

RSpec.describe "groupings/index", :type => :view do
  before(:each) do
    assign(:groupings, [
      Grouping.create!(
        :title => "Title"
      ),
      Grouping.create!(
        :title => "Title"
      )
    ])
  end

  it "renders a list of groupings" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
  end
end
