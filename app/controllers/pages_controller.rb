class PagesController < ApplicationController
	before_filter :authenticate, :only=>:profile

  def home
  	@title = "Home"
		if signed_in?
			if current_user.role == "jobseeker"
				
				@title = "Promising Jobs"
				jobseeker = Jobseeker.find_by_user_id(current_user.id)
				if jobseeker
					preferred_field = jobseeker.field
					@jobs = Job.where('category LIKE ?', preferred_field)
				else
					@jobs = nil
				end
				
			elsif current_user.role == "employer"
				
				@title = "Jobseekers"								
				posted_jobs = Job.find_all_by_employer_id(current_user)
				if posted_jobs
					posted_jobs.each do |jobs|
						(@categories ||=[]) << jobs.category#get each posted jobs category and append it to categories array
					end
				
					@categories.each do |category|
						(@seekers ||=[]) << Jobseeker.all(:conditions=>"field = '#{category}'")
					end
				else
					@seekers = nil
				end
				#@seekers = Jobseeker.find(:all, limit: 20)				
			end
		end
  end

  def contact
  	@title = "Contact"
  end
  
  def about
  	@title = "About"
  end
  def help
  	@title = "Help"
  end
end
