class ConversationsController < ApplicationController
	def new
		@conversation = Conversation.new
		@user = current_user.friends
		@users = User.all
		# @friends = User.pluck(:name, :id).sort
	end

	def create
		@user = current_user.friends
		@users = User.all
		@conversation = current_user.conversations.build(conversation_params)
		@conversation.save
		params[:conversation][:user_tokens].each do |id|
			@recipient.conversation_id = @conversation.id 
			@recipient.user_id = id
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