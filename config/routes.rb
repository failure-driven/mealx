Rails.application.routes.draw do
  namespace :admin do
    resources :food_items
    resources :locations
    resources :location_meals
    resources :meals
    resources :serving_times
    resources :users do
      member do
        get :send_user_registration
        get :send_admin_invitation
        get :send_beta_invitation
      end
    end

    root to: "users#index"
  end
  devise_for :users

  mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql" if Rails.env.development?
  post "/graphql", to: "graphql#execute"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # TODO: remove if we ever write any other tests
  get "test_root", to: "rails/welcome#index", as: "test_root_rails"

  # flipper route
  mount Flipper::UI.app(Flipper) => "/flipper"

  resources :recipes, only: [:index]

  resources :multiplier, only: [:index]
  get "/multiplier/*all" => "multiplier#index"

  resources :home, only: [:show] do
    collection do
      get :enable_flip
      get :disable_flip
    end
  end

  root to: "home#index"
end
