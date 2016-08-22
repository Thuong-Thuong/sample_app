class EvenementsController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => [:destroy]

	def create
		@evenement = current_user.evenements.build(params[:evenement])
		if @evenement.save
			flash[:success] = "Evenement created !"
			redirect_to evenements_path
		else
			@feed_item_evenmts = []            
			render 'new'
		end
	end

	def show
		@evenement = Evenement.find(params[:id])
	end
	def edit
		@evenement = Evenement.find(params[:id])
	end
	
	def new
		if !signed_in?
			flash[:success] = "Veuillez vous identifier avant svp !"
			redirect_to signin_path
		else
			@evenement = current_user.evenements.build(params[:evenement])
			@feed_item_evenmts = Evenement.all.paginate(:page => params[:page])
		end
	end

	def update
		@evenement = Evenement.find(params[:id])
		if @evenement.update_attributes(params[:evenement])
			flash[:success] = "Evenement actualise !"
			redirect_to evenement_path
		else
			render 'edit'
		end
	end

	def index
		@titre = "Tous les evenements"
		if !(params[:search_date] == "")
			@evenements0 = Evenement.search_date(params[:search_date]).order("created_at DESC")
		else 
			@evenements0 = Evenement.all
		end
		@evenements1 = @evenements0.search_titre(params[:search_titre]).order("created_at DESC")
		@evenements2 = @evenements1.search_des(params[:search_des]).order("created_at DESC")
		@evenements = @evenements2.paginate(:page => params[:page], :per_page => 4 )
	end

	def destroy
		@evenement.destroy
		flash[:success] = "Evenement supprime !"
		redirect_to evenements_path
	end

	def commentaires
		@titre = "Commentaires"
	end

	def signaleven
		@titre = "Signalevens"
		if signed_in?
			@signaleven = Signaleven.new
			if !current_user.admin? 
				@feed_item_signalevens = Signaleven.all.where('even_id = ? && id_signaleur  = ?', $even_id,current_user.id)
			elsif current_user.admin? && $index_even == 0
				@feed_item_signalevens = Signaleven.all.where('even_id = ? ', $even_id)
			elsif current_user.admin? && $index_even == 1
				@feed_item_signalevens = Signaleven.all
			end
			if !@feed_item_signalevens.nil?
				@feed_item_signalevens = @feed_item_signalevens.paginate(:page => params[:page])
			end
		end
  	end
     
#################################################################

	private

	def authorized_user
		@evenement = Evenement.find(params[:id])
		# redirect_to root_path unless current_user?(@evenement.user)
	end
end