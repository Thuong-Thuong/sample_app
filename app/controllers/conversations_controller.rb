class ConversationsController < ApplicationController
	def new
		@conversation = Conversation.new
		@user =  current_user.friends.where('friendships.status'=> 1) + current_user.invitations.where('friendships.status'=> 1)
		@users = User.all
	end

	def create
		@user =  current_user.friends.where('friendships.status'=> 1) + current_user.invitations.where('friendships.status'=> 1)
		@users = User.all
		@conversation = current_user.conversations.build(conversation_params)
		if params[:recipient].nil?
			flash[:notice] = "Veuillez saisir un destinataire !"
			render 'new'
		else
			if !@conversation.body.present?
				flash[:notice] = "Le message est vide!"
				render 'new'
			else
				@conversation.save
				$iconv = 1
				params[:recipient][:user_tokens].each do |id|
					@recipient = Recipient.new
					@recipient.init(@conversation.id,id)
					@recipient.save
				end
				if @conversation.save
					flash[:success] = "Message envoye!"
					redirect_to conversations_path
				else
					flash[:notice] = "Oops!"
					render 'new'
				end
			end
		end	
	end
	
	def edit
		@conversation = current_user.conversations.build(params[:message])
	end
	
	def index
		@user = User.find(current_user)
	end

	def destroy
		@conversation = Conversation.find(params[:id])
		@conversation.destroy
		flash[:success] = "Conversation supprime !"
		redirect_to(:back)
	end
	private

    def conversation_params
        params.require(:conversation).permit(:body, :sender_id, :user_tokens)
    end
end