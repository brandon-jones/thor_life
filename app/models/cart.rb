class Cart < ActiveRecord::Base
	has_many :cart_items
	belongs_to :deliverer, :class_name => 'User', :foreign_key => 'delivered_by'
	belongs_to :user
	validates_presence_of :user_id
	validates_presence_of :delivered_by, :if => :delivered
	include MoneyAttributes   
  money_attributes :total

  def update_total
  	total = 0
  	self.cart_items.each do |ci|
  		total += ci.price
  	end
  	self.update_attribute(:total, total)
    return self.total_money
  end

end
