require 'rails_helper'

RSpec.describe AdminRole, :type => :model do
  context "creation" do
		it "expects a user id to be required" do
			ar = FactoryGirl.build(:admin_role, user_id: nil)
			expect(ar.save).to eq(false)
		end

		it "expects an admin_type to be required" do
			ar = FactoryGirl.build(:admin_role, admin_type: nil)
			expect(ar.save).to eq(false)
		end

		it "expects to capitalize all admin types" do
			ar = FactoryGirl.create(:admin_role, admin_type: 'king')
			expect(ar.admin_type).to eq('King')
			ar.update_attribute(:admin_type, 'queen')
			expect(ar.admin_type).to eq('Queen')
			ar.update_attribute(:admin_type, 'forum')
			expect(ar.admin_type).to eq('Forum')
		end
	end

	context "associations" do
		it "expects to belong to a user" do
			user = FactoryGirl.create(:user)
			ar = FactoryGirl.create(:admin_role, user_id: user.id)
			expect(ar.user).to eq(user)
		end
	end

	context "methods" do
		it "to know the admin types" do
			expect(AdminRole.admin_types).to eq(['King', 'Queen', 'Forum', 'Game'])
		end
	end
end
