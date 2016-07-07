class Message < ActiveRecord::Base
	attr_accessible :message
	belongs_to :user, :class_name => "User"
	validates :message, :presence => true
	has_many :reverse_messages, :foreign_key => "sender_id",
                                   :class_name => "Message"
	default_scope { order(created_at: :desc) }
	def init(sender,receiver)
		self.sender_id  = sender
		self.receiver_id = receiver
	end
end
