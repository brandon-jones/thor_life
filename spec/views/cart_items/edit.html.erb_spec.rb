require 'rails_helper'

RSpec.describe "cart_items/edit", :type => :view do
  before(:each) do
    @cart_item = assign(:cart_item, CartItem.create!(
      :item_id => 1,
      :item_type => "MyString",
      :string => "MyString",
      :price => 1.5,
      :cart_id => 1
    ))
  end

  it "renders the edit cart_item form" do
    render

    assert_select "form[action=?][method=?]", cart_item_path(@cart_item), "post" do

      assert_select "input#cart_item_item_id[name=?]", "cart_item[item_id]"

      assert_select "input#cart_item_item_type[name=?]", "cart_item[item_type]"

      assert_select "input#cart_item_string[name=?]", "cart_item[string]"

      assert_select "input#cart_item_price[name=?]", "cart_item[price]"

      assert_select "input#cart_item_cart_id[name=?]", "cart_item[cart_id]"
    end
  end
end
