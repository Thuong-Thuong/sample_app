class InscriptionsController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		@inscription = Inscription.new
		@inscription.init(current_user.id,params[:id])
		if (@inscription.save)
			flash[:success] = "Vous etes inscrit ! " 
		else
			flash[:success] = "Inscription KO !"
		end
		redirect_to evenement_path
	end
		
	def edit
		@feed_item_inscrits = Inscription.all.where('evenement_id = ? ', $even_id)
		if !(@feed_item_inscrits.empty?) 
				@feed_item_inscrits = @feed_item_inscrits.paginate(:page => params[:page]) 
			render 'shared/_feed_inscrit' 
		end

	end
		
	def destroy
		@inscription = Inscription.find(params[:id])
		@inscription.destroy   
		flash[:success] = "Desinscription faite !"
		redirect_to evenement_path($even_id)
	end

	private

    def authorized_user
		@inscription = Inscription.find(params[:id])
		redirect_to root_path unless (current_user.id == @inscription.user_id)
    end
    
    
end