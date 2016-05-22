class Friendship < ActiveRecord::Base
	attr_accessible :sender_id, :receiver_id, :status
	belongs_to :sender, :class_name => "User"
  	belongs_to :receiver, :class_name => "User"
	validates :sender_id, :presence => true
  	validates :receiver_id, :presence => true 

end
