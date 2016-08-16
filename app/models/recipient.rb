class Recipient < ActiveRecord::Base
	attr_reader :user_tokens
	attr_accessible :conversation_id, :user_id, :user_tokens
	belongs_to :user
	def init(conversation,user)
		self.conversation_id  = conversation
		self.user_id = user
	end
	def user_tokens=(ids)
		self.user_ids = ids
	end
end
