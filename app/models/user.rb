require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password 
	attr_accessible :nom, :email, :password, :password_confirmation, :pro, :datenaissance, :sexe, :adresse, :mobile, :facebook, :google, :twiter, :linkedin, :petitmot, :interet, :notifmail, :notifsms, :siteinternet, :abonnement_statut, :description, :theme, :motcle
	default_scope { order(created_at: :asc) }
	has_many :microposts, :dependent => :destroy
	has_many :signalements,:foreign_key => "id_signaleur", :dependent => :destroy
	has_many :evenements, :dependent => :destroy
	
	has_many :inscriptions, :dependent => :destroy
	has_many :jaimes, :dependent => :destroy
	has_many :interesses, :class_name => 'Interesse', :dependent => :destroy
	has_many :temoignages, :foreign_key => "user_id",:dependent => :destroy
	has_many :messages, :foreign_key => "sender_id",:dependent => :destroy
	has_many :conversations, :foreign_key => :sender_id
	has_many :recipients, :foreign_key => :user_id
	has_many :projaimes, :dependent => :destroy
	has_many :proasuivres, :dependent => :destroy
	has_many :commentaires, :foreign_key => "commentateur_id",:dependent => :destroy
	has_many :reponses, :dependent => :destroy
	
	########################################################################
	has_many :relationships, :foreign_key => "follower_id",
							   :dependent => :destroy
	has_many :following, :through => :relationships, :source => :followed
	has_many :reverse_relationships, :foreign_key => "followed_id",
                                   :class_name => "Relationship",
                                   :dependent => :destroy
	has_many :followers, :through => :reverse_relationships, :source => :follower
	
	########################################################################
	has_many :friendships, :foreign_key => "sender_id",
							   :dependent => :destroy
	has_many :friends, :through => :friendships, :source => :receiver
	has_many :reverse_friendships, :foreign_key => "receiver_id",
                                   :class_name => "Friendship",
                                   :dependent => :destroy
	has_many :invitations, :through => :reverse_friendships, :source => :sender
	
	########################################################################
	
	def messages
		Message.where('receiver_id IN (?) AND i_sup_rec = ? ' , id, false)
	end

	def recipients
		Recipient.where('user_id = ? ' , id)
	end

		
	########################################################################
	
	def proasuivres
     		Proasuivre.where('pro_id = ? AND asuivre = ?', id, true)
	end
	
	def projaimes
     		Projaime.where('pro_id = ? AND projaime = ?', id, 1)
	end


	
	########################################################################
	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :nom, :length   => { :maximum => 50 }
	validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
	validates :password, :presence => true, :confirmation => true , :length => { :within => 6..40 }
	before_save :encrypt_password
	
	def has_password?(password_soumis)
		encrypted_password == encrypt(password_soumis)
	end
	def has_password?(submitted_password)
		encrypted_password == encrypt(submitted_password)
	end
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil  if user.nil?
		return user if user.has_password?(submitted_password)
	end
	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
	end
	def following?(followed)
		relationships.find_by_followed_id(followed)
	end

	def follow!(followed)
		relationships.create!(:followed_id => followed.id)
	end
	def unfollow!(followed)
		relationships.find_by_followed_id(followed).destroy
	end
	########################################################################
	
	def invitation?(receiver)
		friendships.find_by_receiver_id(receiver)
	end
	def friends?(sender)
		reverse_friendships.find_by_sender_id(sender) 
	end

	def status(receiver,sender)
		$broken = 0
		f=friendships.find_by_receiver_id_and_sender_id(receiver,sender)
		if f.nil?
			f=friendships.find_by_receiver_id_and_sender_id(sender,receiver)
		end
		if f.nil?
			f=reverse_friendships.find_by_receiver_id_and_sender_id(receiver,sender)
			$broken = 1
		end
		return f.status
	end

	def friends!(receiver)
		friendships.create!(:receiver_id => receiver.id , :status => 0)
	end

	def accept!(current_user,sender)
		if ($status == 0)
			reverse_friendships.find_by_receiver_id_and_sender_id(current_user,sender).update(:status => 1)
		elsif ($status == 1)
			reverse_friendships.find_by_receiver_id(receiver).update(:status => 2)
		end
	end
	
	def break!(current_user,sender)
	    if ($status == 1) || ($status == 2 && $broken == 1 )
			friendships.find_by_receiver_id(sender).destroy
		elsif (($status == 2) && $broken == 0) || ($status == 0)
			reverse_friendships.find_by_sender_id(sender).destroy
		elsif ($status == 4)
			reverse_friendships.find_by_receiver_id(current_user).destroy
		elsif ($status == 5)
			friendships.find_by_sender_id(current_user).destroy
		end
	end
	########################################################################
	def feed
     # 	Micropost.from_users_followed_by(self)
		Micropost.where("user_id = ?", id)
	end
	
	def self.search_desc(search_desc)
		where("description LIKE ?", "%#{search_desc}%") 
	end
	
	def self.search_theme(search_theme)
		where("theme LIKE ?", "%#{search_theme}%")
	end

	def self.search_motcle(search_motcle)
		where("motcle LIKE ?", "%#{search_motcle}%")
	end

	private

	def encrypt_password
		self.salt = make_salt if new_record?
		self.encrypted_password = encrypt(password)
	end

	def encrypt(string)
		secure_hash("#{salt}--#{string}")
	end

	def make_salt
		secure_hash("#{Time.now.utc}--#{password}")
	end

	def secure_hash(string)
		Digest::SHA2.hexdigest(string)
	end
		
	def self.authenticate(email, submitted_password)
		user = find_by_email(email)
		return nil  if user.nil?
		return user if user.has_password?(submitted_password)
	end
end
