class Conversation < ActiveRecord::Base
	attr_accessible :body, :sender_id
	belongs_to :sender, :class_name => 'User'
	has_many :recipients
	has_many :users, :through => :recipients
end
