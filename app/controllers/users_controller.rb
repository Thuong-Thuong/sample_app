class UsersController < ApplicationController
 def show
    @user = User.find(params[:id])
     @titre = @user.nom
  end 
def index
  @users = User.all
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
end