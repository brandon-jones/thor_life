class Forum < ActiveRecord::Base
	belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
	belongs_to :destroyer, :class_name => 'User', :foreign_key => 'deleted_by'
	has_many :children, :class_name => 'Forum', :foreign_key => 'parent_id'
	belongs_to :parent, :class_name => 'Forum'
	belongs_to :grouping
	has_many :topics

	def self.groupped(id = nil)
		builder = {}
		Forum.where(parent_id: id).order(:grouping_id, created_at: :desc).each do |forum|
			key = forum.grouping ? forum.grouping.title : 'nil'
			builder[key] = [] unless builder[key]
			builder[key] << forum
		end
		# return builder.keys.map { |key| builder[key] }
		return builder
	end

	def admins
		binding.pry
	end

	def parent_chain
		chain = []
		chain << self
		obj = self.parent
		while obj
			chain << obj
			obj = obj.parent
		end
		chain << Forum.new(title: 'Forums')
		return chain.reverse
	end

	def options
		return %w{ deleted_by, deleted, destory, locked, main_feed }
	end	
end