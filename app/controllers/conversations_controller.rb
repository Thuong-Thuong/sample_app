class ConversationsController < ApplicationController
	def new
		@conversation = Conversation.new
		@user =  current_user.friends.where('friendships.status'=> 1) + current_user.invitations.where('friendships.status'=> 1)
		@users = User.all
		# @friends = User.pluck(:name, :id).sort
	end

	def create
		params[:conversation][:user_tokens].each do |id|
			@conversation = current_user.conversations.build(conversation_params)
			@conversation.init(current_user.id, id)
			@conversation.save
		end

		if @conversation.save
			flash[:success] = "Conversation Sent!"
			redirect_to conversations_path
		else
			flash[:notice] = "Oops!"
			render 'new'
		end	
		
	end

	def index
		@user = User.find(current_user)
		@conversations = Recipient.where(:user_id => @user).order("created_at DESC")

	end

	private

    def conversation_params
        params.require(:conversation).permit(:body, :sender_id)
    end
end