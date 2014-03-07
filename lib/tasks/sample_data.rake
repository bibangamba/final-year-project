require 'faker'

namespace :db do
	desc "Fill database with sample data"
	task :populate => :environment do #by pointing it to the enviroment variable means it can access the rails local envr and 	#use: User.create! and such methods

		Rake::Task['db:reset'].invoke
			
			admin = User.create!(:name => "bibangamba",
				:email => "andrewbibangamba@gmail.com",
				:password => "# 18 Ichigo",
				:password_confirmation => "# 18 Ichigo")
				
				admin.toggle!(:admin)

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
end
