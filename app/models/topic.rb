class Topic < ActiveRecord::Base
	belongs_to :forum
	belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
	belongs_to :destroyer, :class_name => 'User', :foreign_key => 'deleted_by'
	belongs_to :parent, :class_name => 'Forum', :foreign_key => 'forum_id'
	has_many :comments, dependent: :destroy

	after_save :update_self, :update_parent

	def update_self
		self.update_column(:last_updated, Time.now.utc)
	end

	def update_parent
		if self.parent
			self.parent.update_attribute(:last_updated, Time.now.utc)
		end
	end

	def parent_chain
		return self.parent.parent_chain << self
	end
end
