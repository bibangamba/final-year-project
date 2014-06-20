class SessionsController < ApplicationController
  
  def new
  	@title = "Sign in"
  end
  
	#the action is create coz we are creating a session(signing-in)
  def create
  	user = User.authenticate(params[:session][:email],params[:session][:password])
		
		if user.nil?

			flash.now[:error] = "Invalid email/password combination."
			@title = "Sign in"
  		render 'new'
  		
  	else
  	  	
  	#sign_in & redirect_back_or actions is in sessions_helper.rb(for universal access by controllers)
  		sign_in user
			redirect_back_or user
			
  	end
  end
  
  def destroy
  #sign_out : session_helper.rb
		sign_out
		redirect_to root_path,:notice => "Signed out."
  end
  
end
