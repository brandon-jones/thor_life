require 'rails_helper'

RSpec.describe "carts/show", :type => :view do
  before(:each) do
    @cart = assign(:cart, Cart.create!(
      :user_id => "",
      :total => 1.5,
      :delivered => false,
      :delivered_by => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/1.5/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
  end
end
