require 'rails_helper'

RSpec.describe "users/edit", :type => :view do
  before(:each) do
    @user = assign(:user, User.create!(
      :password_digest => "MyString",
      :name => "MyString",
      :email => "MyString",
      :email_public => false,
      :email_verified => false,
      :phone_number => false,
      :phone_provider => false,
      :about_me => "MyText",
      :banned => false,
      :permma_banned => false,
      :banned_by => 1,
      :customer_id => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input#user_password_digest[name=?]", "user[password_digest]"

      assert_select "input#user_name[name=?]", "user[name]"

      assert_select "input#user_email[name=?]", "user[email]"

      assert_select "input#user_email_public[name=?]", "user[email_public]"

      assert_select "input#user_email_verified[name=?]", "user[email_verified]"

      assert_select "input#user_phone_number[name=?]", "user[phone_number]"

      assert_select "input#user_phone_provider[name=?]", "user[phone_provider]"

      assert_select "textarea#user_about_me[name=?]", "user[about_me]"

      assert_select "input#user_banned[name=?]", "user[banned]"

      assert_select "input#user_permma_banned[name=?]", "user[permma_banned]"

      assert_select "input#user_banned_by[name=?]", "user[banned_by]"

      assert_select "input#user_customer_id[name=?]", "user[customer_id]"
    end
  end
end
