require 'rails_helper'

RSpec.describe "carts/edit", :type => :view do
  before(:each) do
    @cart = assign(:cart, Cart.create!(
      :user_id => "",
      :total => 1.5,
      :delivered => false,
      :delivered_by => 1
    ))
  end

  it "renders the edit cart form" do
    render

    assert_select "form[action=?][method=?]", cart_path(@cart), "post" do

      assert_select "input#cart_user_id[name=?]", "cart[user_id]"

      assert_select "input#cart_total[name=?]", "cart[total]"

      assert_select "input#cart_delivered[name=?]", "cart[delivered]"

      assert_select "input#cart_delivered_by[name=?]", "cart[delivered_by]"
    end
  end
end
