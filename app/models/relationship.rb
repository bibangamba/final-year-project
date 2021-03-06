# == Schema Information
#
# Table name: relationships
#
#  id          :integer          not null, primary key
#  follower_id :integer
#  followed_id :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Relationship < ActiveRecord::Base
	attr_accessible :followed_id
	
	belongs_to :follower, :class_name => "User"
	belongs_to :followed, :class_name => "User"
	#we supply the classname so rails can infer the foreign keys bcoz follower & followed don't have classes(aren't models)
	
	validates :follower_id, :presence => true
	validates :followed_id, :presence => true
end
