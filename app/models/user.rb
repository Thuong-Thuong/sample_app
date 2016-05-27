require 'digest'
class User < ActiveRecord::Base
	attr_accessor :password 
	attr_accessible :nom, :email, :password, :password_confirmation
	has_many :microposts, :dependent => :destroy
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

	email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :nom, :length   => { :maximum => 50 }
	validates :email, :presence   => true,
					   :format     => { :with => email_regex },
						:uniqueness => { :case_sensitive => false }
	validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }
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

	def status?(status)
		friendships.find_by_status(status)
	end

	def friends!(receiver)
		friendships.create!(:receiver_id => receiver.id , :status => 0)
	end

	def accept!(receiver)
	    
			#@status = reverse_friendships.find_by_receiver_id(receiver).status

			if ($status == 0)
				reverse_friendships.find_by_receiver_id(receiver).update(:status => 1)
			else
				if ($status == 1)
					reverse_friendships.find_by_receiver_id(receiver).update(:status => 2)
				#else
					#if ($status == 2)
						#friendships.find_by_receiver_id(receiver).update(:status => 0)
					#end
				end
			end
		
	end
	def break!(receiver)
	    if ($status == 0)
			friendships.find_by_receiver_id(receiver).destroy
		else 
			reverse_friendships.find_by_receiver_id(receiver).destroy
		end
	end
	
	########################################################################
	def feed
     # 	Micropost.from_users_followed_by(self)
		Micropost.where("user_id = ?", id)
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
