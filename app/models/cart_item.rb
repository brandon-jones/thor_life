class CartItem < ActiveRecord::Base
  after_destroy :update_cart_price
  after_save :update_cart_price
  before_save :fix_case
  validates_presence_of :item_id, :item_type, :cart_id, :price_in_cents

	belongs_to :cart
	belongs_to :item, :polymorphic => true

	include MoneyAttributes   
  money_attributes :price
  
  def update_cart_price
  	self.cart.update_total
  end

  def fix_case
  	self["item_type"] = self["item_type"].capitalize
  end

end
