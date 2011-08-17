L2adena::Application.routes.draw do

  match '/game/:action/(/:id)' => 'game_accounts'

  match '/signin' => 'services#signin'
  match '/signout' => 'services#signout'

  match '/auth/:service/callback' => 'services#create'
  match '/auth/failure' => 'services#failure'

  namespace 'admin' do
    root :to => 'home#index'

    resources :home, :only => [:index] do
      collection do
      end
    end

    resources :user
    resources :news
    resources :pages do
      member do
        get 'move_up'
        get 'move_down'
      end
    end
  end
  resources :tickets
  resources :services, :only => [:index, :create, :destroy] do
    collection do
      get 'signin'
      get 'signout'
      get 'signup'
      get 'register'
      post 'newaccount'
      get 'failure'
    end
  end
  
  resources :users, :only => [:index] do
    collection do
      get 'dismiss_newbie_bar'
      get 'undismiss_newbie_bar'
    end
  end


  match '/accounts/:action' => 'accounts'

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => "welcome#index"
  match '(/:id)' => 'home#show_page'

  root :to => 'home#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
