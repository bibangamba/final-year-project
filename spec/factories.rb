# By using the symbol ':user', we get Factory Girl to simulate the User model.

FactoryGirl.define do
	factory :user do
		first_name "andrew"
		last_name "bibangamba"
		email "bibangamba@gmail.com"
		password "yurizahard"
		password_confirmation "yurizahard"
		role "jobseeker"
	end
	
	sequence :email do |n|
		"person-#{n}@example.com"
	end
	
	factory :micropost do |micropost|
		micropost.content "foo bar(what's with this guy's obsession with foobar?)"
		micropost.association :user
	end
end
