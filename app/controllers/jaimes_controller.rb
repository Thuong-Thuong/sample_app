class JaimesController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create	
		@jaime = Jaime.new
		@jaime.init(current_user.id,params[:id])
		if (@jaime.save)
			flash[:success] = "Vous l'aimez! " 
		else
			flash[:success] = "Jaime KO !"
		end	
		redirect_to evenement_path
	end
	
	def destroy
		@jaime = Jaime.find_by_id(params[:id])
		@jaime.destroy   
		flash[:success] = "Vous ne l'aimez plus!"
		redirect_to evenement_path($even_id)
	end

	private

    def authorized_user
		@jaime = Jaime.find(params[:id])
	    redirect_to root_path unless (current_user.id == @jaime.user_id)
    end       
end