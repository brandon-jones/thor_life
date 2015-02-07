class Cart < ActiveRecord::Base
	has_many :cart_items
	belongs_to :deliverer, :class_name => 'User', :foreign_key => 'delivered_by'
	belongs_to :user
	validates_presence_of :user_id
	validates_presence_of :delivered_by, :if => :delivered
	include MoneyAttributes   
  money_attributes :total
end
