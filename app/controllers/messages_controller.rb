class MessagesController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => [:update, :destroy]

	def create
		@message = Message.new
		@message = current_user.messages.build(params[:message])
		@message.init(current_user.id,$user)
		if @message.save
			flash[:success] = "Message created!" 
			redirect_to messages_path
		else
			render 'show'
		end
	end

	def new
		@message = current_user.messages.build(params[:message])
	end
	
	def show
		@message = current_user.messages.build(params[:message])
		if current_user.id == $user
			@feed_item_messages = Message.all.where('receiver_id = ?', current_user.id)
		else
			@feed_item_messages = Message.all.where('sender_id = ?', current_user.id)
		end
		if !@feed_item_messages.nil?
			@feed_item_messages= @feed_item_messages.paginate(:page => params[:page])
		end
	end
	
	def edit
		@message = current_user.messages.build(params[:message])
		if current_user.id == $user
			@feed_item_messages = Message.all.where('receiver_id = ?', current_user.id)
		else
			@feed_item_messages = Message.all.where('sender_id = ?', current_user.id)
		end
		if !@feed_item_messages.nil?
			@feed_item_messages= @feed_item_messages.paginate(:page => params[:page])
		end
	end

	def update
		@message = Message.find(params[:id])
		if @message.update_attributes(params[:message])
			flash[:success] = "Message actualise"
			redirect_to messages_path
		else
			render 'show'
		end
	end
	
	def destroy
	    @message.destroy
		flash[:success] = "Message supprime!"
		redirect_to messages_path
	end

	private

	def authorized_user
		@message = Message.find(params[:id])
		redirect_to root_path unless (current_user.id == @message.sender_id) || (current_user.id == @message.receiver_id)
	end
end