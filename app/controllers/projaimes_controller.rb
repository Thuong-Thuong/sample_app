class ProjaimesController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		@projaime = Projaime.new
		@projaime.init(current_user.id,$user,1)
		if (@projaime.save)
			flash[:success] = "Vous l'aimez ! " 
		else
			flash[:success] = "Projaime KO !"
		end	
		redirect_to user_path
	end

	def destroy
		@projaime = Projaime.find(params[:id])
		@projaime.destroy 
		flash[:success] = "Vous ne l'aimez plus !"
		redirect_to user_path($user)
	end

	private

     def authorized_user
		@projaime = Projaime.find(params[:id])
		redirect_to root_path unless (current_user.id == @projaime.user_id)
     end
  end