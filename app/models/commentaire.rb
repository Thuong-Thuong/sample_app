class Commentaire < ActiveRecord::Base
	attr_accessible :commentaire 
	belongs_to :evenement
	validates :commentaire, :presence => true
	
	def init(commentateur, evenement)
    		self.commentateur_id  = commentateur
    		self.evenement_id = evenement
	end

end
