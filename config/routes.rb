Rails.application.routes.draw do

  root 'accounts#index'
  get '/confirmation_pending' => 'public#after_registration_path'

  devise_for :accounts, controllers: { 
    confirmations: 'accounts/confirmations',
    registrations: 'accounts/registrations',
    sessions: 'accounts/sessions',
    passwords: 'accounts/passwords',
   }

  resources :posts do
    resources :comments
  end
  resources :accounts, only: [:show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
