require 'rails_helper'

RSpec.describe "users/index", :type => :view do
  before(:each) do
    assign(:users, [
      User.create!(
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
      ),
      User.create!(
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
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", :text => "Password Digest".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Customer".to_s, :count => 2
  end
end
