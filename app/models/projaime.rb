class Projaime < ActiveRecord::Base

	attr_accessible :projaime
	belongs_to :user, :class_name => "User"
	belongs_to :pro, :class_name => "User"
	validates :user_id, :presence => true
    validates :pro_id, :presence => true
	validates :projaime, :presence => true	

	def init(user,pro,projaime)
    	self.user_id  = user
    	self.pro_id = pro
        self.projaime = 1
	end

end
