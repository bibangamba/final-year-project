module SessionsHelper
#sessions helper is accessible to all controllers coz its included in the application controller
	
	def sign_in(user)
	  
	  #status of 'remember me' checkbox sets cookie to be permanent or not
	  if params[:remember_me]
  		cookies.permanent.signed[:remember_token] = [user.id, user.salt]
  		#[permanent=20.years.from_now(according to rails), signed=secure(tells browser not to show user id )]
  	else
  		cookies.signed[:remember_token] = [user.id, user.salt]
  	end
		
		current_user = user #might have to use self.current_user on other systems

	end
	
	def current_user
	#||= means: if '@c_usr' = nil, assign it 'usr_frm_rmbr_tkn' else leave it alone
		@current_user ||= user_from_remember_token
	end
	
	def signed_in?
		!current_user.nil?
	end
	
	def sign_out
		cookies.delete(:remember_token)
		current_user = nil
		#rdirct 2 hme is in sessns_cntrlr - destry action
	end
			
	def authenticate
		deny_access unless signed_in?
	end

			#redirect(to the page) a user tried to access signing in
		def deny_access
			store_location
			redirect_to signin_path, :notice => "Please sign in to access this page."
		end
		
		def redirect_back_or(default)
		#passed args is 'pages_home_path' so default = 'pages_home_path'
			redirect_to(session[:return_to] || default)
			clear_return_to
		end
		
		#boolean method i.e. 'mthd?' checks if it returns true or false
		def current_user?(user)
			user == current_user
		end



	private
		
		def user_from_remember_token
		#rmbr_tkn is a 2 elmnt arry, *rmbr_tkn allows us 2 use thse 2 elmnts as args in a mthd xpctng 2 args
			
			User.authenticate_with_salt(*remember_token)
			
			#auth_wth_slt is in user.rb (model)
		end

		#rmbr_token actn used in usr_frm_rmbr_tkn action
		def remember_token
		#if rmbr_tkn is nil rtrn arry of [nil,nil] (prevents app from breaking)
			cookies.signed[:remember_token] || [nil, nil]
		end
		
		def store_location
			#stores url you wanted to go to before signing in.
			session[:return_to] = request.fullpath #request(is an object) gets the attempted url
		end
		
		def clear_return_to
			#clears session[:return_to]
			session[:return_to] = nil
		end

end
