require 'rails_helper'

RSpec.describe User, :type => :model do

	context "User Authentication" do
		it "expects the database to not store clear text passwords" do
			user = FactoryGirl.create(:user, password: 'hello')
			expect(user.password_digest).not_to eq('hello')
		end

		it "expects password confirmation" do
			user = FactoryGirl.build(:user, password: 'hello', password_confirmation: 'hi')
			expect(user.save).to eq(false)
			user.update_attribute(:password_confirmation, 'hello')
			expect(user.save).to eq(true)
		end

		it "expects a user to be able to log in" do
			user = FactoryGirl.create(:user, password: 'hello')
			expect(user.authenticate('hi')).to eq(false)
			expect(user.authenticate('hello')).to eq(user) 
		end

		it "expects a session_id to be created after logging in" do
			user = FactoryGirl.create(:user)
			expect(user.session_id).not_to eq(nil)
		end

	end

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

    it "creates a display name for before" do
    	user = FactoryGirl.build(:user)
    	expect(user.username).to eq(nil)
    	user.save
    	expect(user.username).not_to eq(nil)
    end
	end
end