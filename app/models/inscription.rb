class Inscription < ActiveRecord::Base

attr_accessible :etat, :aime, :user_id, :evenement_id
	belongs_to :evenement
	belongs_to :evenement
	
	validates :user_id, :presence => true
	validates :evenement_id, :presence => true

	def init(user,evenement)
    		self.user_id  = user
    		self.evenement_id = evenement
		self.etat = "Ins"
		self.aime = "N"
	end
end
