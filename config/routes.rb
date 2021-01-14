Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # TODO: remove if we ever write any other tests
  get "test_root", to: "rails/welcome#index", as: "test_root_rails"

  # flipper route
  mount Flipper::UI.app(Flipper) => "/flipper"

  resources :home, only: [:show]
  root to: "home#index"
end
