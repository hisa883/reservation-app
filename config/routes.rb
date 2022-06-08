Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root 'static_pages#top'
 
  get '/signup', to: 'users#new'

  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/auth/spotify/callback', to: 'users#spotify'
  
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users do
    member do
      get 'reservations'
      get 'reservations_list'
      get 'all_reservation'
    end
  end

  resources :stores do
    resources :reservations
  end
  # resources :password_resets, only: [:new, :create, :edit, :update]
end
