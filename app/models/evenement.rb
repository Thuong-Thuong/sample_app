class Evenement < ActiveRecord::Base
 
	attr_accessible :titre, :description, :date_evenmt, :lieu_evenmt, :date_rdv, :lieu_rdv, :prix, :nbmax, :statut, :theme, :mot_cle
	belongs_to :user
	validates :titre, :presence => true, :length => { :maximum => 140 }
	validates :user_id, :presence => true
	#default_scope { order(created_at: :desc) }

end
