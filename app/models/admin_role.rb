class AdminRole < ActiveRecord::Base
	belongs_to :user
	before_save :fix_case
  validates_presence_of :user_id, :admin_type

	def self.admin_types
		return %w{ King Queen Forum Game }
	end

	def fix_case
		self.admin_type = self.admin_type.capitalize
	end
end
