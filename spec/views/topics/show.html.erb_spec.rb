require 'rails_helper'

RSpec.describe "topics/show", :type => :view do
  before(:each) do
    @topic = assign(:topic, Topic.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
