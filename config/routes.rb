Rails.application.routes.draw do
  root 'markets#index', as: :markets_index
  get '/markets/:id', to:'markets#show', as: :markets_show
  get '/markets/:id/payment', to:'markets#payment', as: :payment
  post '/markets/:id/payment', to:'markets#payment_process', as: :payment_process

  namespace :users do
    resources :products

    resource :profiles, except: [:index, :create]
  end

  get '/users/sign_up', to: 'users#sign_up', as: :sign_up
  post '/users/sign_up', to: 'users#sign_up_process', as: :sign_up_process
  get '/users/sign_in', to: 'users#sign_in', as: :sign_in
  post '/users/sign_in', to: 'users#sign_in_process', as: :sign_in_process
  get '/users/sign_out', to: 'users#sign_out', as: :sign_out
  get '/users/likes', to: 'users#show', as: :favorites
  get '/users/:id/likes', to: 'users#create', as: :create_favorite

end
