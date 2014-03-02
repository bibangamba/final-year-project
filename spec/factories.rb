# By using the symbol ':user', we get Factory Girl to simulate the User model.

FactoryGirl.define :user do |user|
	user.name "bibangamba"
	user.email "bibangamba@zahard.com"
	user.password "hazahard"
	user.password_confirmation "hazahard"
end
