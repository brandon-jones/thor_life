class CartItem < ActiveRecord::Base
	belongs_to :cart
	# has_many :packages
	# has_many :perks
	belongs_to :item, :polymorphic => true
	validates_presence_of :item_id, :item_type, :cart_id
	include MoneyAttributes   
  money_attributes :price
  before_save :fix_case
  
  after_destroy :update_cart_price
  after_save :update_cart_price

  def update_cart_price
  	self.cart.update_total
  end

  def fix_case
  	self["item_type"] = self["item_type"].capitalize
  end

end
