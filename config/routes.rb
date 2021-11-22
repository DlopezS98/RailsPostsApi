Rails.application.routes.draw do
  # devise_for :users
  namespace :v1 do
    # resources :auth
    get '/users', to: 'auth#index'
    get 'auth/sign_in'
    get 'auth/sign_up'
    # resources :auth, only: { :index }
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
