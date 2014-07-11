class JobseekersController < ApplicationController
	#authenticate is in sessions_helper(global sccess) &  denies access unless signed in.(also stores attempted url)
	before_filter :authenticate, :only => [:create, :destroy, :edit, :update]
	
	#shows all jobseeker details, in a list or something
	def index
		
	end
	
	def show
		@action = params[:id].to_s
		@user = current_user.id
		@jobseeker = Jobseeker.find_by!(:user_id => @user)
		
		if File.exist?(Rails.root.join('public', 'uploads', @jobseeker.id.to_s ))
			
			if @action == 'download_cv'
				#send file snds the pdf for downloading
				send_file Rails.root.join('public', 'uploads', @jobseeker.id.to_s ), :type=>"application/pdf", :x_sendfile=>true
			
			elsif @action == 'view_cv'
				#sends file to user but for renering in the browser
				send_file Rails.root.join('public', 'uploads', @jobseeker.id.to_s ),:disposition => 'inline', :type=>"application/pdf", :x_sendfile=>true
				
			else
				redirect_to user_path(current_user)
			end
			
  	else
  		flash[:notice]="you haven't uploaded a cv yet! Upload one."
			render 'edit'
  	end
				
	end
	
	def new
    @jobseeker = current_user.build_jobseeker
  	@title = "Create Your Profile"
	end
	
	#allows creation of jobseeker details on signup/posting them
	def create
		#build holds the entered details but does not save to the database.
		@jobseeker = current_user.build_jobseeker(params[:jobseeker])
		upload_cv
				
		#if saving the details to the db returns true...else...
		if @jobseeker.save
			flash[:success] = "success! your profile information has been saved."			
			redirect_to current_user
		else
			render 'new'
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
			#don't use render 'new' because it refers to @jobseeker from this action(and in this section of action, its nil.)
			redirect_to new_jobseeker_path
		end
		
	end
	
	#for updating attributes
	def update
		@jobseeker = Jobseeker.find(params[:id])
		upload_cv
		
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
	
	def upload_cv
		uploaded_io = params[:jobseeker][:cv]
		
		#if a file has been uploaded
		if uploaded_io
		
			#convert its type into string
			@type = uploaded_io.content_type.to_s
			
			#save it if the type is pdf
			if @type == "application/pdf"
				
				File.open(Rails.root.join('public', 'uploads', @jobseeker.id.to_s), 'wb') do |file|
						file.write(uploaded_io.read)
				end
				
				#make cv_type = 'application/pdf'(so it passes validation)
				@jobseeker.cv_type = @type
				
			else
				#return an error o trying to save wrong type(active record returns the error)
				@jobseeker.cv_type = @type
			end
		else
			#nothing is uploaded, ensure validations passes
			@jobseeker.cv_type = "application/pdf"
		end
  end
	
end
