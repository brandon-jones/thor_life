require 'rails_helper'

RSpec.describe "topics/index", :type => :view do
  before(:each) do
    assign(:topics, [
      Topic.create!(
        :grouping_id => 1,
        :title => "Title",
        :created_by => 2,
        :sticky => false,
        :order => 3,
        :body => "MyText",
        :locked => false,
        :deleted => false,
        :deleted_by => 4,
        :forum_id => 5
      ),
      Topic.create!(
        :grouping_id => 1,
        :title => "Title",
        :created_by => 2,
        :sticky => false,
        :order => 3,
        :body => "MyText",
        :locked => false,
        :deleted => false,
        :deleted_by => 4,
        :forum_id => 5
      )
    ])
  end

  it "renders a list of topics" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 4.to_s, :count => 2
    assert_select "tr>td", :text => 5.to_s, :count => 2
  end
end
