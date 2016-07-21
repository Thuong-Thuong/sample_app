class ApprobationsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		@approbation = Approbation.new
		@approbation.init(current_user.id,params[:id])
		if (@approbation.save)
			flash[:success] = "Vous l'avez approuve !"
		else
			flash[:success] = "Approbation KO !"
		end
		redirect_to temoignages_path
	end



	def destroy
		@approbation = Approbation.find_by_id(params[:id])
		@approbation.destroy   
		flash[:success] = "Vous l'avez desapprouve !"
		redirect_to temoignages_path
	end

	private

    def authorized_user
		@approbation = Approbation.find(params[:id])
		#redirect_to root_path unless current_user?(@approbation.user_id)
    end
    
end