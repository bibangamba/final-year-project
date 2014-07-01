class JobseekersController < ApplicationController
	#authenticate is in sessions_helper(global sccess) &  denies access unless signed in.(also stores attempted url)
	before_filter :authenticate, :only => [:create, :destroy, :edit, :update]
	
	#shows all jobseeker details, in a list or something
	def index
		
	end
	
	def new
		@jobseeker = current_user.build_jobseeker
  	@title = "Save Profile"
	end
	
	#allows creation of jobseeker details on signup/posting them
	def create
		#build holds the entered details but does not save to the database.
		@jobseeker = current_user.build_jobseeker(params[:jobseeker])
		
		#if saving the details to the db returns true...else...
		if @jobseeker.save
			flash[:success] = "success! your profile information has been saved."			
			redirect_to root_path
		else
			#flash[:error] = @seeker
			flash[:error] = "sorry, failed to save your profile information"
			render 'pages/home'
		end
	end
	
	#directs to update if its an edit and to save profile if its the first time
	def edit

		if User.find(params[:id])
			@user = User.find(params[:id])
			@jobseeker = Jobseeker.find_by(:user_id => @user.id)
			@title = "Edit Profile"
		else
			flash[:notice] = "we don't have your profile yet, create one!"
			redirect_to pages_profile_page
		end
		
	end
	
	#for updating attributes
	def update
		@jobseeker = Jobseeker.find(params[:id])

		if @jobseeker.update_attributes(params[:jobseeker])
			flash[:success] = "profile updated."
			redirect_to current_user
		else
			@title = "Edit user"
			render 'edit'
		end
	end
	
	def destroy
		
	end
end
