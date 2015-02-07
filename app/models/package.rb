class Package < ActiveRecord::Base
	validates_presence_of :title, :price
	has_many :cart_items, :as => :items
	include MoneyAttributes   
  money_attributes :price
	def perks
		builder = []
		self.perk_ids.split(',').each do |id|
			builder << id
		end
		return Perk.find(builder)
	end
end
