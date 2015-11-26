Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "registrations" }
  root to: 'pages#home'

  resources :companies, only: [:index] do
    resources :desks, only: [:show] do
      resources :bookings, only: [:new, :create]
    end
  end


  namespace :account do
    resources :companies, only: [:new, :create, :edit, :update] do
      resources :desks, only: [:new, :create, :edit, :index, :update, :destroy] do
        resource :activation, only: [:create, :destroy], controller: 'desks/activation'
      end
    end
    resources :bookings, only: [:index, :show, :edit, :update]
  end
end
