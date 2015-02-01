require 'rails_helper'

RSpec.describe User, :type => :model do

	context "Before/After Save/Create/Destroy" do
		it "expects require email to be unique" do
	    user1 = FactoryGirl.create(:user)
	    user2 = FactoryGirl.build(:user, email: user1.email, username: 'newname')
	    expect(user2.save).to eq(false)
	    user2.update_attribute(:email, 'something_new@mbc.com')
	    expect(user2.save).to eq(true)
	  end

		it "expects require username to be unique" do
      user1 = FactoryGirl.create(:user, username: "myScreenName")
      puts user1.email
      user2 = FactoryGirl.build(:user, username: user1.username, email: 'test@test.com')
      puts user2.email
      expect(user2.save).to eq(false)
      user2.update_attribute(:username, 'something_new')
      puts user2.username
      expect(user2.save).to eq(true)
    end

    it "expect an email" do
    	user = FactoryGirl.build(:user, email: '')
    	expect(user.save).to eq(false)
    	user.update_attribute(:email, 'bob@bob.com')
    	expect(user.save).to eq(true)
    end
	end
end