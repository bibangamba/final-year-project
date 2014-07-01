class PagesController < ApplicationController
	before_filter :authenticate, :only=>:profile

  def home
  	@title = "Home"
		if signed_in?
			@micropost = Micropost.new
			@feed_items = current_user.feed.paginate(:page => params[:page])
		end
  end
  
  #when the profile is new
  def profile
    @jobseeker = current_user.build_jobseeker
  	@title = "Save Profile"
  end
  
  #updating the profile(jobseeker details)
  def edit_profile
  	@user = User.find(params[:id])
    @jobseeker = Jobseeker.find_by(:user_id => @user)
  	@title = "Edit Profile"
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
