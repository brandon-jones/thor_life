require 'rails_helper'

RSpec.describe "users/show", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :password_digest => "Password Digest",
      :name => "Name",
      :email => "Email",
      :email_public => false,
      :email_verified => false,
      :phone_number => false,
      :phone_provider => false,
      :about_me => "MyText",
      :banned => false,
      :permma_banned => false,
      :banned_by => 1,
      :customer_id => "Customer"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Password Digest/)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Customer/)
  end
end
