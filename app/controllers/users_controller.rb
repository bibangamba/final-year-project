class UsersController < ApplicationController
  
  def show
		@user = User.find(params[:id])
	end
  
  def new
  	@title = "Sign up"
  end

#	private #is replacement for attr_accessible in user.rb(model) but am going to install protecte_attributes gem so i can use attr_accessible again
#  def app_params
#  params.require(:user).permit(:name, :email)
#  end
end
