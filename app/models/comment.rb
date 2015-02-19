class Comment < ActiveRecord::Base
	belongs_to :topic, counter_cache: true
	belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
	belongs_to :destroyer, :class_name => 'User', :foreign_key => 'deleted_by'

	after_save :update_parent

	def update_parent
		if self.parent
			self.parent.update_attribute(:last_updated, Time.now.utc)
		end
	end

	def parent
		return self.topic
	end
end
