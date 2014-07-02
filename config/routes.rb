StaticDynamic::Application.routes.draw do

  #get "password_resets/new" #we make it a rsrc instd
  get "sessions/new"
	#allows REST-like urls for users to work(create, new, destroy etc actions)
	resources :users do
	#members allows a users/:id/following||followers sort of route
	#collection(in place of members) allows for users/:collection_get_page(e.g following for the members case) i.e w/ out an :id
		member do
			get :following, :followers
		end
	end
	
	#rsrc = indx,shw,nw,crt,edt,updt,dstry| :only lmts urls crtd
	resources :sessions, :only => [:new, :create, :destroy]
	resources :microposts, :only => [:create, :destroy]
	resources :relationships, :only => [:create, :destroy]  
	resources :password_resets
	resources :jobseekers  
	  
  #get "users/new" #no longer needed since the resources line above automatically adds these paths(is RESTful Users resource)
  
  get "pages/home"
  get "pages/contact"
  get "pages/about"
  get "pages/help"
  

  get '/signup', :to => 'users#new'
	get '/signin', :to => 'sessions#new'
	get '/signout', :to => 'sessions#destroy' 
  
  get '/contact', :to => 'pages#contact'	#book says to use 'match' in place of get 
	get '/about', :to => 'pages#about'	#but troubleshooting(integration tests))say 
	get '/help', :to => 'pages#help'	#use 'get' so...
	
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
