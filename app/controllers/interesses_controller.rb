class InteressesController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		@interesse = Interesse.new
		@interesse.init(current_user.id,params[:id])
		if (@interesse.save)
			flash[:success] = "Vous vous y interessez ! " 
		else
			flash[:success] = "Interesse KO !"
		end
		redirect_to evenement_path
	end
	
	def destroy
		@interesse = Interesse.find(params[:id])
		@interesse.destroy   
		flash[:success] = "Vous ne vous y interessez plus !"
		redirect_to evenement_path($even_id)
	end

	private

    def authorized_user
		@interesse = Interesse.find(params[:id])
	    redirect_to root_path unless (current_user.id == @interesse.user_id)
    end
end