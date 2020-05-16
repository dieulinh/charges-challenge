Rails.application.routes.draw do
  resources :payments
  resources :customers
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :charges, only: :index
  root to: 'charges#index'
end
