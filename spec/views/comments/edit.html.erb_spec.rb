require 'rails_helper'

RSpec.describe "comments/edit", :type => :view do
  before(:each) do
    @comment = assign(:comment, Comment.create!(
      :created_by => 1,
      :body => "MyText",
      :topic_id => 1,
      :deleted => false,
      :deleted_by => 1
    ))
  end

  it "renders the edit comment form" do
    render

    assert_select "form[action=?][method=?]", comment_path(@comment), "post" do

      assert_select "input#comment_created_by[name=?]", "comment[created_by]"

      assert_select "textarea#comment_body[name=?]", "comment[body]"

      assert_select "input#comment_topic_id[name=?]", "comment[topic_id]"

      assert_select "input#comment_deleted[name=?]", "comment[deleted]"

      assert_select "input#comment_deleted_by[name=?]", "comment[deleted_by]"
    end
  end
end
