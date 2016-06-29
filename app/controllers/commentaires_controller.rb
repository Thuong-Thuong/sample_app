class CommentairesController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => [:destroy]

	def create
		@commentaire = Commentaire.new
		@commentaire = $evenement.commentaires.build(params[:commentaire])
		@commentaire.init(current_user.id ,$even_id)
		if @commentaire.save
			flash[:success] = "Commentaire created!"
			redirect_to commentaire_path(@commentaire.id)
		else
			render 'new'
		end
	end

	def show
		@commentaire = Commentaire.new
		if @commentaire.nil?
			@commentaire = Commentaire.find_by_evenement_id($even_id)
		end
		@feed_item_commentaires = Commentaire.all.where('evenement_id IN (?)', $even_id)
		if !@feed_item_commentaires.nil?
			@feed_item_commentaires = @feed_item_commentaires.paginate(:page => params[:page])
		end

	end 

	def new
		@commentaire = Commentaire.new
		@feed_item_commentaires = Commentaire.all.where('evenement_id IN (?)', $even_id)
		if !@feed_item_commentaires.nil?
			@feed_item_commentaires = @feed_item_commentaires.paginate(:page => params[:page])
		end
	end

	def update
	end
	
	def destroy
	    @commentaire.destroy
		flash[:success] = "Commentaire supprime!"
		redirect_to commentaire_path
	end

	private

	def authorized_user
		@commentaire = Commentaire.find(params[:id])
		redirect_to root_path unless (current_user.id == @commentaire.commentateur_id)
	end
end