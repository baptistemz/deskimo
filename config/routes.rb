Rails.application.routes.draw do
  # devise_for :companies
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'pages#home'

  resources :companies, only: [:index] do
    resources :desks, only: [:show] do
      resources :bookings, only: [:new, :create]
    end
  end

  resources :companies, only: [:new, :create, :edit, :update]

  namespace :account do
    resources :bookings, only: [:index, :show]
  end

  namespace :company_account do
    resources :desks, only: [:index, :show, :new, :create, :edit, :update]
    resources :bookings, only: [:index, :show, :edit, :update]
  end


end
