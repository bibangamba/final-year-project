require 'faker'

namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do #by pointing it to the enviroment variable means it can access the rails local envr and 	#use: User.create! and such methods

		Rake::Task['db:reset'].invoke
			make_users
			make_microposts
			make_relationships
		end
		
		def make_users
			#makes an admin user
			admin = User.create!(:name => "bibangamba",
				:email => "andrewbibangamba@gmail.com",
				:password => "# 18 Ichigo",
				:password_confirmation => "# 18 Ichigo")
				
				admin.toggle!(:admin)#changing field admin from false to true
			
			#creates other non admin users(99 in total)
			99.times do |n|
				name = Faker::Name.name
				email = "example-#{n+1}@railstutorial.org"
				password = "password"
	
				User.create!(:name => name,
					:email => email,
					:password => password,
					:password_confirmation => password)
			end
		end
		
		def make_microposts
			User.all(:limit => 6).each do |user|
				50.times do
					user.microposts.create!(:content => Faker::Lorem.sentence(5))
				end
			end
		end
		
		def make_relationships
			users = User.all
			user = users.first
			following = users[1..50]
			followers = users[3..40]
			following.each { |followed| user.follow!(followed) }#block
			followers.each { |follower| follower.follow!(user) }#block
		end
end
