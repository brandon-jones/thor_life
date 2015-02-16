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

	def discount
		perk_total = self.perks.inject(0){ |running_total, perk| running_total + perk.price_in_cents }
		if self.price_in_cents == perk_total
			nil
		else
			percent = ((1 - (perk_total.to_f / self.price_in_cents.to_f)) * 100)
			money = (self.price_in_cents - perk_total).to_f / 100
			if money.to_i > percent.to_i
				return PackagesController.helpers.number_to_currency((self.price_in_cents - perk_total).to_f / 100)
			else
				return PackagesController.helpers.number_to_percentage(  ((1 - (perk_total.to_f / self.price_in_cents.to_f)) * 100), precision: 0 )
			end
		end
	end
end
93.35
7.64
68.48
62.54
59.44
55.76