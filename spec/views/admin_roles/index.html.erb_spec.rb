require 'rails_helper'

RSpec.describe "admin_roles/index", :type => :view do
  before(:each) do
    assign(:admin_roles, [
      AdminRole.create!(
        :user_id => 1,
        :admin_type => "Admin Type",
        :admin_id => 2
      ),
      AdminRole.create!(
        :user_id => 1,
        :admin_type => "Admin Type",
        :admin_id => 2
      )
    ])
  end

  it "renders a list of admin_roles" do
    render
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Admin Type".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
