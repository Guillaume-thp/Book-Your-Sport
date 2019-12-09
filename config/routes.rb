Rails.application.routes.draw do
  get '/static_pages/team', to: 'static_pages#team'
  get '/static_pages/about', to: 'static_pages#about'
  devise_for :users
  resources :timeslots
  resources :users
  root to: 'users#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
