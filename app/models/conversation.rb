class Conversation < ActiveRecord::Base
	attr_accessor :conversation_ids, :user_tokens
	attr_accessible :body, :sender_id
	belongs_to :sender, :class_name => 'User'
	has_many :recipients,:foreign_key => "conversation_id", :dependent => :destroy
	has_many :users, :through => :recipients
	default_scope { order(created_at: :desc) }

end
