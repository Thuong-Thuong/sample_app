class ProjaimesController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		if $projaime == 1
			@projaime = Projaime.find_by_id(params[:id])
			@projaime.destroy
			flash[:success] = "Vous ne l'aimez plus!"
			$projaime = 0
		else
			@projaime = Projaime.new
			@projaime.init(current_user.id,$user,1)
			if (@projaime.save)
				flash[:success] = "Vous l'aimez! " 
			else
				flash[:success] = "Projaime KO !"
			end
		end
		redirect_to temoignages_path
	end

	def destroy
		@projaime.destroy   
		flash[:success] = "Vous ne l'aimez plus!"
		#redirect_to temoignages_path
	end

	private

     def authorized_user
		@projaime = Projaime.find(params[:id])
		redirect_to root_path unless current_user?(@projaime.user_id)
     end
  end