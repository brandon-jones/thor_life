require 'rails_helper'

RSpec.describe "forums/index", :type => :view do
  before(:each) do
    assign(:forums, [
      Forum.create!(
        :parent_id => 1,
        :order => 2,
        :created_by => 3,
        :title => "Title",
        :deleted_by => 4,
        :grouping_id => 5,
        :locked => false,
        :admins_only => false,
        :main_feed => false,
        :deleted => false,
        :last_updated => false
      ),
      Forum.create!(
        :parent_id => 1,
        :order => 2,
        :created_by => 3,
        :title => "Title",
        :deleted_by => 4,
        :grouping_id => 5,
        :locked => false,
        :admins_only => false,
        :main_feed => false,
        :deleted => false,
        :last_updated => false
      )
    ])
  end

  it "renders a list of forums" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
