Rails.application.routes.draw do
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

      root 'home#index'

      get '/map'  => 'home#map', as: 'game'
      get '/map_gm'  => 'home#map_modal', as: 'game_gm'

      get '/newmayor/:id'  => 'cities#new_mayor', as: 'new_mayor'
      patch '/addmayor/:id'  => 'cities#add_mayor'


      #Rutas de sesiones
      get '/log-in' => 'sessions#new'
      post '/log-in' => 'sessions#create'
      get '/log-out' => 'sessions#destroy', as: :log_out

      resources :users, shallow: true do
            resources :factions, only: [:index] #rails falla al hacer new faction, ya que toma esta linea en vez de faction.
            post '/get_item', to: 'users#get_item'
            post '/use_item', to: 'users#use_item'
            resources :items, only: [:index]
            resources :points, only: [:index]
            post '/check_in', to: 'points#check_in'
            post '/check_out', to: 'points#check_out'
      end

      resources :users, only: [:new, :create], path_names: {new: :signup} do
      get 'validate/:token', on: :collection, to: :validate, as: :validate
    end

      resources :factions, shallow: true do
            post '/join_public', to: 'factions#join_public'
            post '/join_private', to: 'factions#join_private'
            post '/join_closed', to: 'factions#join_closed'
            post '/leave', to: 'factions#leave'
            resources :users, only: [:index]
            resources :points, only: [:index]
      end
      # factions/1/users
      # users/3

      resources :cities, shallow: true do
            resources :factions, only: [:index]
      end

      resources :items
      #do resources :user  no creo que sirva.

      resources :points, shallow: true do
            #get '/check_out', to: 'points#check_out'
            resources :users,  only: [:index]
      end
      get '/home/map_modal',:defaults =>{:format => 'js'}, to: 'home#map_modal', :as => :map_modal
      get '/checkpoints', to: 'points#checkpoints', :as => :checkpoints
      get '/checkpoints/all',:defaults =>{:format => 'json'}, to: 'points#all', :as => :all_points
      get '/checkpoints/foursquare',:defaults =>{:format => 'json'}, to: 'points#foursquare'
      get '/points/:id/add_pic', to: 'pictures#new', as: :point_add_pic


      resources :pictures
      resources :comments


      namespace :api do
            resources :users
            resources :points
            resources :cities
            resources :factions
            resources :items
            resources :comments
            resources :pictures

      end

end
