class Recipient < ActiveRecord::Base
	belongs_to :user
	has_one :conversation
   	accepts_nested_attributes_for :conversation
	def init(conversation,user)
		self.conversation_id  = conversation
		self.user_id = user
	end
end
