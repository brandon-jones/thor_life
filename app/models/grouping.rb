class Grouping < ActiveRecord::Base
	validates_presence_of :title
	validates_uniqueness_of :title, scope: :forum_id
	scope :find_by_item_ids, ->(id) { where(:id => id).order('title DESC') }
	belongs_to :forum, :class_name => 'Forum', :foreign_key => 'forum_id'
	has_many :forums, :class_name => 'Forum', :foreign_key => 'grouping_id'

	include RankedModel
  ranks :row_order, :with_same => :forum_id 

	def self.find_or_create_by_title(title)
		if grouping = Grouping.where(title: title).first
			return grouping.first
		else
			title = 'nil' unless title.present?
			return Grouping.create(title: title)
		end
	end

	def self.top_level_groups
		return Grouping.rank(:row_order).where(forum_id: nil)
	end	

	def id
		if super == 0
			return 'nil'
		else
			return super
		end
	end
end
