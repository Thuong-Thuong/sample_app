class FriendshipsController < ApplicationController
  before_filter :authenticate

  def create
    @user = User.find(params[:friendship][:receiver_id])
    current_user.friends!(@user)
    respond_to do |format|
      format.html { redirect_to users_path}
      format.js
    end
  end

  def destroy
    @user = Friendship.find(params[:id]).receiver
    current_user.break!(@user)
    respond_to do |format|
      format.html { redirect_to users_path}
      format.js
    end
  end
end