class PagesController < ApplicationController
	def home
		titre = "Accueil de Neesyu"
		@titre = "Accueil"
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
		@evenements = Evenement.all
		@feed_item_evenmts = Evenement.all.paginate(:page => params[:page])
		if !@feed_item_evenmts.nil?
			@feed_item_evenmts = @feed_item_evenmts.paginate(:page => params[:page] , :per_page => 4 )
		end
	end
	
	

end