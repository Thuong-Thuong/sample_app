class Conversation < ActiveRecord::Base
	attr_reader :user_tokens
	attr_accessible :body, :sender_id, :recipient_id, :user_tokens
	belongs_to :sender, :class_name => 'User'
	has_many :recipients
	has_many :users, :through => :recipients
	accepts_nested_attributes_for :recipients, :allow_destroy => true
	def user_tokens=(ids)
		self.user_ids = ids
	end
	def init(sender,receiver)
		self.sender_id  = sender
		self.recipient_id = receiver
	end
end
