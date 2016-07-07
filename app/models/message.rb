class Message < ActiveRecord::Base
	attr_accessible :message
	belongs_to :user, :class_name => "User"
	validates :message, :presence => true
	default_scope { order(created_at: :desc) }
	def init(sender,receiver)
		self.sender_id  = sender
		self.receiver_id = receiver
	end
end
