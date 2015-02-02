require 'rails_helper'

RSpec.describe "admin_roles/show", :type => :view do
  before(:each) do
    @admin_role = assign(:admin_role, AdminRole.create!(
      :user_id => 1,
      :admin_type => "Admin Type",
      :admin_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Admin Type/)
    expect(rendered).to match(/2/)
  end
end
