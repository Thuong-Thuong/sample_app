class ProasuivresController < ApplicationController
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :authorized_user, :only => [:destroy]
	
	def create
		@proasuivre = Proasuivre.new
		@proasuivre.init(current_user.id,$user,1)
		if (@proasuivre.save)
			flash[:success] = "Vous le suivez! " 
		else
			flash[:success] = "Proasuivre KO !"
		end		
		redirect_to user_path
	end

	def destroy
		@proasuivre.destroy   
		flash[:success] = "Vous ne le suivez plus!"
		redirect_to user_path($user)
	end

	private

     def authorized_user
		@proasuivre = Proasuivre.find(params[:id])
		redirect_to root_path unless (current_user.id == @proasuivre.user_id)
     end
  end