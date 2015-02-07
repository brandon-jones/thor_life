require 'rails_helper'

RSpec.describe "packages/new", :type => :view do
  before(:each) do
    assign(:package, Package.new(
      :title => "MyString",
      :price => 1.5,
      :perk_ids => "MyString"
    ))
  end

  it "renders new package form" do
    render

    assert_select "form[action=?][method=?]", packages_path, "post" do

      assert_select "input#package_title[name=?]", "package[title]"

      assert_select "input#package_price[name=?]", "package[price]"

      assert_select "input#package_perk_ids[name=?]", "package[perk_ids]"
    end
  end
end
