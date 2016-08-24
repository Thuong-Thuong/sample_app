class ApprobationsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		@approbation = Approbation.new
		if $i_approuve == 1
			@approbation.approuve = 1
		else
			@approbation.approuve = 0
		end
		@approbation.init(current_user.id,params[:id])
		if (@approbation.save) && $i_approuve == 1
			flash[:success] = "Temoignage approuvé !"
		elsif (@approbation.save) && $i_approuve == 0
			flash[:success] = "Temoignage desapprouvé !"
		else
			flash[:success] = "Approbation KO !"
		end
		redirect_to temoignages_path
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
			redirect_to temoignages_path
		else
			render 'show'
		end
	end

	def destroy
		@approbation = Approbation.find_by_id(params[:id])
		@approbation.destroy   
		flash[:success] = "Approbation supprimee !"
		redirect_to temoignages_path
	end

	private

    def authorized_user
		@approbation = Approbation.find(params[:id])
		#redirect_to root_path unless current_user?(@approbation.user_id)
    end
    
end