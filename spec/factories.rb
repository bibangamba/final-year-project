# By using the symbol ':user', we get Factory Girl to simulate the User model.

FactoryGirl.define do
	factory :user do
		name "bibangamba"
		email "bibangamba@zahard.com"
		password "hazahard"
		password_confirmation "hazahard"
	end
	

		sequence :email do |n|
			"person-#{n}@example.com"
		end
end
