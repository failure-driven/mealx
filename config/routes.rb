Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # TODO: remove if we ever write any other tests
  get "test_root", to: "rails/welcome#index", as: "test_root_rails"
  # TODO: remove below once we have a proper root
  root to: "rails/welcome#index"
end
