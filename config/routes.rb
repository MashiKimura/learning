Rails.application.routes.draw do
  devise_for :users
  root to: 'textbooks#index'
  resources :textbooks, only: [:new, :create, :show] do
    resources :records, only: [:new, :create]
    resources :goals, only: [:new, :create]
  end
  
end
