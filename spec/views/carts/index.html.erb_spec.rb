require 'rails_helper'

RSpec.describe "carts/index", :type => :view do
  before(:each) do
    assign(:carts, [
      Cart.create!(
        :user_id => "",
        :total => 1.5,
        :delivered => false,
        :delivered_by => 1
      ),
      Cart.create!(
        :user_id => "",
        :total => 1.5,
        :delivered => false,
        :delivered_by => 1
      )
    ])
  end

  it "renders a list of carts" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
