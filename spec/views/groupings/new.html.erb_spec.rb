require 'rails_helper'

RSpec.describe "groupings/new", :type => :view do
  before(:each) do
    assign(:grouping, Grouping.new(
      :title => "MyString"
    ))
  end

  it "renders new grouping form" do
    render

    assert_select "form[action=?][method=?]", groupings_path, "post" do

      assert_select "input#grouping_title[name=?]", "grouping[title]"
    end
  end
end
