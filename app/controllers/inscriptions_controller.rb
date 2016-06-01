class InscriptionsController < ApplicationController
	# before_filter :authenticate, :only => [:create, :update, :destroy]
	# before_filter :authorized_user, :only => [:destroy, :update]

	
	
	def create
		@inscription = Inscription.new
		@inscription.init(current_user.id,params[:id])
		if (@inscription.save)
			flash[:success] = "Inscription created! " 
			redirect_to evenements_path
		else
			flash[:success] = "Inscription KO!"
			# @feed_item_ins = []            
			#render  'create'
			redirect_to evenements_path
		end
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
		
	end

	private

    def authorized_user
		@inscription = Inscription.find(params[:id])
		redirect_to root_path unless current_user?(@inscription.user)
    end
    
    
end