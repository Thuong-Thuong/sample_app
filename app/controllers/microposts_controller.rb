class MicropostsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => :destroy

	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Micropost created!"
			redirect_to textperso_path
		else
			#@feed_items = []
			render 'pages/micropost'
		end
	end
  
	def destroy
		@micropost.destroy
		flash[:success] = "Micropost supprime!"
		redirect_back_or textperso_path
	end

	private

	def authorized_user
		@micropost = Micropost.find(params[:id])
		redirect_to root_path unless current_user?(@micropost.user)
    end
      
end