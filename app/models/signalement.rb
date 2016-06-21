class Signalement < ActiveRecord::Base
	attr_accessible :signalement, :validation
	belongs_to :user
	validates :signalement, :presence => true
	validates :id_signaleur, :presence => true
	default_scope { order(created_at: :desc) }
	
	
	def init(user)
    		self.id_signaleur = user
    	end

	def feed_signalement
     		Signalement.where("id_signaleur = ?", $signal_id )
	end

end
