class SessionsController < ApplicationController
  
	def new
		@titre = "S'identifier"
	end
	
	def create
		user = User.authenticate(params[:session][:email],
                             params[:session][:password])
			#if user.nil?
				#user = User.from_omniauth(request.env["omniauth.auth"])
				#session[:user_id] = user.id
				#session[:user_name] = user.name
				# sign_in user
				#redirect_back_or user

				if user.nil?
					flash.now[:error] = "Combinaison Email/Mot de passe invalide."
					@titre = "S'identifier"
					render 'new'
				else
     	 		# Authentifie l'utilisateur et redirige vers sa 
				# page d'affichage.
					sign_in user
					redirect_back_or user
				end
			#else
			# Authentifie l'utilisateur et redirige vers sa paged'affichage.
				#sign_in user
				#redirect_back_or user
			#end 
	end  

	def destroy
		sign_out
		redirect_to root_path
	end
end