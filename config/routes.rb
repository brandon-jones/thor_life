Rails.application.routes.draw do
  resources :packages

  resources :carts

  resources :cart_items

  resources :perks

  resources :user_game_ids

  resources :game_instances

  resources :games do
    member do
      get '/get_game_instances' => 'games#get_game_instances'
    end
  end

  resources :comments

  resources :groupings

  resources :topics

  resources :forums do
    member do
      get '/new' => 'forums#new'
    end
    post :update_row_order, on: :collection
  end

  resources :admin_roles

  resources :users do
    member do
      get '/new_password' => 'users#new_password' , as: 'update_password'
      post 'image_upload' => 'users#image_upload'
    end
  end

  post 'cart/:id/delivered' => 'carts#delivered'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  get '/signup' => 'users#new'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'static_pages#index'

  # below this uncommented are for braintree

  post 'checkout' => 'static_pages#checkout'

  post 'add_to_cart' => 'carts#add_to_cart'
  delete 'remove_from_cart' => 'carts#remove_from_cart'
  get 'admin_panel' => 'static_pages#admin_panel'

  if Rails.env.development?
    get 'cert' => 'static_pages#cert'
  end

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
