require 'rails_helper'

RSpec.describe User, :type => :model do

	context "User Authentication" do
		it "expects the database to not store clear text passwords" do
			user = FactoryGirl.create(:user, password: 'hellolonger')
			expect(user.password_digest).not_to eq('hello')
		end

		it "expects password confirmation" do
			user = FactoryGirl.build(:user, password: 'hellolonger', password_confirmation: 'hi')
			expect(user.save).to eq(false)
			user.update_attribute(:password_confirmation, 'hellolonger')
			expect(user.save).to eq(true)
		end

		it "expects a user to be able to log in" do
			user = FactoryGirl.create(:user, password: 'hellolonger')
			expect(user.authenticate('hellolongers')).to eq(false)
			expect(user.authenticate('hellolonger')).to eq(user) 
		end

		it "expects a users password to be 6 characters or more" do
			user = FactoryGirl.build(:user, password: 'bad')
			expect(user.save).to eq(false)
			user.update_attribute(:password, 'thisisvalid')
			expect(user.save).to eq(true)
		end
	end

	context "Admin Level Checking" do
		it "expects an king to be an admin superuser and king" do
			user = FactoryGirl.create(:user)
			expect(user.admin?).to eq(false)
			AdminRole.create(user_id: user.id, admin_type: 'king')
			expect(user.admin?).to eq(true)
			expect(user.super_admin?).to eq(true)
			expect(user.king?).to eq(true)
		end

		it "expects an queen to be an admin superuser and queen" do
			user = FactoryGirl.create(:user)
			expect(user.admin?).to eq(false)
			AdminRole.create(user_id: user.id, admin_type: 'queen')
			expect(user.admin?).to eq(true)
			expect(user.super_admin?).to eq(true)
			expect(user.queen?).to eq(true)
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