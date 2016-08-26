class Approbation < ActiveRecord::Base
	attr_accessible :approuve
	belongs_to :temoignage, :class_name => "Temoignage"
	belongs_to :user, :class_name => "User"
	default_scope { order(created_at: :desc) }

	def init(approuver,temoignage)
    	self.approuver_id = approuver
		self.temoignage_id  = temoignage
	end

end
