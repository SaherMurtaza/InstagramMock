Rails.application.routes.draw do
  root to: 'public#initialpage'
  devise_for :accounts, controllers: { 
    confirmations: 'accounts/confirmations',
    registrations: 'accounts/registrations'

   }

  resources :posts do
    resources :comments
  end
  resources :accounts, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
