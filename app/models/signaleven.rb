class Signaleven < ActiveRecord::Base
	attr_accessible :signalement, :validation
	belongs_to :evenement
	validates :signalement, :presence => true
	default_scope { order(created_at: :desc) }
	
	
	def init(user,even)
    		self.id_signaleur = user
           self.even_id = even
    	end


end
