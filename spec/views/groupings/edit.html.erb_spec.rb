require 'rails_helper'

RSpec.describe "groupings/edit", :type => :view do
  before(:each) do
    @grouping = assign(:grouping, Grouping.create!(
      :title => "MyString"
    ))
  end

  it "renders the edit grouping form" do
    render

    assert_select "form[action=?][method=?]", grouping_path(@grouping), "post" do

      assert_select "input#grouping_title[name=?]", "grouping[title]"
    end
  end
end
