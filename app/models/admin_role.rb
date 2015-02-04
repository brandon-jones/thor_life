class AdminRole < ActiveRecord::Base
	belongs_to :user

	def self.admin_types
		return %w{ king queen forum game }
	end

end
