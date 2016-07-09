class MessagesController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => [:update, :destroy]

	def create
		@message = Message.new
		@message = current_user.messages.build(params[:message])
		if !($irep == 1 ) 
			@message.init(current_user.id,$user)
		else
			@message.init(current_user.id,$receiver_id)
		end
		if @message.save
			flash[:success] = "Message created!" 
			if !($irep == 1 )
			redirect_to messages_path
			else
			redirect_to messages_path
			end
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
			if !($irep == 1)
				@feed_item_messages = Message.all.where('receiver_id = ?', current_user.id)
			else 
				@feed_item_messages = Message.all.where('sender_id = ? AND receiver_id = ?', current_user.id,$receiver_id)
			end
		else
			if !$irep == 1
				@feed_item_messages = Message.all.where('sender_id = ?', current_user.id)
			else 
				@feed_item_messages = Message.all.where('sender_id = ? AND receiver_id = ?', current_user.id, $receiver_id )
				if @feed_item_message.nil?
					@feed_item_messages = Message.all.where('sender_id = ? AND receiver_id = ?', current_user.id, $user )
				end
			end
		end
		if !@feed_item_messages.nil?
			@feed_item_messages= @feed_item_messages.paginate(:page => params[:page])
		end
	end
	
	def edit
		@message = current_user.messages.build(params[:message])
		if $irep == 1
			$message = Message.find(params[:id])
			if $message.nil?
				$message = @message
			end
			$receiver_id = $message.sender_id
		else
			$receiver_id = $message.receiver_id
		end
		if current_user.id == $user
			@feed_item_messages = Message.all.where('receiver_id = ?', current_user.id)
		else
			@feed_item_messages = Message.all.where('sender_id = ? AND receiver_id = ?', current_user.id,$user)
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
		flash[:success] = "Message supprime !"
		redirect_to(:back)
	end

	private

	def authorized_user
		@message = Message.find(params[:id])
		redirect_to root_path unless (current_user.id == @message.sender_id) || (current_user.id == @message.receiver_id)
	end
end