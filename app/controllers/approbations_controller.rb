class ApprobationsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]

	def create1
		@approbation = Approbation.new
		@approbation.init(current_user.id,params[:id])
		@approbation.approuve = 1
		if (@approbation.save) 
			flash[:success] = "Témoignage approuvé"
		else
			flash[:success] = "Approbation KO "
		end
		redirect_to (:back)
	end
	def create
		@approbation = Approbation.new
		@approbation.init(current_user.id,params[:id])
		@approbation.approuve = 0
		if (@approbation.save) 
			flash[:success] = "Témoignage desapprouvé"
		else
			flash[:success] = "Desapprobation KO "
		end
		redirect_to (:back)
	end
	
	def update
		@approbation = Approbation.find_by_id(params[:id])
		if @approbation.approuve == 1
			@approbation.approuve = 0
		else
			@approbation.approuve = 1
		end
		if @approbation.update_attributes(params[:temoignage])
			flash[:success] = "Approbation actualisee !"
			redirect_to (:back)
		else
			render 'show'
		end
	end

	def destroy
		@approbation = Approbation.find_by_id(params[:id])
		@approbation.destroy   
		flash[:success] = "Approbation supprimee !"
		redirect_to (:back)
	end

	private

    def authorized_user
		@approbation = Approbation.find(params[:id])
		#redirect_to root_path unless current_user?(@approbation.user_id)
    end
    
end