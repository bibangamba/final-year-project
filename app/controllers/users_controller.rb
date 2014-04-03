class UsersController < ApplicationController

	#before_filter goes through the authenticate mthd before
	#calling the actions specified
	#also, by default b4_filter applies to all actions in the controller, ':only' restricts it to those specified.
	#:authenticate->must be signed in, :correct_user->must be the current user, :admin_user-> must be an admin, 
	#:not_signed_in->must be signed out to access, :
	before_filter :authenticate, :except =>[:show, :new, :create]
	before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => :destroy
  before_filter :not_signed_in, :only => [:new, :create]
  
  def index
		@title = "All users"
		#@users = User.all #out puts a list of all
		@users = User.paginate(:page => params[:page])#divides them up into chunks of 30 with links to other pages
	end
  
  
  def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(:page => params[:page])
		@title = @user.name
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
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			@title = "Sign up"
			render 'new'
		end
	end
	
	def edit
		#@user = User.find(params[:id])#[we remove it coz its defined in correct_user mthd(at the bottom of this controller)]
		@title = "Edit user"
	end
	
	def update
		@user = User.find(params[:id])
	
		if @user.update_attributes(params[:user])
			flash[:success] = "Profile updated."
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
	
	#following & followers actions
	def following
		@title = "Following"
		@user = User.find(params[:id])
		@users = @user.following.paginate(:page => params[:page])
		render 'show_follow'
	end

	def followers
		@title = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(:page => params[:page])
		render 'show_follow'
	end#following & followers actions
	
	
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
			redirect_to(root_path) unless !signed_in?
			flash[:notice] = "You are already a registered user. Please sign out to register another user!"
		else
		end
					
		end
		
end
