class UserGameId < ActiveRecord::Base
	belongs_to :user
	belongs_to :game
	validates_presence_of :game_id, :in_game_name, :user_id
	validates_presence_of :banned_by, :if => :banned
end
