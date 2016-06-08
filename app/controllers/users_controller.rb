class UsersController < ApplicationController

	before_filter :authenticate, :except => [:show, :new, :create]
	before_filter :correct_user, :only => [:edit, :update]
	before_filter :admin_user,   :only => :destroy

	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(:page => params[:page])
		#@feed_item_evenmts = Evenement.all.paginate(:page => params[:page])
		@titre = @user.nom
	end
	
	def index
		@titre = "Tous les utilisateurs"
		@users = User.paginate(:page => params[:page])
	end
 
	def new
		@user = User.new
		@titre = "Inscription"
	end

	def create
	    @user = User.new(params[:user])
		if @user.save 
			sign_in @user
			redirect_to @user
			flash[:success] = "Bienvenue dans l'Application Exemple !"
		else
			@titre = "Inscription"
			render 'new'
		end
	end

	def edit
     # 	@user = User.find(params[:id])
		@titre = "Edition profil"
	end
	
	def update
    	 #	@user = User.find(params[:id])
		if @user.update_attributes(params[:user])
			flash[:success] = "Profil actualise"
			redirect_to @user
		else
			@titre = "Edition profil"
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy   
		flash[:success] = "Utilisateur supprime."
		redirect_to users_path
	end

#################################################################

	def following
		@titre = "Following"
		@user = User.find(params[:id])
		@users = @user.following.paginate(:page => params[:page])
		render 'show_follow'
	end

	def followers
		@titre = "Followers"
		@user = User.find(params[:id])
		@users = @user.followers.paginate(:page => params[:page])
		render 'show_follow'
	end

#################################################################
	
     def friends
		@titre = "Friends"
		@user = User.find(params[:id])
		@users = @user.friends.where('friendships.status'=> 1) + @user.invitations.where('friendships.status'=> 1)
		@users = @users.paginate(:page => params[:page])
		render 'show_friends'
	end

	def invitations
		@titre = "Invitations"
		@user = User.find(params[:id])
		@users = @user.invitations.where('friendships.status'=> 0).paginate(:page => params[:page])
		render 'show_friends'
	end

#################################################################
	def temoignages
		@titre = "Temoignages"
	end

#################################################################

	private

 # 	def authenticate
 #    	deny_access unless signed_in?
 # 	end
 
	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
    end
	
	def admin_user
		redirect_to(root_path) unless current_user.admin?
    end
end