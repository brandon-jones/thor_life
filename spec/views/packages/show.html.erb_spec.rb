require 'rails_helper'

RSpec.describe "packages/show", :type => :view do
  before(:each) do
    @package = assign(:package, Package.create!(
      :title => "Title",
      :price => 1.5,
      :perk_ids => "Perk Ids"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/Perk Ids/)
  end
end
