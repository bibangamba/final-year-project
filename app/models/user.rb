# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class User < ActiveRecord::Base
	#lets rails know w/c attributes are accessible i.e can be modified by external entities e.g submission from a web browser.
	attr_accessible :name,:email #[USE strong_parameters in the user_controller class] or add protected_attributes gem to the Gemfile
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	#both methods for validating presence are fine.
	validates :name, :presence => true, :length => {:maximum => 50}
	validates :email, presence: true,
										format: {with: email_regex, message: ":regular expression returned that the email was invalid!"},
										:uniqueness => { :case_sensitive => false }
end