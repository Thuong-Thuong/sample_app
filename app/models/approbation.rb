class Approbation < ActiveRecord::Base

	attr_accessible :approbation
	belongs_to :temoignage, :class_name => "Temoignage"
	belongs_to :user, :class_name => "User"

	validates :approuver_id, :presence => true
     	validates :temoignage_id, :presence => true

     	default_scope { order(created_at: :desc) }

	def init(approuver,temoignage)
    		self.approuver_id = approuver
		self.temoignage_id  = temoignage
	end

end
