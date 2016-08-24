class Temoignage < ActiveRecord::Base
	attr_accessible :temoignage
	belongs_to :user, :class_name => "User"
	belongs_to :pro, :class_name => "User"
	validates :user_id, :presence => true
	validates :pro_id, :presence => true
	validates :temoignage, :presence => true

	has_many :approbations, :foreign_key => "temoignage_id",:dependent => :destroy
	default_scope { order(created_at: :desc) }

	def init(user,pro)
		self.user_id  = user
		self.pro_id = pro
	end

	def approbations
     		Approbation.where("temoignage_id = ? AND approuve = ? " , $temoignage_id, 1)
	end
	def desapprobations
     		Approbation.where("temoignage_id = ? AND approuve = ? " , $temoignage_id, 0)
	end

end
