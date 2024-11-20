# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  get 'admin', to: 'main#admin'
  get 'admin/users/search', to: 'users#search'
  scope '/admin' do
    resources :users, only: %i[index update]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'teams/search', to: 'teams#search'
  get 'stadia/search', to: 'stadia#search'
  get 'fans/search', to: 'fans#search'
  get '/calendar', to: 'matches#calendar'
  get '/liga_top', to: 'fan_matches#liga_top'
  get '/gallery', to: 'matches#gallery'
  get '/gallery_show', to: 'matches#gallery_show'

  get 'matches/attached_photos', to: 'matches#attached_photos'
  delete '/deleted_attached_photos', to: 'matches#deleted_attached_photos'

  resources :news_stories
  resources :atributes
  resources :videos, except: :show
  resources :teams, except: %i[show destroy]
  resources :stadia, except: %i[show destroy]
  resources :seasons, except: %i[show destroy]
  resources :tournaments, except: %i[show destroy]
  resources :fans, except: :destroy
  resources :matches, except: :destroy
  resources :fan_matches, only: %i[new create destroy]
  resources :match_videos, only: %i[new create destroy]

  # Defines the root path route ("/")
  root 'main#index'
end
