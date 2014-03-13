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

#[NOTE]format inconsistency is used to show different ways of using the rules e. :key => value or key: value

require 'digest' #not neccessary on my system but others might need it so...

class User < ActiveRecord::Base

	#attr_accessor creates a virtual attribute(saved in memory) & isn't part of the database
	#lets rails know w/c attributes are accessible i.e can be modified by external entities e.g submission from a web browser.
	#[USE strong_parameters in the user_controller class] or add protected_attributes gem to the Gemfile
		 	
	attr_accessor :password

	attr_accessible :name, :email, :password, :password_confirmation
	
	has_many :microposts, :dependent => :destroy
	#:dependent option deletes all microposts associated with the destroyed user
	
	#specifying the foreign key since rails can't infer
	has_many :relationships,  :foreign_key => "follower_id",
														:dependent => :destroy
	has_many :following, :through => :relationships, :source => :followed
	
	#the reverse relationship
	#we include the class coz rails would otherwise look for ReverseRelationship class that doesn't exist
	has_many :reverse_relationships, :foreign_key => "followed_id",
																	 :class_name => "Relationship",
																	 :dependent => :destroy
has_many :followers, :through => :reverse_relationships, :source => :follower
	
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	
	#both methods for validating presence are fine.
	validates :name, :presence => true, :length => {:maximum => 50}
	
	validates :email, presence: true,
										format: {with: email_regex},
										:uniqueness => { :case_sensitive => false }
	
	validates :password, :presence => true, 
											 :confirmation => true,
											 :length => {:within => 8..40}
	
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
	
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
	
	#following boolean mthd to check if a user is being followed
	#in the case of '.._id(followed)'=> the '.id' can be removed but if it breaks, add it
	def following?(followed)
		relationships.find_by_followed_id(followed)
	end
	
	#creates a relationship and shows exceptions
	#in this case, followed alone breaks so we add '.id'
	def follow!(followed)
		relationships.create!(:followed_id => followed.id)
	end
	
	def unfollow!(followed)
		relationships.find_by_followed_id(followed).destroy
	end
	
	#micropost feed method
	def feed
		Micropost.from_users_followed_by(self)
	end
	
	private

#self is not optional when assigning an attr(self.encry...)however when u call an attribute, its presence is optional[(pass..)]
		def encrypt_password
			self.salt = make_salt if new_record? #new_record? is an active_record boolean mthd(checks if object hasn't been saved to the db yet) so it doesn't change on updating a user
			self.encrypted_password = encrypt(password)
		end
		
		def encrypt(string)
			secure_hash("#{salt}--#{string}")
		end
		
		def make_salt
			secure_hash("#{Time.now.utc}--#{password}")
		end
		
		def secure_hash(string)
			Digest::SHA2.hexdigest(string)
		end
	
end
