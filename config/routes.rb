Rails.application.routes.draw do
	
	
	resources :relationships, :only => [:create, :destroy]
	resources :friendships, :only => [:create, :update, :destroy]
	resources :sessions, :only => [:new, :create, :destroy]
	
	resources :users do
		member do
			get :following, :followers
			get :friends, :invitations, :invites
		end
	end
	
	resources :commentaires do
		resources :reponses
	end
	
	resources :signalements, :only => [:create, :update, :destroy]
	resources :signalevens, :only => [:create, :update, :destroy]
	resources :microposts, :only => [:create, :destroy]
	resources :evenements, :only => [:create, :update, :destroy]
	resources :inscriptions, :only => [:create, :update, :destroy]
	resources :temoignages, :only => [:create, :destroy]
	resources :messages, :only => [:create, :destroy, :update]
	resources :conversations, :only => [:create, :destroy, :update]
	resources :recipients, :only => [:create, :destroy, :update]

	resources :commentaires, :only => [:create, :destroy]

	#get 'auth/:provider/callback', :to => 'sessions#create'
	#get 'auth/failure', :to => redirect('/')
	#get 'auth/facebook', :to => 'users#new'

	get '/signup',  :to => 'users#new'
	get '/signin',  :to => 'sessions#new'
	get '/signout', :to => 'sessions#destroy'

	get '/contact', :to => 'pages#contact'
	get '/news', :to => 'pages#news'

    get '/about',    :to => 'pages#about'
    get '/help',     :to => 'pages#help'
    get '/micropost_page', :to => 'pages#micropost'

    get '/signalements', :to => 'users#signalement'
	get '/signalindex', :to => 'signalements#index'
	get '/signalements/:id/edit', :to => 'signalements#edit', as: 'signalement_edit'
	
    get '/signalevens', :to => 'evenements#signaleven'
	get '/signalevenindex', :to => 'signalevens#index'
	get '/signalevens/:id/edit', :to => 'signalevens#edit', as: 'signaleven_edit'
    get '/signalevens/:id(.:format)', :to => 'signalevens#show', as: 'signalevenshow'

    get '/evenements', :to => 'pages#evenement'
	get '/newevenement', :to => 'evenements#new'
	get '/evenements/:id', :to => 'evenements#show', as: 'feed_item_evenmt'
	get '/evenementindex', :to => 'evenements#index'
	get '/evenementedit/:id', :to => 'evenements#edit', as: 'evenementedit'

	get '/commentaires/:id', :to => 'commentaires#new'
	get '/commentaires', :to => 'commentaires#index', as: 'feed_item_comment'
	get '/commentaires/:id', :to => 'commentaires#update'

	get '/inscriptions/:id', :to => 'inscriptions#create',  as: 'ins_even'
	get '/inscriptions/:id/destroy', :to => 'inscriptions#destroy',  as: 'desins_even'
	get '/inscritedit', :to => 'inscriptions#edit'

	get '/jaimes/:id', :to => 'jaimes#create',  as: 'aime_even'
	get '/jaimes/:id/destroy', :to => 'jaimes#destroy',  as: 'desaime_even'

	get '/interesses/:id', :to => 'interesses#create',  as: 'interesse_even'
	get '/interesses/:id/destroy', :to => 'interesses#destroy',  as: 'desinteresse_even'
	
	get '/temoignages/:id', :to => 'temoignages#new'
	get '/temoignages', :to => 'temoignages#show', as: 'feed_item_temoignage'
	get '/temoignages/:id/edit', :to => 'temoignages#edit', as: 'temoignages_edit'

	get '/messages/:id', :to => 'messages#new'
	get '/messages', :to => 'messages#show', as: 'feed_item_message'
	get '/messages/:id/edit', :to => 'messages#edit', as: 'messages_edit'
	
	get '/conversations', :to => 'conversations#new'
	get '/conversations/:id/edit', :to => 'conversations#edit', as: 'conversations_edit'

	get '/approbations/:id', :to => 'approbations#create', as: 'approuver'
	get '/approbations/:id/destroy', :to => 'approbations#destroy', as: 'desapprouver'

	get '/projaimes/:id', :to => 'projaimes#create',  as: 'projaime'
	get '/projaimes/:id/destroy', :to => 'projaimes#destroy',  as: 'prodesjaime'

	get '/proasuivres/:id', :to => 'proasuivres#create',  as: 'proasuivre'
	get '/proasuivres/:id/destroy', :to => 'proasuivres#destroy',  as: 'prodessuivre'
	

	root :to => 'pages#home'

	
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
