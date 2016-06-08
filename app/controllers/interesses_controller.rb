class InteressesController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => [:destroy, :update]
	
	def create
		if $interesse == 1
			@interesse = Interesse.find_by_id(params[:id])
			@interesse.destroy
			flash[:success] = "Vous n'etes plus interesse!"
			$interesse = 0
		else
			@interesse = Interesse.new
			@interesse.init(current_user.id,params[:id])
			if (@interesse.save)
				flash[:success] = "Vous vous y interessez! " 
			else
				flash[:success] = "Interesse KO !"
				# @feed_item_ins = []            
				#render  'create'	
			end
		end
		redirect_to evenements_path
	end

	def show
		
	end

	def new
		@user = User.new
		@titre = "Interesse"
	end

	def update
	end
		
	def destroy
		@interesse.destroy   
		flash[:success] = "Vous n'etes plus interesse!"
		#redirect_to evenements_path
	end

	private

    def authorized_user
		@interesse = Interesse.find(params[:id])
		flash[:success] = " #{params[:id]}" 
		#redirect_to root_path unless current_user?(@interesse.user_id)
    end
    
    
end