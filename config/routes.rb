Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => :registrations}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get '/contact-us' => 'welcome#contact', as: :contact
  post '/save_contact' => 'welcome#save_contact'
  get '/about-us' => 'welcome#about', as: :about
  get '/settings' => 'welcome#settings', as: :settings

  get '/send' => 'welcome#send'
  post '/send' => 'welcome#send'

  get 'product_details' => 'welcome#product_details'
  get 'how-it-works' => 'welcome#how_it_works'
  # get 'set_locale' => 'welcome#set_locale'

  resources :order_details
  resources :orders
  resources :shopping_carts
  resources :line_items
  resources :services do
    get 'more', on: :collection
  end
  resources :subscriber_transactions
  resources :products do
    get 'review_product', on: :collection
    get 'set_language', on: :collection
    get 'more', on: :collection
  end
  resources :favorites do
    get 'delete_favorite', on: :collection
  end

  get 'account', to: 'accounts#account', as: :account

  resources :shopping_carts do
    member do
      get 'empty_cart'
    end
  end

  post 'user_authentication', to: 'welcome#user_authentication', as: :user_authentication


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
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
