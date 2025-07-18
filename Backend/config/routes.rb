Rails.application.routes.draw do
  mount Rswag::Ui::Engine => "/api-docs"
  mount Rswag::Api::Engine => "/api-docs"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :admin do
    resources :projects, only: [ :index ] do
      member do
        post "assign-project" => "projects#assign"
        post "unassign-project" => "projects#unassign"
      end
    end
    resources :users, only: [ :index ]
  end

  resources :projects, only: [ :index, :show ] do
    post "add-task", to: "tasks#add"
    delete "remove-task/:id", to: "tasks#remove"
  end

  post "login" => "auth#create"
end
