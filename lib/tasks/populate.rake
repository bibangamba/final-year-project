=begin

namespace :db do
	desc "fill database"
	task :populate => :environment do
		
		#require 'populator'#for things
		require 'faker'#for people		
		
		200.times do
		
		first_name = Faker::Name.first_name
		last_name = Faker::Name.last_name
		password = "bibangamba"
		role = ['Jobseeker','Employer'].sample
		
			User.create!(
				:first_name => first_name,
				:last_name => last_name,
				:email => Faker::Internet.email(first_name +"."+ last_name),
				:password => "bibangamba",
				:role => role
			)
			
			@employers = User.find_all_by_role("employer")
			
			@employers.each do |employer|
				5.times do
				employer.job.create!( :title => (['Accounting/Finance/Insurance', 'Administrative/Clerical/Office', 'Agriculture/Forestry/Fishing', 'Banking', 'Building Construction/Skilled Trades', 'Business/Strategic Management', 'Creative/Design/Architectural', 'Customer Support/Client Care', 'Editorial/Writing', 'Education', 'Engineering', 'Entertainment Venues and Theaters', 'Food Services/Hospitality', 'Government and Military', 'Hotels and Lodging', 'Human Resources', 'Installation/Maintenance/Repair', 'IT/Software Development', 'Legal', 'Logistics/Transportation', 'Management Consulting Services', 'Manufacturing', 'Marketing/Adevertising', 'Medical/Health','Printing and Publishing', 'Project/Program Management', 'Public Relations','Real Estate / Property Management', 'Security/Protective Services', 'Sales'].sample + " Job"), :job_description => Faker::Lorem.sentence(5), :category => ['None', 'Accounting/Finance/Insurance', 'Administrative/Clerical/Office', 'Agriculture/Forestry/Fishing', 'Banking', 'Building Construction/Skilled Trades', 'Business/Strategic Management', 'Creative/Design/Architectural', 'Customer Support/Client Care', 'Editorial/Writing', 'Education', 'Engineering', 'Entertainment Venues and Theaters', 'Food Services/Hospitality', 'Government and Military', 'Hotels and Lodging', 'Human Resources', 'Installation/Maintenance/Repair', 'IT/Software Development', 'Legal', 'Logistics/Transportation', 'Management Consulting Services', 'Manufacturing', 'Marketing/Adevertising', 'Medical/Health','Printing and Publishing', 'Project/Program Management', 'Public Relations','Real Estate / Property Management', 'Security/Protective Services', 'Sales'].sample, :location => ['kampala','gulu','mbarara','kabale','soroti','soroti','lira','jinja','fortportal','masindi','arua','rukungiri','masaka'].sample, :vacancies => rand(1..7), :company => Faker::Company.name, :contact_phone => rand(1000000000..9999999999999), :contact_email => Faker::Internet.email, :deadline => rand(10.days.from_now..30.days.from_now), :job_type => ['None','Internship', 'Volunteer', 'Freelance', 'Part-time', 'Full-time'].sample, :experience => rand(0..5), :qualification => ['None','O level','A level','Certificate','Diploma','Degree','Masters','PhD holder'].sample, :details => Faker::Lorem.sentence(10), :min_age => rand(19..30), :max_age => rand(31..65), :requirements => Faker::Lorem.sentence(10) )
				end
			end
			
			
			
			@job_seekers = User.find_all_by_role("jobseeker")
			dob = Time.at(rand * Time.now.to_i-18.years).to_date
			sex = ['female','male'].sample
			location = 	['kampala','gulu','mbarara','kabale','soroti','soroti','lira','jinja','fortportal','masindi','arua','rukungiri','masaka',].sample
			phone = rand(1000000000..9999999999999)
			qualification = ['None','O level','A level','Certificate','Diploma','Degree','Masters','PhD holder'].sample
			experience = rand(0..5)
			field = ['None', 'Accounting/Finance/Insurance', 'Administrative/Clerical/Office', 'Agriculture/Forestry/Fishing', 'Banking', 'Building Construction/Skilled Trades', 'Business/Strategic Management', 'Creative/Design/Architectural', 'Customer Support/Client Care', 'Editorial/Writing', 'Education', 'Engineering', 'Entertainment Venues and Theaters', 'Food Services/Hospitality', 'Government and Military', 'Hotels and Lodging', 'Human Resources', 'Installation/Maintenance/Repair', 'IT/Software Development', 'Legal', 'Logistics/Transportation', 'Management Consulting Services', 'Manufacturing', 'Marketing/Adevertising', 'Medical/Health','Printing and Publishing', 'Project/Program Management', 'Public Relations','Real Estate / Property Management', 'Security/Protective Services', 'Sales'].sample
			summary = Faker::Lorem.sentence(5)
			
			@jobseeker.each do |jobseeker|

		end
	end
end

=end
