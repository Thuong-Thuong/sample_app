class ReponsesController < ApplicationController
	def create
		#@commentaire = Commentaire.find_by_id(params[:commentaire_id])
		@reponse = $comment.reponses.create(params[:reponse])
		@reponse.init(current_user.id, $comment_id)
		if @reponse.save
			$reponse= @reponse
			flash[:success] = "Reponse created!"
			redirect_to new_commentaire_reponse_path($comment)
		else
			render 'new'
		end
	end
  
	def new
		@commentaire = Commentaire.find_by_id(params[:commentaire_id])
		@reponse = @commentaire.reponses.new
		$comment_id = @commentaire.id
		$comment = @commentaire
		$reponse_id = @reponse.id
	end
	
	def show
		@commentaire = Commentaire.find_by_id(params[:commentaire_id])
		@reponse = $comment.reponses.find(params[:id])
	end
	
	def edit
		#@commentaire = $comment
		@reponse = $comment.reponses.find(params[:id])
		$reponse_id = @reponse.id
		
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
		flash[:success] = "Reponse supprime!"
		render 'new'
	end
	

end