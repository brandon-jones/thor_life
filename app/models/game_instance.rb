class GameInstance < ActiveRecord::Base
	has_many :perks
	belongs_to :game
	validates_presence_of :game_id, :server_name, :server_address
end
