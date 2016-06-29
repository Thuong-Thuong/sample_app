class Proasuivre < ActiveRecord::Base
	attr_accessible :proasuivre
	belongs_to :user, :class_name => "User"
	belongs_to :pro, :class_name => "User"
	validates :user_id, :presence => true
    validates :pro_id, :presence => true
	validates :asuivre, :presence => true

	def init(user,pro,proasuivre)
    		self.user_id  = user
    		self.pro_id = pro
            self.asuivre = 1
	end

end
