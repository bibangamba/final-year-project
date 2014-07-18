# == Schema Information
#
# Table name: users
#
#  id                   :integer          not null, primary key
#  first_name           :string(255)
#  email                :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  encrypted_password   :string(255)
#  salt                 :string(255)
#  admin                :boolean
#  password_reset_token :string(255)
#  password_sent_at     :datetime
#  role                 :string(255)
#  last_name            :string(255)
#

#[NOTE]format inconsistency is used to show different ways of using the rules e. :key => value or key: value

require 'digest' #not neccessary on my system but others might need it so...

class User < ActiveRecord::Base

	#attr_accessor creates a virtual attribute(saved in memory) & isn't part of the database
	#lets rails know w/c attributes are accessible i.e can be modified by external entities e.g submission from a web browser.
	#[USE strong_parameters in the user_controller class] or add protected_attributes gem to the Gemfile
		 	
	attr_accessor :password #virtual attr created

	attr_accessible :first_name,
									:last_name,
									:email,
									:password,
									:password_confirmation,
									:role

	#:dependent option deletes all microposts associated with the destroyed user
	has_one :jobseeker, :foreign_key => "user_id", :dependent => :destroy
	has_many :job, :foreign_key => "employer_id", :dependent=>:destroy
	
	
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	#both methods for validating presence are fine. 
	validates :first_name, :presence => true,
																			:length => {:maximum => 50}, unless: Proc.new { |a| !a.new_record? && a.password.blank? }
	
	#unless: Proc.new{} block enables sving /w no vldtn if rcrd alrdy xists
	
	validates :last_name, presence:true,
																:length => {:maximum => 50}, unless: Proc.new { |a| !a.new_record? && a.password.blank? }
	
	validates :email, presence: true,
										format: {with: email_regex},
										:uniqueness => { :case_sensitive => false }, unless: Proc.new { |a| !a.new_record? && a.password.blank? }
	
	validates :password, :presence => true, 
											 :confirmation => true, #makes use of virtual attribute created
											 :length => {:within => 8..40}, unless: Proc.new { |a| !a.new_record? && a.password.blank? }
											 
	validates :role, presence:true,
																:length => {:maximum => 12}, unless: Proc.new { |a| !a.new_record? && a.password.blank? }
	
	before_save :encrypt_password
	
	# Return true if the user's password matches the submitted password.
	
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password) #again we aren't assigning encrypted the 'self.encr...' so isn't a must
	end
	
	def self.authenticate(email, submitted_password)#self in this case is the class User
		#if its inside the method, it'd be referring to an instance of the class, i.e a user[find_by_email is in active_record]
		user = find_by_email(email)
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
	end
	
	#mthd for cookies
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		#if they match then return the user else return nil
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	
	#pswd reset instrctns sndng mthd
	def send_password_reset
		generate_token(:password_reset_token)
		self.password_sent_at = Time.zone.now
		save!
		UserMailer.password_reset(self).deliver
	end
	
	#rndm tkn gnrtr
	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64			
		end while User.exists?(column => self[column])		
	end
	
	
	private

#self is not optional when assigning an attr(self.encry...)however when u call an attribute, its presence is optional[(pass..)]
		def encrypt_password
		
			self.salt = make_salt if new_record? #new_record? is an active_record boolean mthd(checks if object hasn't been saved to the db yet) so it doesn't change on updating a user
			
			self.encrypted_password = encrypt(password)
		end
		
		#method encrypts password or any string passed to it.
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		#use current time and passwordto make the salt
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
	
end
