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

  get 'teams/search', to: 'teams#search'
  get 'stadia/search', to: 'stadia#search'
  get 'fans/search', to: 'fans#search'
  
  resources :news_stories
  resources :atributes
  resources :videos, except: :show
  resources :teams, except: [:show, :destroy]
  resources :stadia, except: [:show, :destroy]
  resources :seasons, except: [:show, :destroy]
  resources :tournaments, except: [:show, :destroy]
  resources :fans, except: [:destroy]

  # Defines the root path route ("/")
  root "main#index"
end
