class Jaime < ActiveRecord::Base
	attr_accessible :jaime, :user_id, :evenement_id
	belongs_to :evenement
	belongs_to :user	
	validates :user_id, :presence => true
	validates :evenement_id, :presence => true

	def init(user,evenement)
    	self.user_id  = user
    	self.evenement_id = evenement
		self.jaime = "true"
	end

end
