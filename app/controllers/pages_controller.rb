class PagesController < ApplicationController
	def home
		titre = "Accueil de Neesyu"
		@titre = "Accueil"
	end

	def show
		@evenement = Evenement.search(params[:search]).order("created_at DESC")
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
			@evenements = Evenement.search(params[:search]).order("created_at DESC")
		else
			@evenements = Evenement.all
			@feed_item_evenmts = Evenement.all.paginate(:page => params[:page])
		end
		if !@feed_item_evenmts.nil?
			@feed_item_evenmts = @feed_item_evenmts.paginate(:page => params[:page])
		end
	end

end