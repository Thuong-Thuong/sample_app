class PagesController < ApplicationController
	def home
		@titre = "Accueil"
		# if signed_in?
			# @micropost = Micropost.new
			# @feed_items = current_user.feed.paginate(:page => 
			# params[:page])
		# end
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

	def message
		@titre = "Nouveau message"
		if signed_in?
			@micropost = Micropost.new
			@feed_items = current_user.feed.paginate(:page => params[:page])
		end
	end

	def evenement
		@titre = "Evenements"
		if signed_in?
			#@evenement = Evenement.new
			@feed_item_evenmts = Evenement.all.paginate(:page => params[:page])
		end
	end
	
	


end