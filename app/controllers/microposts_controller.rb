class MicropostsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => :destroy

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost cree !"
			redirect_to micropost_page_path
		else
			#@feed_items = []
			render 'pages/micropost'
		end
	end
  
	def destroy
		@micropost.destroy
		flash[:success] = "Micropost supprime !"
		redirect_to (:back)
	end

	private

	def authorized_user
		@micropost = Micropost.find(params[:id])
		redirect_to root_path unless current_user?(@micropost.user)
    end
      
end