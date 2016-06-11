class CommentairesController < ApplicationController
	before_filter :authenticate, :only => [:create, :update, :destroy]
	before_filter :authorized_user, :only => [:destroy]

	def create
		@commentaire = Commentaire.new
		@commentaire = current_user.commentaires.build(params[:commentaire])
		@commentaire.init(current_user.id,$even_id)
		if @commentaire.save
			flash[:success] = "Commentaire created!"
			redirect_to evenements_path
		else
			@feed_item_comments = []            
			render 'new'
		end
	end

	def show
		$temoin = 2
		@commentaire_pro = Commentaire.find_by_pro_id($user)
		@commentaire_aut = Commentaire.find_by_user_id($user)
		if (!@commentaire_pro.nil? && !@commentaire_aut.nil?)
			@feed_item_commentaires = Commentaire.all.where('pro_id IN (?) OR user_id IN (?)', $user , $user)
		elsif (!@commentaire_pro.nil?)
			@feed_item_commentaires = Commentaire.all.where('pro_id IN (?)', $user )
		elsif (!@commentaire_aut.nil?)
			@feed_item_commentaires = Commentaire.all.where('user_id IN (?)',  $user)
		end
		if !@feed_item_commentaires.nil?
			@feed_item_commentaires= @feed_item_commentaires.paginate(:page => params[:page])
		end
	end 

	def new
		@commentaire = current_user.commentaires.build(params[:commentaire])
	end

	def update
		@commentaire = Commentaire.find(params[:id])
		if @commentaire.update_attributes(params[:commentaire])
			flash[:success] = "Commentaire actualise"
			redirect_to commentaires_path
		else
			render 'show'
		end
	end
	
	def destroy
	    @commentaire.destroy
		flash[:success] = "Commentaire supprime!"
		redirect_to commentaires_path
	end

	private

	def authorized_user
		@commentaire = Commentaire.find(params[:id])
		flash[:success] = " #{params[:id]}" 
		# redirect_to root_path unless current_user?(@commentaire.user)
	end
end