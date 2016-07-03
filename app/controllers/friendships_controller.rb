class FriendshipsController < ApplicationController
	before_filter :authenticate
	def create
		@user = User.find(params[:friendship][:receiver_id])
		current_user.friends!(@user)
		respond_to do |format|
			format.html { redirect_to users_path,:notice => "Invitation envoyée à #{@user.nom}!"}
			format.js
		end
	end

	def update
		@user = Friendship.find(params[:id]).sender
        current_user.accept!(current_user,@user)
        respond_to do |format|
			format.html { redirect_to users_path} 
			format.js
		end
	end

	def destroy
		if $status == 1
			@user = Friendship.find(params[:id]).receiver
		else
			@user = Friendship.find(params[:id]).sender
		end
		current_user.break!(current_user,@user)
		respond_to do |format|
			format.html { redirect_to users_path}
			format.js
		end
	end

end