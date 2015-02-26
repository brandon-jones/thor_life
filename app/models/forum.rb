class Forum < ActiveRecord::Base
	belongs_to :creator, :class_name => 'User', :foreign_key => 'created_by'
	belongs_to :destroyer, :class_name => 'User', :foreign_key => 'deleted_by'
	has_many :children, :class_name => 'Forum', :foreign_key => 'parent_id', dependent: :destroy
	belongs_to :parent, :class_name => 'Forum'
	belongs_to :grouping
	has_many :groups, :class_name => 'Grouping', :foreign_key => 'forum_id'
	has_many :topics, -> { order(sticky: 'DESC').order(:created_at) }, dependent: :destroy
	validates_presence_of :title

	include RankedModel
  ranks :row_order, :with_same => :grouping_id 

	after_save :update_self_and_parent

	def update_self_and_parent
		self.update_column(:last_updated, Time.now.utc)
		if self.parent
			self.parent.update_attribute(:last_updated, Time.now.utc)
		end
	end

	# def id
	# 	return super == nil ? 'nil' : super
	# end

	def get_groups_and_grouped_forums
		groups = Grouping.rank(:row_order).where(forum_id: self.id)
		forums = Forum.rank(:row_order).where(parent_id: self.id).where(grouping_id: groups.pluck(:id) << nil)
		builder = {}
		forums.order(created_at: :desc).each do |forum|
			key = forum.grouping ? forum.grouping.title : 'nil'
			builder[key] = [] unless builder[key]
			builder[key] << forum
		end
		forums = builder
		return groups, forums
	end

	def self.dropdown(id = nil)
		if item_ids = Forum.where(parent_id: id).pluck(:grouping_id).uniq
			Grouping.find_by_item_ids( item_ids ).pluck(:title, :id)
		end
	end

	def self.groups(id = nil)
		if item_ids = Forum.where(parent_id: id).pluck(:grouping_id).uniq.grep(Integer)
			return Grouping.find_by_item_ids( item_ids ) << Grouping.new(title: 'nil')
		end
		return []
	end

	def parent_chain
		chain = []
		chain << self
		obj = self.parent
		while obj
			chain << obj
			obj = obj.parent
		end
		return chain.reverse if chain.count > 1
		return []
	end

	def options
		return %w{ deleted_by, deleted, destory, locked, main_feed }
	end	
end