class Game < ActiveRecord::Base
	has_many :game_instances
	has_many :user_game_ids
	has_many :perks
	validates_presence_of :name
end
