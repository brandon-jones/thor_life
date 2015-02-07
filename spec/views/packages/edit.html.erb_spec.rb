require 'rails_helper'

RSpec.describe "packages/edit", :type => :view do
  before(:each) do
    @package = assign(:package, Package.create!(
      :title => "MyString",
      :price => 1.5,
      :perk_ids => "MyString"
    ))
  end

  it "renders the edit package form" do
    render

    assert_select "form[action=?][method=?]", package_path(@package), "post" do

      assert_select "input#package_title[name=?]", "package[title]"

      assert_select "input#package_price[name=?]", "package[price]"

      assert_select "input#package_perk_ids[name=?]", "package[perk_ids]"
    end
  end
end
