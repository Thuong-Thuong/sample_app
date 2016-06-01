class InscriptionsController < ApplicationController
	# before_filter :authenticate, :only => [:create, :update, :destroy]
	# before_filter :authorized_user, :only => [:destroy, :update]

	
	
	def create
		if $exist == 1
			@inscription = Inscription.find_by_id(params[:id])
			@inscription.destroy
			flash[:success] = "Desinscription faite !"
			$exist = 0
		else
			@inscription = Inscription.new
			@inscription.init(current_user.id,params[:id])
			if (@inscription.save)
				flash[:success] = "Inscription created ! " 
			else
				flash[:success] = "Inscription KO !"
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
		@titre = "Inscription"
	end

	def update
	end
		
	def destroy
		@inscription.destroy   
		flash[:success] = "Desinscription faite !"
		#redirect_to evenements_path
	end

	private

    def authorized_user
		@inscription = Inscription.find(params[:id])
		flash[:success] = " #{params[:id]}" 
		#redirect_to root_path unless current_user?(@inscription.user_id)
    end
    
    
end