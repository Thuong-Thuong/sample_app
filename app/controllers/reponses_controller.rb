class ReponsesController < ApplicationController
	def create
		@commentaire = Commentaire.find_by_id(params[:commentaire_id])
		@reponse = @commentaire.reponses.create(params[:reponse])
		@reponse.init(current_user.id, $comment_id)
		@reponse.save
		if @reponse.save
			$reponse_id = @reponse.id
			flash[:success] = "Reponse created!" 
			redirect_to new_commentaire_reponse_path($comment)
		else
			render 'edit'
		end
	end
  
	def new
		@commentaire = Commentaire.find_by_id(params[:commentaire_id])
		@reponse = @commentaire.reponses.new
		$comment_id = @commentaire.id
		$comment = @commentaire
		$comment_user = User.find_by_id(@commentaire.commentateur_id)
		$reponse_id = @reponse.id
		@feed_item_reponses = Reponse.all.where('commentaire_id = ?', $comment_id)
		if !@feed_item_reponses.nil?
			@feed_item_reponses = @feed_item_reponses.paginate(:page => params[:page])
		end


	end
	
	def show
		@commentaire = Commentaire.find_by_id($comment_id)
		@reponse = @commentaire.reponses.find(params[:id])
		$comment_user = User.find_by_id(@commentaire.commentateur_id)
		@feed_item_reponses = Reponse.all.where('commentaire_id = ?', $comment_id)
		if !@feed_item_reponses.nil?
			@feed_item_reponses = @feed_item_reponses.paginate(:page => params[:page])
		end
	end
	
	def edit
		@commentaire = Commentaire.find_by_id(params[:commentaire_id])
		@reponse = @commentaire.reponses.find(params[:id])
		$reponse_id = @reponse.id
		$comment_user = User.find_by_id(@commentaire.commentateur_id)
		@feed_item_reponses = Reponse.all.where('commentaire_id = ?', $comment_id)
		if !@feed_item_reponses.nil?
			@feed_item_reponses = @feed_item_reponses.paginate(:page => params[:page])
		end
		
	end
	
	def update
		#@commentaire = $comment
		@reponse = $comment.reponses.find(params[:id])
		if @reponse.update(params[:reponse])
			flash[:success] = "Reponse modifiee!"
			redirect_to new_commentaire_reponse_path($comment)
		else
			render 'edit'
		end
	end
	
	def destroy
		#@commentaire = $comment
		@reponse = $comment.reponses.find(params[:id])
		@reponse.destroy
		@feed_item_reponses = Reponse.all.where('commentaire_id = ?', $comment_id)
		if !@feed_item_reponses.nil?
			@feed_item_reponses = @feed_item_reponses.paginate(:page => params[:page])
		end
		flash[:success] = "Reponse supprime!"
		render 'new'
	end
	

end