Rails.application.routes.draw do
  root to: 'static_pages#welcome'
  get '/static_pages/team', to: 'static_pages#team'
  devise_for :users
  resources :users
  resources :charges
  root to: 'users#index'
  resources :timeslots
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
