# == Schema Information
#
# Table name: jobs
#
#  id              :integer          not null, primary key
#  employer_id     :string(255)
#  title           :string(255)
#  job_description :string(255)
#  category        :string(255)
#  location        :string(255)
#  vacancies       :integer
#  company         :string(255)
#  contact_phone   :string(255)
#  contact_email   :string(255)
#  post_date       :date
#  deadline        :datetime
#  job_type        :string(255)
#  experience      :integer
#  qualification   :string(255)
#  details         :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Job < ActiveRecord::Base

	attr_accessible :title,          #name of the job
									:category,       #computer, admin
									:location,       #gulu, kampala
									:vacancies,      #3
									:company,        #uganda ltd
									:contact_phone,  #no.
									:contact_email,  #e-address
									:deadline,       #datetime
									:job_description,#short
									:job_type,       #intern, fulltime
									:experience,     #years
									:qualification,  #degree
									:details         #alot
	#association
	belongs_to :user
	
		email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i #[a-z0-9]@[a-z0-9].[a-z] & /i-case insensitive
	
	#format:{rails4} is the new rails 4 way but :format=>{rails3} still works.
	validates :contact_email, format: {with: email_regex}
	validates_presence_of :title, :category, :location,
												:vacancies, :company, :contact_phone,
												:contact_email, :deadline, :job_description,
												:job_type, :experience, :qualification, :details
	validates :contact_phone, :length => {:maximum=>13, :minimum=>10}
	validates :experience, :length => {:maximum=>2, :minimum=>1}
	validates :job_description, :length => {:maximum=>160}
	# 'only_integer' uses regx: /\A[+-]?\d+\Z/
	validates_numericality_of :contact_phone, :experience, :only_integer => true
	

end
