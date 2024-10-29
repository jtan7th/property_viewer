Rails.application.routes.draw do
    root 'properties#index'
    resources :properties do
        collection do
            get 'filter_modal'
        end
    end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  # ... existing routes ...
get '/reports', to: 'reports#index'

resources :reports, only: [:index] do
  collection do
    get :export_csv
  end
end
end
