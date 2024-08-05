Rails.application.routes.draw do
  devise_for :users

  get 'admin', to: 'main#admin'
  get 'admin/users/search', to: 'users#search'
  scope "/admin" do
    resources :users, only: [:index, :update]
  end
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :news_stories
  resources :atributes
  resources :videos, except: :show

  # Defines the root path route ("/")
  root "main#index"
end
