Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  
  scope :v1 do
    resources :pandals, only: [:index, :show] do
      get :nearby, on: :member # /v1/pandals/:id/nearby?type=Restaurant
    end

    resources :events, only: [:index]

    resources :plans, only: [:index, :show, :create, :update, :destroy] do
      resources :plan_stops, only: [:create, :update, :destroy]
    end

    resources :favorites, only: [:index, :create, :destroy]
  
    post "/estimate", to: "estimates#create" 
  end
end
