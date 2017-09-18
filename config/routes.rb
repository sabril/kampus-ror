Rails.application.routes.draw do

  get 'carts/index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  root to: "courses#index"
  get :home, to: "home#index"
  get :checkout, to: "carts#checkout"

  resources :carts do
    member do
      post :checkout_notification
      get :remove_discount
    end
  end

  resources :cart_items, only: [:destroy]
  
  resources :courses do
    # courses/:id/subscribe
    member do
      get :subscribe
      get :add_to_cart
    end
    resources :tasks, only: [:show] do
      member do
        put :complete
      end
    end
    resources :reviews, only: [:create, :destroy]
  end
  
  get "/my_courses", to: "courses#my_courses"
  get "/my_cart", to: "carts#index"
  post "/payment_notification", to: "courses#payment_notification"
  post "/:id/checkout_notification", to: "carts#checkout_notification"
  post :get_discount, to: "carts#get_discount"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
