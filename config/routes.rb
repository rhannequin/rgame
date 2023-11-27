Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", :as => :rails_health_check

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", :as => "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", :as => "sign_out"
  get "/sign_up" => "clearance/users#new", :as => "sign_up"

  root "pages#index"

  resources :planets, only: [:show] do
    resources :metal_mine_upgrades, only: [:create], module: :planets
  end
end
