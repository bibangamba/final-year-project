class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
  	user = User.find_by_email(params[:email])
  	user.send_password_reset if user
  	redirect_to root_url, :notice => "Email with password reset instructions has been sent."
  end
  
  def edit
  	@user = User.find_by_password_reset_token!(params[:id])
  end

  def update
  	@user = User.find_by_password_reset_token!(params[:id])
  	
  	if @user.password_sent_at < 3.hours.ago
  		redirect_to new_password_reset_path, :alert => "password reset has expired!"
  	elsif @user.update_attributes(params[:user])
  		redirect_to root_url, :notice => "Password has been reset."
  	else
  		render 'edit'
  	end
  end
end
