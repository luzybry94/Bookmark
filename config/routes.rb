Rails.application.routes.draw do
  
  root 'sessions#welcome'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  get '/auth/google_oauth2/callback' => 'sessions#omniauth_google'
  get '/auth/github/callback' => 'sessions#omniauth_github'
  
  # resources :genres 
  resources :comments, only: [:index, :new, :create]
  resources :books
  resources :users do
    resources :books, only: [:index, :new, :create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
