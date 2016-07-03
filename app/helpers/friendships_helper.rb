module FriendshipsHelper
	def friendship_broken
		@user.friendships.find_by_sender_id(@user)
		if @friendship_broken.nil?
			$status=5
			current_user.friendships.find_by_receiver_id(@user)
		end
	end
end