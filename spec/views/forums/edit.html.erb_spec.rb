require 'rails_helper'

RSpec.describe "forums/edit", :type => :view do
  before(:each) do
    @forum = assign(:forum, Forum.create!(
      :parent_id => 1,
      :order => 1,
      :created_by => 1,
      :title => "MyString",
      :deleted_by => 1,
      :grouping_id => 1,
      :locked => false,
      :admins_only => false,
      :main_feed => false,
      :deleted => false,
      :last_updated => false
    ))
  end

  it "renders the edit forum form" do
    render

    assert_select "form[action=?][method=?]", forum_path(@forum), "post" do

      assert_select "input#forum_parent_id[name=?]", "forum[parent_id]"

      assert_select "input#forum_order[name=?]", "forum[order]"

      assert_select "input#forum_created_by[name=?]", "forum[created_by]"

      assert_select "input#forum_title[name=?]", "forum[title]"

      assert_select "input#forum_deleted_by[name=?]", "forum[deleted_by]"

      assert_select "input#forum_grouping_id[name=?]", "forum[grouping_id]"

      assert_select "input#forum_locked[name=?]", "forum[locked]"

      assert_select "input#forum_admins_only[name=?]", "forum[admins_only]"

      assert_select "input#forum_main_feed[name=?]", "forum[main_feed]"

      assert_select "input#forum_deleted[name=?]", "forum[deleted]"

      assert_select "input#forum_last_updated[name=?]", "forum[last_updated]"
    end
  end
end
