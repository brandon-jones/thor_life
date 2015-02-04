class Topic < ActiveRecord::Base
	belongs_to :forum
	belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
	belongs_to :destroyer, :class_name => 'User', :foreign_key => 'deleted_by'
	belongs_to :parent, :class_name => 'Forum', :foreign_key => 'forum_id'
	has_many :comments

	def parent_chain
		return self.parent.parent_chain << self
	end
end
