require 'spec_helper'

describe JobseekersController do
	render_views
	
	describe "access control" do
		
		it "should deny access to 'create'" do
			post :create
			response.should redirect_to(signin_path)
		end
		
		it "should deny access to 'destroy'" do
			delete :destroy, :id => 1
			response.should redirect_to(signin_path)
		end
	end

	describe "POST 'create'" do
		before(:each) do
		#tst_sgn_in mthd is in 'spec_helper' and enables signing in test enviroment
			@user = test_sign_in(FactoryGirl.create(:user))
		end

		describe "failure" do
			before(:each) do
			@attr = {	
							:dob => "",
							:sex => "",
							:location => "",
							:phone => "",
							:qualification => "",
							:experience => "",
							:field => "",
							:cv_name => "",
							:summary => ""	}
			end
		
			it "should not create jobseeker details" do
			#lbda is a ruby construct that checks that model has/hasn't changed after an operation
				lambda do
				post :create, :jobseeker => @attr
				end.should_not change(Jobseeker, :count)
			end
			
			it "should render the home page" do
				post :create, :jobseekser => @attr
				response.should render_template('pages/home')
			end
		end
	
		describe "success" do
			before(:each) do
			@attr = {	
						:dob => "1992-06-13",
						:sex => "male",
						:location => "kampala",
						:phone => "0785999930",
						:qualification => "programmer",
						:experience => "2",
						:field => "computer science",
						:cv_name => "bibangamba",
						:summary => "hardworking"	}
			end
			
			it "should create a jobseeker details instance" do
				lambda do
					post :create, :jobseeker => @attr
				end.should change(Jobseeker, :count).by(1)
			end
	
			it "should redirect to the home page" do
				post :create, :jobseeker => @attr
				response.should redirect_to(root_path)
			end
			
			it "should have a flash message" do
				post :create, :jobseeker => @attr
				flash[:success].should =~ /Your profile information has been information has been saved./i
			end
		end
	end
end
