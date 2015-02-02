class AdminRole < ActiveRecord::Base
	belongs_to :user

	ADMIN_TYPES = %w{ king queen forum game }

end
