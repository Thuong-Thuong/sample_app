class Signalement < ActiveRecord::Base
	attr_accessible :signalement, :validation
	belongs_to :user
	validates :signalement, :presence => true
	validates :id_signaleur, :presence => true
	default_scope { order(created_at: :desc) }
	
	
	def init(user,pro)
    		self.id_signaleur = user
           self.pro_id = pro
    	end

	
end
