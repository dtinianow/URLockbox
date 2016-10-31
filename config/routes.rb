Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'home#show'

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/users/:user_id/links', to: 'links#index'
    end
  end

  resources :users, only: [:new, :create]
  resources :links, only: [:index, :create]

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
