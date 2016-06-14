class Evenement < ActiveRecord::Base
	attr_accessible :titre, :description, :date_evenmt, :lieu_evenmt, :date_rdv, :lieu_rdv, :prix, :nbmax, :statut, :theme, :mot_cle, :heure_evenmt
	belongs_to :user
	validates :titre, :presence => true, :length => { :maximum => 140 }
	validates :user_id, :presence => true
	default_scope { order(created_at: :desc) }
	
	has_many :interesses,  :class_name => 'Interesse', :dependent  => :destroy
	has_many :inscriptions, :dependent => :destroy
	has_many :jaimes, :dependent => :destroy
	has_many :commentaires, :dependent => :destroy

	def feed_commentaire
     		Commentaire.where("evenement_id = ?", $even_id )
	end





 end




