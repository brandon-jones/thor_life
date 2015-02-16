require 'rails_helper'

RSpec.describe CartItem, :type => :model do

	before(:each) do
  	@cart = FactoryGirl.create(:cart)
	end

	describe "Active Record Callbacks" do

		it "expects an item_id to be required" do
			cart_item = FactoryGirl.build(:cart_item, item_id: nil)
			expect(cart_item.save).to eq(false)
		end

		it "expects an item_type to be required" do
			cart_item = FactoryGirl.build(:cart_item, item_type: nil)
			expect(cart_item.save).to eq(false)
		end

		it "expects a cart_id to be required" do
			cart_item = FactoryGirl.build(:cart_item, cart_id: nil)
			expect(cart_item.save).to eq(false)
		end

		it "expects a price_in_cents to be required" do
			cart_item = FactoryGirl.build(:cart_item, price_in_cents: nil)
			expect(cart_item.save).to eq(false)
		end

		it "expects the item_type to be capitalized" do
			cart_item = FactoryGirl.create(:cart_item, item_type: 'perk', cart_id: @cart.id)
			expect(cart_item.item_type).to eq('Perk')
			cart_item = FactoryGirl.create(:cart_item, item_type: 'package', cart_id: @cart.id)
			expect(cart_item.item_type).to eq('Package')
		end

		it "expects the carts price to be updated on creation" do
			cart = FactoryGirl.create(:cart, total_in_cents: 0)
			cart_item = FactoryGirl.build(:cart_item, cart_id: cart.id, price_in_cents: 100)
			cart_item.save
			expect(cart_item).to have_received(:update_cart_price)
		end
	end

	describe "Active Record Associations" do
		it "expects to belong to a cart" do
			cart_item = FactoryGirl.create(:cart_item, cart_id: @cart.id)
			expect(cart_item.cart).to eq(@cart)
		end

		it "expects to belong to an perk" do
			perk = FactoryGirl.create(:perk)
			cart_item = FactoryGirl.create(:cart_item, item_id: perk.id, item_type: perk.class.to_s, cart_id: @cart.id )
			expect(cart_item.item).to eq(perk)
		end

		it "expects to belong to an package" do
			package = FactoryGirl.create(:package)
			cart_item = FactoryGirl.create(:cart_item, item_id: package.id, item_type: package.class.to_s, cart_id: @cart.id )
			expect(cart_item.item).to eq(package)
		end
	end

	context "MoneyAttributes" do

		before(:each) do 
			@cart_item = FactoryGirl.create(:cart_item, cart_id: @cart.id)
		end

		it "expects to save as cents and get dollars" do
			@cart_item.update_attribute(:price, 40.00)
			expect(@cart_item.price_in_cents).to eq(4000)
		end

		it "expects to save as dollars and get cents" do
			@cart_item.update_attribute(:price_in_cents, 4000)
			expect(@cart_item.price).to eq(40.00)
		end

		it "expects to save dollars and get formatted price" do
			@cart_item.update_attribute(:price, 40.00)
			expect(@cart_item.price_money).to eq("$40.00")
		end

		it "expects to save cents and get formatted price" do
			@cart_item.update_attribute(:price_in_cents, 4000)
			expect(@cart_item.price_money).to eq("$40.00")
		end
	end
end
