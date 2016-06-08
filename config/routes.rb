Rails.application.routes.draw do
	
	resources :relationships, :only => [:create, :destroy]
	resources :friendships, :only => [:create, :update, :destroy]

	
	resources :sessions, :only => [:new, :create, :destroy]
	
	resources :users do
		member do
			get :following, :followers
			get :friends, :invitations
            get :temoignages
		end
	end
	
	resources :microposts, :only => [:create, :destroy]
	resources :evenements, :only => [:create, :update, :destroy]
	resources :inscriptions, :only => [:create, :update, :destroy]
	resources :temoignages, :only => [:create, :destroy]

		  
	#get 'auth/:provider/callback', :to => 'sessions#create'
	#get 'auth/failure', :to => redirect('/')
	#get 'auth/facebook', :to => 'users#new'


	get '/signup',  :to => 'users#new'
	get '/signin',  :to => 'sessions#new'
	get '/signout', :to => 'sessions#destroy'

    get  '/contact', :to => 'pages#contact'
    get '/about',    :to => 'pages#about'
    get '/help',     :to => 'pages#help'
    get '/message',  :to => 'pages#message'

    get '/evenements', :to => 'pages#evenement'
	get '/newevenement', :to => 'evenements#new'
	get '/evenements/:id', :to => 'evenements#show', as: 
'feed_item_evenmt'

    get '/inscriptions/:id', :to => 'inscriptions#create',  as: 'ins_even'
	get '/inscriptions/:id', :to => 'inscriptions#destroy',  as: 'desins_even'

	get '/jaimes/:id', :to => 'jaimes#create',  as: 'aime_even'
	get '/jaimes/:id', :to => 'jaimes#destroy',  as: 'desaime_even'


	get '/interesses/:id', :to => 'interesses#create',  as: 'interesse_even'
	get '/interesses/:id', :to => 'interesses#destroy',  as: 'desinteresse_even'
	
	get '/temoignages/:id', :to => 'temoignages#new'
	get '/temoignages', :to => 'temoignages#show', as: 
'feed_item_temoignage'
	

   
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
