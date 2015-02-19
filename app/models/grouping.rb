class Grouping < ActiveRecord::Base
	validates_presence_of :title
	validates_uniqueness_of :title
	scope :find_by_item_ids, ->(id) { where(:id => id).order('title DESC') }

	def self.find_or_create_by_title(title)
		if grouping = Grouping.where(title: title).first
			return grouping.first
		else
			title = 'nil' unless title.present?
			return Grouping.create(title: title)
		end
	end
end
