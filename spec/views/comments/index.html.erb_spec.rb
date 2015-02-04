require 'rails_helper'

RSpec.describe "comments/index", :type => :view do
  before(:each) do
    assign(:comments, [
      Comment.create!(
        :created_by => 1,
        :body => "MyText",
        :topic_id => 2,
        :deleted => false,
        :deleted_by => 3
      ),
      Comment.create!(
        :created_by => 1,
        :body => "MyText",
        :topic_id => 2,
        :deleted => false,
        :deleted_by => 3
      )
    ])
  end

  it "renders a list of comments" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
