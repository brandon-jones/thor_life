class AdminRole < ActiveRecord::Base
	belongs_to :user, dependent: :destroy
	before_save :fix_case
  validates_presence_of :user_id, :admin_type
  validates_uniqueness_of :admin_type, scope: [:admin_id, :user_id]

  def unique_admin_level?
  	binding.pry
  end

	def self.admin_types
		return %w{ King Queen Forum }
	end

	def self.restricted_admins(current_user)
		uat = current_user.admin_types_array.first
		builder = []
		found = uat == "King" ? true : false
		AdminRole.admin_types.each do |at|
			builder << at if found
			found = true if uat == at
		end
		return builder
	end

	def fix_case
		self.admin_type = self.admin_type.capitalize
	end
end
