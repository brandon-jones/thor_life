require 'rails_helper'

RSpec.describe "perks/show", :type => :view do
  before(:each) do
    @perk = assign(:perk, Perk.create!(
      :title => "Title",
      :game_instance_id => 1,
      :description => "MyText",
      :price => 1.5,
      :game_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/2/)
  end
end
