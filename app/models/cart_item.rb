class CartItem < ActiveRecord::Base
	belongs_to :cart
	has_many :packages
	has_many :perks
	belongs_to :item, :polymorphic => true
	validates_presence_of :item_id, :item_type, :cart_id
	include MoneyAttributes   
  money_attributes :price
end
