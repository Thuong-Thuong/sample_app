class InteressesController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		if $interesse == 1
			@interesse = Interesse.find_by_id(params[:id])
			@interesse.destroy
			flash[:success] = "Vous ne vous y interessez plus!"
			$interesse = 0
		else
			@interesse = Interesse.new
			@interesse.init(current_user.id,params[:id])
			if (@interesse.save)
				flash[:success] = "Vous vous y interessez! " 
			else
				flash[:success] = "Interesse KO !"
			end
		end
		redirect_to evenements_path
	end

	
	def destroy
		@interesse.destroy   
		flash[:success] = "Vous ne vous y interessez plus!"
		redirect_to evenements_path
	end

	private

    def authorized_user
		@interesse = Interesse.find(params[:id])
	      #redirect_to root_path unless current_user?(@interesse.user_id)
    end
    
    
end