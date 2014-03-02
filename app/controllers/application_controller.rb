class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

#its a modeule that is part of the sessions controller we created.
#we include it in here so we can use its functions(described in it) in controllers. by default, all helpers are available in
# the views but not in the controllers
  include SessionsHelper
  
end
