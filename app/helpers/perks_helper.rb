module PerksHelper
	def cheveron(type, order)
		sort_order = order == 'ASC' ? '' : '-alt'
		sort_type = "sort-by-"
		case type
		when 'alphabet'
			sort_type += 'alphabet'
		when 'numeric'
			sort_type += 'order'
		when 'generic'
			sort_type += 'attributes'
		when 'cheveron'
			sort_type = 'chevron'
			sort_order = sort_order == '-alt' ? '-down' : '-up'
		end
		return "<span class='glyphicon glyphicon-#{sort_type}#{sort_order}' aria-hidden='true'></span>".html_safe
	end
end
