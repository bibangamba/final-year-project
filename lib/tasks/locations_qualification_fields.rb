['None', 'Accounting/Finance/Insurance', 'Administrative/Clerical/Office', 'Agriculture/Forestry/Fishing', 'Banking', 'Building Construction/Skilled Trades', 'Business/Strategic Management', 'Creative/Design/Architectural', 'Customer Support/Client Care', 'Editorial/Writing', 'Education', 'Engineering', 'Entertainment Venues and Theaters', 'Food Services/Hospitality', 'Government and Military', 'Hotels and Lodging', 'Human Resources', 'Installation/Maintenance/Repair', 'IT/Software Development', 'Legal', 'Logistics/Transportation', 'Management Consulting Services', 'Manufacturing', 'Marketing/Adevertising', 'Medical/Health','Printing and Publishing', 'Project/Program Management', 'Public Relations','Real Estate / Property Management', 'Security/Protective Services', 'Sales']

['None','O level','A level','Certificate','Diploma','Degree','Masters','PhD holder']

['kampala','gulu','mbarara','kabale','soroti','soroti','lira','jinja','fortportal','masindi','arua','rukungiri','masaka',]

['None','Internship', 'Volunteer', 'Freelance', 'Part-time', 'Full-time']





















						jobseeker.user_id = user.id
						jobseeker.dob = 15.years.ago.to_date..70.years.ago.to_date
						jobseeker.sex = ['male','female']
						jobseeker.location = ['kampala','gulu','mbarara','kabale','soroti','soroti','lira','jinja','fortportal','masindi','arua','rukungiri','masaka',]
						jobseeker.phone = Faker::PhoneNumber.phone_number
						jobseeker.qualification=['None','O level','A level','Certificate','Diploma','Degree','Masters','PhD holder']
						jobseeker.experience = 0..5
						jobseeker.field = ['None', 'Accounting/Finance/Insurance', 'Administrative/Clerical/Office', 'Agriculture/Forestry/Fishing', 'Banking', 'Building Construction/Skilled Trades', 'Business/Strategic Management', 'Creative/Design/Architectural', 'Customer Support/Client Care', 'Editorial/Writing', 'Education', 'Engineering', 'Entertainment Venues and Theaters', 'Food Services/Hospitality', 'Government and Military', 'Hotels and Lodging', 'Human Resources', 'Installation/Maintenance/Repair', 'IT/Software Development', 'Legal', 'Logistics/Transportation', 'Management Consulting Services', 'Manufacturing', 'Marketing/Adevertising', 'Medical/Health','Printing and Publishing', 'Project/Program Management', 'Public Relations','Real Estate / Property Management', 'Security/Protective Services', 'Sales']
						jobseeker.summary = Populator.sentences(3..10)
						
						
						
						
						
						
						
						
						
						
						
						
						







						job.employer_id = user.id
						job.title =  Populator.words(1..4)
						job.job_description = Populator.sentences(3..5)
						job.category = ['None', 'Accounting/Finance/Insurance', 'Administrative/Clerical/Office', 'Agriculture/Forestry/Fishing', 'Banking', 'Building Construction/Skilled Trades', 'Business/Strategic Management', 'Creative/Design/Architectural', 'Customer Support/Client Care', 'Editorial/Writing', 'Education', 'Engineering', 'Entertainment Venues and Theaters', 'Food Services/Hospitality', 'Government and Military', 'Hotels and Lodging', 'Human Resources', 'Installation/Maintenance/Repair', 'IT/Software Development', 'Legal', 'Logistics/Transportation', 'Management Consulting Services', 'Manufacturing', 'Marketing/Adevertising', 'Medical/Health','Printing and Publishing', 'Project/Program Management', 'Public Relations','Real Estate / Property Management', 'Security/Protective Services', 'Sales']
						job.location = ['kampala','gulu','mbarara','kabale','soroti','soroti','lira','jinja','fortportal','masindi','arua','rukungiri','masaka',]
						job.vacancies = 1..10
						job.company = Faker::Company.name
						job.contact_phone = Faker::PhoneNumber.phone_number
						job.contact_email = Faker::Internet.email
						job.deadline = 10.days.from_now
						job.job_type = ['None','Internship', 'Volunteer', 'Freelance', 'Part-time', 'Full-time']
						job.experience = 0..5
						job.qualification = ['None','O level','A level','Certificate','Diploma','Degree','Masters','PhD holder']
						job.details = Populator.sentences(15..40)
						job.max_age = 31..60
						job.min_age = 15..30
						job.requirements = Populator.sentences(15..20)
