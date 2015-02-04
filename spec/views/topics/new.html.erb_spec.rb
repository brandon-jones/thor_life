require 'rails_helper'

RSpec.describe "topics/new", :type => :view do
  before(:each) do
    assign(:topic, Topic.new(
      :grouping_id => 1,
      :title => "MyString",
      :created_by => 1,
      :sticky => false,
      :order => 1,
      :body => "MyText",
      :locked => false,
      :deleted => false,
      :deleted_by => 1,
      :forum_id => 1
    ))
  end

  it "renders new topic form" do
    render

    assert_select "form[action=?][method=?]", topics_path, "post" do

      assert_select "input#topic_grouping_id[name=?]", "topic[grouping_id]"

      assert_select "input#topic_title[name=?]", "topic[title]"

      assert_select "input#topic_created_by[name=?]", "topic[created_by]"

      assert_select "input#topic_sticky[name=?]", "topic[sticky]"

      assert_select "input#topic_order[name=?]", "topic[order]"

      assert_select "textarea#topic_body[name=?]", "topic[body]"

      assert_select "input#topic_locked[name=?]", "topic[locked]"

      assert_select "input#topic_deleted[name=?]", "topic[deleted]"

      assert_select "input#topic_deleted_by[name=?]", "topic[deleted_by]"

      assert_select "input#topic_forum_id[name=?]", "topic[forum_id]"
    end
  end
end
