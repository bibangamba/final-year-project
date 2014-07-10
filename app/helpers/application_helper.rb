module ApplicationHelper
	
	# Return a title on a per-page basis.
	def title
			base_title = "JobRadar"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
	
	#variable logo for the logo in header partial
	def logo
		image_tag("logo.png", :alt => "jobradar", :class => "round")
	end
end
