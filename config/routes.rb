Rails.application.routes.draw do
  #devise
  devise_for :users, controllers: { 
    :omniauth_callbacks => "users/omniauth_callbacks" 
  }

  root 'welcome#index'
  get "welcome" => "welcome#index"

  #frontend  
  resources :products, only:[:index, :show]
  resources :carts, only: [:create]
  resource :payment, only: [:create]
  get 'payments/new/:order_id', to: 'payments#new'

  resources :users do
      post 'set_admin', :on => :collection # /users/set_admin
                                          # member:  /users/123/set_admin
      post 'remove_admin', :on => :collection
  end


  resource :cart, only:[:index] do
      get 'view'
      get 'checkout'
      post 'add', path:'add/:id'
      post 'add_many', path:'add_many/:id'
      get 'clean'
      #checkout
  end

  resources :orders do
    member do
      post 'create_order_item'
    end
    collection do
      get 'search'
    end
  end

  #backend
  namespace :admin do
    resources :dashboards, only:[:index]
    resources :products do
      collection do
        get 'recycled'
      end
      member do
        post 'recycle'
        post 'unrecycle'
      end
    end
    resources :categories, except:[:show]
    resources :orders
  end

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
