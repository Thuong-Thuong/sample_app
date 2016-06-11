class ApprobationsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		if $approuve == 1
			
	 		@approbation = Approbation.find(params[:id])
			@approbation.destroy
			flash[:success] = "Vous l'avez desapprouve!"
			$approuve = 0
		else
			@approbation = Approbation.new
			@approbation.init(current_user.id,params[:id])
			if (@approbation.save)
				flash[:success] = "Vous l'avez approuve! " 
			else
				flash[:success] = "Approbation KO !"
			end
		end
		redirect_to temoignages_path
	end

	
	def destroy
		@approbation.destroy   
		flash[:success] = "Vous l'avez desapprouve!"

		redirect_to temoignages_path
	end

	private

    def authorized_user
		@approbation = Approbation.find(params[:id])
	      #redirect_to root_path unless current_user?(@approbation.user_id)
    end
    
    
end