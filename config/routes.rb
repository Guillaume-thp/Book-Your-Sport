Rails.application.routes.draw do
  root to: 'users#index'
  get '/static_pages/team', to: 'static_pages#team'
  get '/static_pages/about', to: 'static_pages#about'
  devise_for :users
  resources :users
<<<<<<< HEAD
  resources :charges
  root to: 'users#index'
=======
  resources :timeslots
>>>>>>> 20aee43a015573e6db0bf168469eebe9b9aa5c5c
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
