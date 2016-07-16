class Commentaire < ActiveRecord::Base
	attr_accessible :commentaire 
	belongs_to :evenement
	belongs_to :user
	has_many :reponses, :foreign_key => "commentaire_id" , :dependent => :destroy 
	validates :commentaire, :presence => true
	
	def init(commentateur, evenement)
		self.commentateur_id  = commentateur
		self.evenement_id = evenement
	end
 end
