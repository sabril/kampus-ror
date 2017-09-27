Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/api/graphql"
  end

  namespace :api do
    scope module: :v2, constraints: ApiVersion.new('v2') do
      resources :courses, only: [:index]
    end
    scope module: :v1, constraints: ApiVersion.new('v1', true) do
      resources :courses do
        resources :tasks
      end
    end
    post "/graphql", to: "graphql#execute"
    post 'auth/login', to: 'authentication#authenticate'
    match '*path', :to => 'application#routing_error', via: :all
  end



  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  
  root to: "courses#index"
  get :home, to: "home#index"
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
  get :checkout, to: "carts#checkout"
  post :get_discount, to: "carts#get_discount"
  post "/payment_notification", to: "courses#payment_notification"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
