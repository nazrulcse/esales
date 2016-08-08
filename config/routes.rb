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
    get 'review', on: :member
  end
  resources :travels, only: [:index, :show] do
    get 'more', on: :collection
    get 'review', on: :member
  end
  resources :subscriber_transactions
  resources :products do
    get 'review', on: :member
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
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
