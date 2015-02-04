require 'rails_helper'

RSpec.describe "groupings/show", :type => :view do
  before(:each) do
    @grouping = assign(:grouping, Grouping.create!(
      :title => "Title"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
