class JobseekersController < ApplicationController
	#authenticate is in sessions_helper(global sccess) &  denies access unless signed in.(also stores attempted url)
	before_filter :authenticate, :only => [:create, :destroy, :edit, :update]
	
	#shows all jobseeker details, in a list or something
	def index
		
	end
	
	def new
    @jobseeker = current_user.build_jobseeker
  	@title = "Creae Your Profile"
	end
	
	#allows creation of jobseeker details on signup/posting them
	def create
		#build holds the entered details but does not save to the database.
		@jobseeker = current_user.build_jobseeker(params[:jobseeker])
		
		#if saving the details to the db returns true...else...
		if @jobseeker.save
			flash[:success] = "success! your profile information has been saved."			
			redirect_to current_user
		else
			#flash[:error] = @seeker
			flash[:error] = "sorry, failed to save your profile information"
			render 'pages/home'
		end
	end
	
	#directs to update if its an edit and to save profile if its the first time
	def edit
			@user = User.find(params[:id])
			@jobseeker1 = Jobseeker.find_by(:user_id => @user.id)
			
		if @jobseeker1
			@jobseeker = @jobseeker1
			@title = "Edit Profile"
		else
			flash[:notice] = "we don't have your profile yet, create one!"
			render 'new'
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
	
	def upload
  uploaded_io = params[:jobseeker][:cv]
  File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    file.write(uploaded_io.read)
  end
end
end
