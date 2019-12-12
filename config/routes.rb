Rails.application.routes.draw do
  root to: 'static_pages#welcome'
  get '/static_pages/team', to: 'static_pages#team'
  get '/static_pages/about', to: 'static_pages#about'
  devise_for :users
  resources :users
  resources :timeslots
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
