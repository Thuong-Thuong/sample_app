class EvenementsController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => :destroy

	def create
		@evenement = current_user.evenements.build(params[:evenement])
		if @evenement.save
			flash[:success] = "Evenement created!"
			redirect_to evenements_path
		else
			flash[:success] = "Evenement KO!"
			@feed_item_evenmts = []            
			#render 'pages/evenement'
			redirect_to evenements_path
		end
	end
	
	def new
		@evenement = current_user.evenements.build(params[:evenement])
		@feed_item_evenmts = Evenement.all.paginate(:page => params[:page])
	end

	def update
		@evenement = Evenement.find_by(params[:id])
		flash[:success] = "Evenement #{@evenement.id}" 
		
	end

	
	
	def destroy
		@evenement.destroy
		flash[:success] = "Evenement supprime!"
		redirect_back_or evenements_path
	end

	private

    def authorized_user
      @evenement = Evenement.find(params[:id])
      redirect_to root_path unless current_user?(@evenement.user)
    end
    
    
end