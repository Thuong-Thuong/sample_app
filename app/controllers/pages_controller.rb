class PagesController < ApplicationController
	def home
		titre = "Accueil de Neesyu"
		@titre = "Accueil"
	end

	def show
		@evenement1 = Evenement.search_titre(params[:search_titre]).order("created_at DESC")
		@evenement2 = @evenement1.search_des(params[:search_des]).order("created_at DESC")
		@evenement = @evenement2.paginate(:page => params[:page])
	end
  

	def contact
		@titre = "Contact"
	end

	def about
		@titre = "A Propos"
	end

	def help
		@titre = "Aide en ligne"
	end

	def textperso
		@titre = "Nouveau micropost"
		if signed_in?
			@micropost = Micropost.new
			@feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 3)
		end
	end

	def evenement
		@titre = "Evenements"
		if params[:search]
			@evenements1 = Evenement.search_titre(params[:search]).order("created_at DESC")
			@evenements2 = @evenements1.search_date(params[:search]).order("created_at DESC")
			@evenements = @evenements2.paginate(:page => params[:page])
		else
			@evenements = Evenement.all
			@feed_item_evenmts = Evenement.all.paginate(:page => params[:page])
		end
		if !@feed_item_evenmts.nil?
			@feed_item_evenmts = @feed_item_evenmts.paginate(:page => params[:page])
		end
	end

end