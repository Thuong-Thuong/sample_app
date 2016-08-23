class MessagesController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => [:update, :destroy]

	def create
		@message = Message.new
		@message = current_user.messages.build(params[:message])
		if !($irep == 1) && !$user.nil? 
			@message.init(current_user.id,$user)
		elsif !$receiver_id.nil?
			@message.init(current_user.id,$receiver_id)
		else 
			@message.init(current_user.id,$user)
		end
		if @message.save
			flash[:success] = "Message envoye !" 
			redirect_to(:back)
		else
			$i_vide = 1
			render 'show'
		end
	end

	def new
		@message = current_user.messages.build(params[:message])
	end
	
	def show
		@message = current_user.messages.build(params[:message])
		if (current_user.id == $user) 
			Message.all.where('receiver_id = ? AND i_sup_rec = ? AND i_lu = ?', current_user.id, 0 , 1).update_all(:i_lu => 2 )
			Message.all.where('receiver_id = ? AND i_sup_rec = ? AND i_lu = ?', current_user.id, 0 , 0).update_all(:i_lu => 1 )
		end	
		@feed_item_messages = Message.all.where('receiver_id = ? AND i_sup_rec = ?', current_user.id, 0)
		if !@feed_item_messages.nil?
			@feed_item_messages = @feed_item_messages.paginate(:page => params[:page])
		end
		$irep = 0
	end
	
	def edit
		@message = current_user.messages.build(params[:message])
		$message = Message.find_by_id(params[:id])
		if $message.nil?
			$message = @message
		end
		if $irep == 1
			$receiver_id = $message.sender_id
		else
			$receiver_id = $message.receiver_id
		end
		@feed_item_messages = Message.all.where('sender_id = ? AND (receiver_id = ?  ) AND i_sup = ? ', current_user.id, $receiver_id ,  0)
		if @feed_item_message.nil? && $irep == 0
			@feed_item_messages = Message.all.where('sender_id = ? AND receiver_id = ? AND i_sup = ?', current_user.id, $user, 0 )
		end
		if !@feed_item_messages.nil?
			@feed_item_messages= @feed_item_messages.paginate(:page => params[:page])
		end
	end

	def update
		if $i_sup_rec == 0
			@message = Message.find(params[:id]).update(:i_sup => 1)
			flash[:success] = "Message supprime !"
		else
			@message = Message.find(params[:id]).update(:i_sup_rec => 1)
			flash[:success] = "Message efface !"
		end
		redirect_to(:back)
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