# By using the symbol ':user', we get Factory Girl to simulate the User model.

FactoryGirl.define do
	factory :user do
		name "bibangamba"
		email "bibangamba@gmail.com"
		password "yurizahard"
		password_confirmation "yurizahard"
	end
	
		sequence :email do |n|
			"person-#{n}@example.com"
		end
end
