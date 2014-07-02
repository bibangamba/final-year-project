# == Schema Information
#
# Table name: jobseekers
#
#  id            :integer          not null, primary key
#  user_id       :integer
#  dob           :date
#  sex           :string(255)
#  location      :string(255)
#  phone         :integer
#  qualification :string(255)
#  experience    :integer
#  field         :string(255)
#  cv_name       :string(255)
#  summary       :text
#  created_at    :datetime
#  updated_at    :datetime
#

class Jobseeker < ActiveRecord::Base
		
		#add protected_attributes gem to the Gemfile
		attr_accessible :dob,#1992-09-12
										:sex,#male,female
										:location,#kampala
										:phone,#no.
										:qualification,#degeree
										:experience,#years{1,2,3}
										:field,#computer science
										:cv_name,#id
										:summary#abot you
										
		belongs_to :user
		
		validates_presence_of :dob, :sex, :location, :phone, :qualification, :experience, :field
		validates :summary, :length => {:maximum=>400}
		validates :phone, :length => {:maximum=>13, :minimum=>10}
		validates :experience, :length => {:maximum=>2, :minimum=>1}
		# 'only_integer' uses regx: /\A[+-]?\d+\Z/
		validates_numericality_of :phone, :experience, :only_integer => true
		validate :over_15
		
		
	def over_15
		if dob + 15.years >= Date.today
		  errors.add(:dob,": your age can't be under 15")
		end
	end
		
		#returns jobseeker details starting with most recently added ones
		default_scope :order => 'jobseekers.created_at DESC'
		
end
