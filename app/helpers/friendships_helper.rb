module FriendshipsHelper
	def friendship_broken
		@user.friendships.find_by_sender_id(@user)
		if @friendship_broken.nil?
			$status=5
			current_user.friendships.find_by_receiver_id(@user)
		end
	end
	def friendship_break
		current_user.friendships.find_by_receiver_id_and_sender_id(@user,current_user.id)
	end
end