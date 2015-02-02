require 'rails_helper'

RSpec.describe "admin_roles/new", :type => :view do
  before(:each) do
    assign(:admin_role, AdminRole.new(
      :user_id => 1,
      :admin_type => "MyString",
      :admin_id => 1
    ))
  end

  it "renders new admin_role form" do
    render

    assert_select "form[action=?][method=?]", admin_roles_path, "post" do

      assert_select "input#admin_role_user_id[name=?]", "admin_role[user_id]"

      assert_select "input#admin_role_admin_type[name=?]", "admin_role[admin_type]"

      assert_select "input#admin_role_admin_id[name=?]", "admin_role[admin_id]"
    end
  end
end
