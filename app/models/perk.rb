class Perk < ActiveRecord::Base
	validates_presence_of :title, :game_id
	belongs_to :game_instance
	belongs_to :game
	has_many :cart_items, :as => :items
	include MoneyAttributes
  money_attributes :price
end