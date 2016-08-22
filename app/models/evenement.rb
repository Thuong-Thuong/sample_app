class Evenement < ActiveRecord::Base
	attr_accessible :titre, :description, :date_evenmt, :lieu_evenmt, :date_rdv, :lieu_rdv, :prix, :nbmax, :statut, :theme, :mot_cle, :code_postal
	belongs_to :user
	validates :titre, :presence => true, :length => { :maximum => 140 }
	validates :description, :presence => true
	validates :date_evenmt, :presence => true
	validates :date_rdv, :presence => true
	validates :lieu_evenmt, :presence => true
	validates :lieu_rdv, :presence => true
	validates :prix, :presence => true
	validates :nbmax, :presence => true
	validates :code_postal, :presence => true
	validates :user_id, :presence => true
	default_scope { order(date_evenmt: :asc) }
	
	has_many :interesses,  :class_name => 'Interesse', :foreign_key => "evenement_id",  :dependent  => :destroy
	has_many :inscriptions, :foreign_key => "evenement_id",   :dependent => :destroy
	has_many :jaimes, :foreign_key => "evenement_id",  :dependent => :destroy
	has_many :commentaires,:foreign_key => "evenement_id",   :dependent => :destroy
	has_many :signalevens, :foreign_key => "even_id", :dependent => :destroy

	def feed_commentaire
		Commentaire.where("evenement_id = ?", $even_id )
	end

	def feed_inscrit
		Inscription.where("evenement_id = ?", $even_id)
	end
	
	def feed_jaime
		Jaime.where("evenement_id = ?", $even_id)
	end

	def self.search_titre(search_titre)
		where("titre LIKE ?", "%#{search_titre}%") 
	end
	
	def self.search_des(search_des)
		where("description LIKE ?", "%#{search_des}%")
	end

	def self.search_date(search_date)
		where("date_evenmt >= ?", "#{search_date} || 0") 
	end

end

