class ConversationsController < ApplicationController
	def new
		@conversation = Conversation.new
		@user =  current_user.friends.where('friendships.status'=> 1) + current_user.invitations.where('friendships.status'=> 1)
		@users = User.all
	end

	def create
		@conversation = current_user.conversations.build(conversation_params)
		@conversation.save
		params[:recipient][:user_tokens].each do |id|
			@recipient = Recipient.new
			@recipient.init(@conversation.id,id)
			@recipient.save
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