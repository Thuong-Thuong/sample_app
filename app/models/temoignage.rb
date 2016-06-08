class Temoignage < ActiveRecord::Base
	attr_accessible :temoignage
	belongs_to :user, :class_name => "User"
	belongs_to :pro, :class_name => "User"
	validates :user_id, :presence => true
     validates :pro_id, :presence => true
	validates :temoignage, :presence => true
	default_scope { order(created_at: :desc) }

	def init(user,pro)
    		self.user_id  = user
    		self.pro_id = pro
	end
end
