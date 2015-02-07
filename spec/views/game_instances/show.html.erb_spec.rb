require 'rails_helper'

RSpec.describe "game_instances/show", :type => :view do
  before(:each) do
    @game_instance = assign(:game_instance, GameInstance.create!(
      :game_id => 1,
      :server_name => "Server Name",
      :server_address => "Server Address",
      :server_port => 2,
      :mod_list => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Server Name/)
    expect(rendered).to match(/Server Address/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/MyText/)
  end
end
