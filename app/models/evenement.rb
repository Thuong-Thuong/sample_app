class Evenement < ActiveRecord::Base
	attr_accessible :titre, :description, :date_evenmt, :lieu_evenmt, :date_rdv, :lieu_rdv, :prix, :nbmax, :statut, :theme, :mot_cle, :heure_evenmt
	belongs_to :user
	validates :titre, :presence => true, :length => { :maximum => 140 }
	validates :description, :presence => true
	validates :user_id, :presence => true
	default_scope { order(created_at: :desc) }
	
	has_many :interesses,  :class_name => 'Interesse', :foreign_key => "evenement_id",  :dependent  => :destroy
	has_many :inscriptions, :foreign_key => "evenement_id",   :dependent => :destroy
	has_many :jaimes, :foreign_key => "evenement_id",  :dependent => :destroy
	has_many :commentaires,:foreign_key => "evenement_id",   :dependent => :destroy
	has_many :signalevens, :foreign_key => "even_id", :dependent => :destroy

	def feed_commentaire
		Commentaire.where("evenement_id = ?", $even_id )
	end

	def feed_inscription
		Inscription.where("evenement_id = ?", $even_id)
	end

	def self.search_titre(search_titre)
		where("titre LIKE ?", "%#{search_titre}%") 
	end
	
	def self.search_des(search_des)
		where("description LIKE ?", "%#{search_des}%")
	end
end

