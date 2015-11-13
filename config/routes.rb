Rails.application.routes.draw do
  devise_for :companies
  devise_for :users
  root to: 'pages#home'

  resources :companies, only: [:index, :show] do
    resources :desks, only: [:index, :show] do
      resources :bookings, only: [:new, :create]
    end
  end


  namespace :account do
    resources :bookings, only: [:index, :show]
  end

  namespace :company_account do
    resources :desks, only: [:index, :show, :new, :create, :edit, :update]
    resources :bookings, only: [:index, :show, :edit, :update]
  end



end
