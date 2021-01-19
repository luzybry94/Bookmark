Rails.application.routes.draw do
  
  root 'sessions#welcome'

  get '/signup' => 'users#new'
  post '/signup' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'
  
  resources :genres 
  resources :comments
  resources :books do
    resources :comments
  end


  resources :users do
    resources :books, only: [:index, :new, :create]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
