Rails.application.routes.draw do
  # devise_for :users
  namespace :api do
    namespace :v1 do
      get '/users', to: 'auth#index'
      draw :auth
      draw :posts
    end
    # resources :auth, only: { :index }
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
