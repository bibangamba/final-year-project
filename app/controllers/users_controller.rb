class UsersController < ApplicationController

	#before_filter goes through the authenticate mthd before
	#calling the actions specified
	#also, by default b4_filter applies to all actions in the controller, ':only' restricts it to those specified.
	#:authenticate->must be signed in, :correct_user->must be the current user, :admin_user-> must be an admin, 
	#:not_signed_in->must be signed out to access, :
	before_filter :authenticate, :except =>[:show, :new, :create,:mobile, :mobile_get]
	before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  before_filter :not_signed_in, :only => [:new, :create]
  #prevent rails from doing csrf check on login from mobile
  
  protect_from_forgery :except => [:mobile, :mobile_get]
  
  def index
		@title = "All users"
		#@users = User.all #out puts a list of all
		@users = User.paginate(:page => params[:page])#divides them up into chunks of 30 with links to other pages
	end
  
  
  def show
		@user = User.find(params[:id])
		
		if @user.jobseeker
			@jobseeker = @user.jobseeker#.paginate(:page => params[:page])
			@title = @user.first_name
		else
			@jobseeker = @user.jobseeker
			@title = @user.first_name
		end
		
	end
  
  def new
  	@user = User.new
  	@title = "Sign up"
  end

#	private #is replacement for attr_accessible in user.rb(model) but am going to install protecte_attributes gem so i can use attr_accessible again
#  def app_params
#  params.require(:user).permit(:name, :email)
#  end

	def create
		@user = User.new(params[:user])

		if @user.save
			sign_in @user #signs in the signed up user
			flash[:success] = "Hi #{@user.first_name}, welcome to JobRadar. "
			#redirect_to @user
			if @user.role== "jobseeker"
				redirect_to new_jobseeker_path
			elsif @user.role=="employer"
				redirect_to new_job_path
			end
		else
			@title = "Sign up"
			render 'new'
		end
	end
	
	def edit
		@user = User.find(params[:id])#[we remove it coz its defined in correct_user mthd(at the bottom of this controller)]
		@title = "Edit user"
	end
	
	def update
		@user = User.find(params[:id])
	
		if @user.update_attributes(params[:user])
			flash[:success] = "settings changed."
			redirect_to @user
		else
			@title = "Edit user"
			render 'edit'
		end
	end
	
	def destroy
		@user = User.find(params[:id])
		if @user.admin? && current_user?(@user)
			flash[:notice] = "You cannot delete yourself!"
			redirect_to users_path
		else
			@user.destroy
			flash[:success] = "User deleted!"
			redirect_to users_path
		end
	end
	
	
	def mobile
		@email = params[:uname]
		@password = params[:paswad]
		
		@user = User.authenticate(@email, @password)
		
		if @user.nil?
			request = {"success" => 0, "message" => "Email/Password combination was not found."}
		else
			firstname = @user.first_name
			username = @user.last_name
			role = @user.role
			id = @user.id

			request = {"success" => 1, "message" => "Authenticated.", "user" => "#{username}", "first_name" => "#{firstname}", "role" => "#{role}", "id" => "#{id}"}
		end
		
		render :json => request#renders json as reply
		
		#format.json  { render :json => request } # don't do msg.to_json
		#@response = request.to_json
		
	end
	
	def mobile_get
		@last = params[:Last_user]
  	@post_id = params[:Employer]
		
		posted_jobs = Job.find_all_by_employer_id(@post_id)
		posted_jobs.each do |jobs|
			(@categories ||=[]) << jobs.category#get each posted jobs category and append it to categories array
		end
		
		#removing duplicate categories
		@categories = @categories.uniq		
		
		@seekers = Jobseeker.where(:field => @categories).all		
#User.find_by_sql("SELECT first_name,dob FROM users INNER JOIN jobseekers ON users.id = jobseekers.user_id WHERE users.id = '1'")
#

		@seekers.each do |jobseeker|
			(@ids ||=[]) << jobseeker.user_id
		end
		
		@user = User.where(:id => @ids)
		

=begin
				
		@categories.each do |category|
			(@seekers ||=[]) << Jobseeker.find_all_by_field(@categories)#all(:conditions=>"field = '#{category}'")
		end

=end			
			if @last.to_i < 1
				@jobseekers = User.select("*").joins(:jobseeker).where(:id => @ids)#.to_json
				status = {"info" => @jobseekers}
			elsif @last.to_i < @user.last.id
				@jobseekers = User.select("*").joins(:jobseeker).where("users.id >= #{@last}")#.to_json
				status = {"info" => @jobseekers}
			elsif @last.to_i >= @user.last.id
				status = {"info" => "No updates"}
			end

  	
  	render :json => status							
		 
	end
	
	private
		
		#moved to sessions helper so it can be accessed by all controllers
	#	def authenticate
	#		deny_access unless signed_in?
	#	end
		
		#prevents  signed-in users from editing info that is not their own
		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
		
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		#	@admin = User.find(params[:id])
		#	if @admin == current_user.admin?
		#		flash[:notice] = "You can not delete yourself!"
		#		redirect_to(users_path)
		#	else
		#	return
		#	end
		end
		
		def not_signed_in

		if signed_in?
			redirect_to(root_path)
			flash[:notice] = "You are already a registered user. Please sign out to register another user!"
		end
					
		end
		
end
