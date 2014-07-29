class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  before_filter :prepare_for_mobile

#its a modeule that is part of the sessions controller we created.
#we include it in here so we can use its functions(described in it) in controllers. by default, all helpers are available in
# the views but not in the controllers
  include SessionsHelper
  
  
  private
  
  def mobile_device?
		if session[:mobile_param]
			session[:mobile_param] == "1"
		else
			request.user_agent =~ /Mobile|webOS/
		end
  	
  end
  helper_method :mobile_device?
  #makes mobile_device a helper mthd
  
  def prepare_for_mobile
  	session[:mobile_param] = params[:mobile] if params[:mobile]
  end
  
end
