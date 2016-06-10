class JaimesController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		if $jaime == 1
			@jaime = Jaime.find_by_id(params[:id])
			@jaime.destroy
			flash[:success] = "Vous ne l'aimez plus!"
			$jaime = 0
		else
			@jaime = Jaime.new
			@jaime.init(current_user.id,params[:id])
			if (@jaime.save)
				flash[:success] = "Vous l'aimez! " 
			else
				flash[:success] = "Jaime KO !"
			end
		end
		redirect_to evenements_path
	end

	
	def destroy
		@jaime.destroy   
		flash[:success] = "Vous ne l'aimez plus!"
		redirect_to evenements_path
	end

	private

    def authorized_user
		@jaime = Jaime.find(params[:id])
	      #redirect_to root_path unless current_user?(@jaime.user_id)
    end
    
    
end