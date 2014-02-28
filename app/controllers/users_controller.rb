class UsersController < ApplicationController
  
  def show
		@user = User.find(params[:id])
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
			flash[:success] = "Welcome to the Sample App!"
			redirect_to @user
		else
			@title = "Sign up"
			render 'new'
		end
	end

end
