require 'rails_helper'

RSpec.describe "forums/show", :type => :view do
  before(:each) do
    @forum = assign(:forum, Forum.create!(
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
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
  end
end
