class Reponse < ActiveRecord::Base
	attr_accessible :reponse
	belongs_to :user
	belongs_to :commentaire
	validates :reponse, :presence => true
	default_scope { order(created_at: :desc) }

	def init(user,commentaire)
		self.user_id  = user
		self.commentaire_id = commentaire
	end

end
