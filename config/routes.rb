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
      end
    end

    root to: "users#index"
  end
  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # TODO: remove if we ever write any other tests
  get "test_root", to: "rails/welcome#index", as: "test_root_rails"

  # flipper route
  mount Flipper::UI.app(Flipper) => "/flipper"

  resources :multiplier, only: [:index]

  resources :home, only: [:show]
  root to: "home#index"
end
